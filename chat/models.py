from django.db import models
from users.models import User

# Create your models here.

class ChatRoom(models.Model):
    owner = models.OneToOneField(User, on_delete=models.CASCADE, related_name='chat_room')
    name = models.CharField('聊天室名称', max_length=100)
    description = models.TextField('聊天室描述', blank=True)
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    is_active = models.BooleanField('是否活跃', default=True)
    
    class Meta:
        verbose_name = '聊天室'
        verbose_name_plural = verbose_name

class ChatMessage(models.Model):
    room = models.ForeignKey(ChatRoom, on_delete=models.CASCADE, related_name='messages')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    content = models.TextField('消息内容')
    created_at = models.DateTimeField('发送时间', auto_now_add=True)
    is_deleted = models.BooleanField('是否删除', default=False)
    
    class Meta:
        verbose_name = '聊天消息'
        verbose_name_plural = verbose_name
        ordering = ['created_at']

class ChatRoomMember(models.Model):
    room = models.ForeignKey(ChatRoom, on_delete=models.CASCADE, related_name='members')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    is_banned = models.BooleanField('是否被禁言', default=False)
    joined_at = models.DateTimeField('加入时间', auto_now_add=True)
    last_active = models.DateTimeField('最后活跃时间', auto_now=True)
    
    class Meta:
        verbose_name = '聊天室成员'
        verbose_name_plural = verbose_name
        unique_together = ['room', 'user']
