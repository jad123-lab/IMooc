from django.db import models
from users.models import User

class Category(models.Model):
    name = models.CharField('分类名称', max_length=50)
    description = models.TextField('分类描述', blank=True)
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    
    class Meta:
        verbose_name = '视频分类'
        verbose_name_plural = verbose_name
        
    def __str__(self):
        return self.name

class Video(models.Model):
    title = models.CharField('标题', max_length=200)
    description = models.TextField('描述')
    file = models.FileField('视频文件', upload_to='videos/')
    cover = models.ImageField('封面图', upload_to='covers/')
    category = models.ForeignKey(Category, on_delete=models.CASCADE, verbose_name='分类')
    author = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='作者')
    views = models.IntegerField('观看次数', default=0)
    likes = models.IntegerField('点赞数', default=0)
    status = models.CharField('状态', max_length=20, choices=(
        ('draft', '草稿'),
        ('pending', '待审核'),
        ('published', '已发布'),
        ('rejected', '已拒绝'),
    ), default='draft')
    created_at = models.DateTimeField('创建时间', auto_now_add=True)
    updated_at = models.DateTimeField('更新时间', auto_now=True)
    
    class Meta:
        verbose_name = '视频'
        verbose_name_plural = verbose_name
        ordering = ['-created_at']
    
    def __str__(self):
        return self.title

class VideoView(models.Model):
    video = models.ForeignKey(Video, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    viewed_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        verbose_name = '视频观看记录'
        verbose_name_plural = verbose_name
        unique_together = ['video', 'user']

class VideoLike(models.Model):
    video = models.ForeignKey(Video, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        verbose_name = '视频点赞'
        verbose_name_plural = verbose_name
        unique_together = ['video', 'user']
