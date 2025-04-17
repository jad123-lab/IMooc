import json
from channels.generic.websocket import AsyncWebsocketConsumer
from channels.db import database_sync_to_async
from django.utils import timezone
from .models import ChatRoom, ChatMessage, ChatRoomMember
from asgiref.sync import async_to_sync

class ChatConsumer(AsyncWebsocketConsumer):
    connected_users = set()  # 用于存储连接的用户

    async def connect(self):
        """建立WebSocket连接"""
        try:
            # 检查用户认证
            if not self.scope["user"].is_authenticated:
                await self.close()
                return
            
            # 获取房间ID或视频ID
            self.room_id = self.scope['url_route']['kwargs'].get('room_id')
            self.video_id = self.scope['url_route']['kwargs'].get('video_id')
            
            if not (self.room_id or self.video_id):
                await self.close()
                return
            
            if self.room_id:
                self.room_group_name = f'chat_{self.room_id}'
            else:
                self.room_group_name = f'video_{self.video_id}'
            
            # 将当前channel加入群组
            await self.channel_layer.group_add(
                self.room_group_name,
                self.channel_name
            )
            
            # 添加用户到在线集合
            self.user_id = str(self.scope["user"].id)
            ChatConsumer.connected_users.add(self.user_id)
            
            # 接受WebSocket连接
            await self.accept()
            
            # 发送连接成功消息
            await self.send(text_data=json.dumps({
                'type': 'connection_established',
                'message': '连接成功'
            }))

            # 广播在线人数
            await self.channel_layer.group_send(
                self.room_group_name,
                {
                    'type': 'online_count',
                    'count': len(ChatConsumer.connected_users)
                }
            )

        except Exception as e:
            print(f"Connection error: {e}")
            await self.close()

    async def disconnect(self, close_code):
        """断开WebSocket连接"""
        if hasattr(self, 'room_group_name'):
            # 将当前channel从群组中移除
            await self.channel_layer.group_discard(
                self.room_group_name,
                self.channel_name
            )
            
            # 从在线集合中移除用户
            if hasattr(self, 'user_id'):
                ChatConsumer.connected_users.discard(self.user_id)
                
                # 广播更新后的在线人数
                await self.channel_layer.group_send(
                    self.room_group_name,
                    {
                        'type': 'online_count',
                        'count': len(ChatConsumer.connected_users)
                    }
                )

    async def receive(self, text_data):
        """接收WebSocket消息"""
        try:
            data = json.loads(text_data)
            message_type = data.get('type', 'message')
            content = data.get('content', '')
            
            if message_type == 'message':
                # 广播消息给群组
                await self.channel_layer.group_send(
                    self.room_group_name,
                    {
                        'type': 'chat_message',
                        'message': {
                            'user': self.scope['user'].username,
                            'content': content,
                            'timestamp': timezone.now().isoformat()
                        }
                    }
                )
        except Exception as e:
            print(f"Error in receive: {e}")

    async def chat_message(self, event):
        """发送聊天消息给WebSocket"""
        try:
            await self.send(text_data=json.dumps(event['message']))
        except Exception as e:
            print(f"Error in chat_message: {e}")

    async def online_count(self, event):
        """发送在线人数给WebSocket"""
        await self.send(text_data=json.dumps({
            'type': 'online_count',
            'count': event['count']
        }))

    @database_sync_to_async
    def save_message(self, content):
        """保存消息到数据库"""
        if not self.room_id:
            return
            
        room = ChatRoom.objects.get(id=self.room_id)
        return ChatMessage.objects.create(
            room=room,
            user=self.scope['user'],
            content=content
        )

    @database_sync_to_async
    def update_member_status(self, is_online):
        """更新成员在线状态"""
        if not self.room_id:
            return
            
        member = ChatRoomMember.objects.filter(
            room_id=self.room_id,
            user=self.scope['user']
        ).first()
        
        if member:
            member.is_online = is_online
            member.last_active = timezone.now()
            member.save()

    @database_sync_to_async
    def get_online_count(self):
        """获取在线人数"""
        if not self.room_id:
            return 0
            
        return ChatRoomMember.objects.filter(
            room_id=self.room_id,
            is_online=True
        ).count()

    async def update_online_count(self):
        """更新并广播在线人数"""
        count = await self.get_online_count()
        
        # 广播在线人数
        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type': 'online_count',
                'count': count
            }
        ) 