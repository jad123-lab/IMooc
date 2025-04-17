from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import ChatRoom, ChatMessage, ChatRoomMember
from django.utils import timezone

@login_required
def room_list(request):
    """聊天室列表"""
    rooms = ChatRoom.objects.filter(status='active')
    return render(request, 'chat/room_list.html', {'rooms': rooms})

@login_required
def room_detail(request, room_id):
    """聊天室详情"""
    room = get_object_or_404(ChatRoom, id=room_id)
    if room.status != 'active':
        messages.error(request, '该聊天室已关闭')
        return redirect('chat:room_list')
    
    # 检查用户是否被禁言
    member = ChatRoomMember.objects.filter(room=room, user=request.user).first()
    if member and member.is_banned:
        messages.error(request, '您已被禁言')
        return redirect('chat:room_list')
    
    # 如果用户不是成员,自动加入
    if not member:
        member = ChatRoomMember.objects.create(
            room=room,
            user=request.user,
            joined_at=timezone.now()
        )
    
    messages = ChatMessage.objects.filter(room=room).order_by('-created_at')[:50]
    return render(request, 'chat/room_detail.html', {
        'room': room,
        'messages': messages,
        'member': member
    })

@login_required
def create_room(request):
    """创建聊天室(教师)"""
    if request.user.role != 'teacher':
        messages.error(request, '只有教师才能创建聊天室')
        return redirect('chat:room_list')
    
    if request.method == 'POST':
        # TODO: 实现创建聊天室的逻辑
        pass
    return render(request, 'chat/create_room.html')

@login_required
def edit_room(request, room_id):
    """编辑聊天室(教师)"""
    room = get_object_or_404(ChatRoom, id=room_id, owner=request.user)
    if request.user.role != 'teacher':
        messages.error(request, '只有教师才能编辑聊天室')
        return redirect('chat:room_list')
    
    if request.method == 'POST':
        # TODO: 实现编辑聊天室的逻辑
        pass
    return render(request, 'chat/edit_room.html', {'room': room})

@login_required
def manage_members(request, room_id):
    """管理聊天室成员(教师)"""
    room = get_object_or_404(ChatRoom, id=room_id, owner=request.user)
    if request.user.role != 'teacher':
        messages.error(request, '只有教师才能管理成员')
        return redirect('chat:room_list')
    
    members = ChatRoomMember.objects.filter(room=room)
    return render(request, 'chat/manage_members.html', {
        'room': room,
        'members': members
    })

@login_required
def room_messages(request, room_id):
    """WebSocket消息处理"""
    # TODO: 实现WebSocket消息处理逻辑
    pass
