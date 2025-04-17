from django.contrib.auth.models import AbstractUser
from django.db import models
from django.conf import settings

class User(AbstractUser):
    ROLE_CHOICES = (
        ('student', '学生'),
        ('teacher', '教师'),
        ('admin', '管理员'),
    )
    
    role = models.CharField('角色', max_length=10, choices=ROLE_CHOICES, default='student')
    avatar = models.ImageField('头像', upload_to='avatars/', null=True, blank=True)
    phone = models.CharField('手机号', max_length=11, null=True, blank=True)
    is_verified = models.BooleanField('是否认证', default=False)
    
    @property
    def avatar_url(self):
        if self.avatar and hasattr(self.avatar, 'url'):
            return self.avatar.url
        return '/static/images/default-avatar.png'
    
    class Meta:
        verbose_name = '用户'
        verbose_name_plural = verbose_name

class TeacherVerification(models.Model):
    STATUS_CHOICES = (
        ('pending', '待审核'),
        ('approved', '已通过'),
        ('rejected', '已拒绝'),
    )
    
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='verification')
    certificate = models.ImageField('教师资格证', upload_to='certificates/')
    description = models.TextField('认证说明')
    status = models.CharField('审核状态', max_length=20, choices=STATUS_CHOICES, default='pending')
    created_at = models.DateTimeField('申请时间', auto_now_add=True)
    updated_at = models.DateTimeField('更新时间', auto_now=True)
    
    class Meta:
        verbose_name = '教师认证'
        verbose_name_plural = verbose_name
