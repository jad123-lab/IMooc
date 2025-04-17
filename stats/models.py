from django.db import models
from users.models import User
from videos.models import Video

# Create your models here.

class DailyStatistics(models.Model):
    date = models.DateField('统计日期', unique=True)
    total_users = models.IntegerField('总用户数', default=0)
    new_users = models.IntegerField('新增用户数', default=0)
    active_users = models.IntegerField('活跃用户数', default=0)
    total_videos = models.IntegerField('总视频数', default=0)
    new_videos = models.IntegerField('新增视频数', default=0)
    total_views = models.IntegerField('总观看次数', default=0)
    total_comments = models.IntegerField('总评论数', default=0)
    
    class Meta:
        verbose_name = '每日统计'
        verbose_name_plural = verbose_name
        ordering = ['-date']

class UserStatistics(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='statistics')
    total_videos = models.IntegerField('发布视频数', default=0)
    total_views = models.IntegerField('获得观看数', default=0)
    total_likes = models.IntegerField('获得点赞数', default=0)
    total_comments = models.IntegerField('获得评论数', default=0)
    last_updated = models.DateTimeField('最后更新时间', auto_now=True)
    
    class Meta:
        verbose_name = '用户统计'
        verbose_name_plural = verbose_name

class VideoStatistics(models.Model):
    video = models.OneToOneField(Video, on_delete=models.CASCADE, related_name='statistics')
    daily_views = models.IntegerField('日观看数', default=0)
    daily_likes = models.IntegerField('日点赞数', default=0)
    daily_comments = models.IntegerField('日评论数', default=0)
    last_updated = models.DateTimeField('最后更新时间', auto_now=True)
    
    class Meta:
        verbose_name = '视频统计'
        verbose_name_plural = verbose_name
