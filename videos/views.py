from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Video, Category, VideoView
from comments.models import Comment
from django.utils import timezone
from django.http import JsonResponse
from django.db.models import Q, Count

def video_list(request):
    """视频列表页"""
    videos = Video.objects.filter(
        status='published'
    ).order_by('-created_at').annotate(
        view_count=Count('videoview', distinct=True),
        like_count=Count('videolike', distinct=True),
        comment_count=Count('comments', distinct=True)
    )
    categories = Category.objects.all()
    return render(request, 'videos/video_list.html', {
        'videos': videos,
        'categories': categories
    })

def video_search(request):
    """视频搜索"""
    query = request.GET.get('q', '')
    videos = Video.objects.filter(
        status='published'
    ).order_by('-created_at').annotate(
        view_count=Count('videoview', distinct=True),
        like_count=Count('videolike', distinct=True),
        comment_count=Count('comments', distinct=True)
    )
    
    if query:
        videos = videos.filter(
            Q(title__icontains=query) |
            Q(description__icontains=query)
        )
    
    categories = Category.objects.all()
    return render(request, 'videos/video_list.html', {
        'videos': videos,
        'categories': categories,
        'query': query
    })

def video_by_category(request, category_id):
    """按分类查看视频"""
    category = get_object_or_404(Category, id=category_id)
    videos = Video.objects.filter(
        category=category,
        status='published'
    ).order_by('-created_at').annotate(
        view_count=Count('videoview', distinct=True),
        like_count=Count('videolike', distinct=True),
        comment_count=Count('comments', distinct=True)
    )
    categories = Category.objects.all()
    return render(request, 'videos/video_list.html', {
        'videos': videos,
        'categories': categories,
        'current_category': category
    })

@login_required
def video_detail(request, video_id):
    """视频详情"""
    video = get_object_or_404(Video, id=video_id)
    
    # 记录观看次数
    if request.user.is_authenticated:
        VideoView.objects.get_or_create(
            video=video,
            user=request.user,
            defaults={'viewed_at': timezone.now()}
        )
        
    # 获取视频统计信息
    video = Video.objects.filter(id=video_id).annotate(
        view_count=Count('videoview', distinct=True),
        like_count=Count('videolike', distinct=True),
        comment_count=Count('comments', distinct=True)
    ).first()
    
    # 获取未删除的评论
    comments = Comment.objects.filter(
        video=video,
        is_deleted=False
    ).select_related('user').order_by('-created_at')
    
    context = {
        'video': video,
        'comments': comments,
    }
    return render(request, 'videos/video_detail.html', context)

@login_required
def video_like(request, video_id):
    """视频点赞"""
    if request.method != 'POST':
        return JsonResponse({'status': 'error', 'message': '不支持的请求方法'})
        
    video = get_object_or_404(Video, id=video_id)
    like, created = video.videolike_set.get_or_create(user=request.user)
    
    if created:
        video.likes += 1
        video.save()
        return JsonResponse({'status': 'success', 'likes': video.likes})
    else:
        # 取消点赞
        like.delete()
        video.likes -= 1
        video.save()
        return JsonResponse({'status': 'success', 'likes': video.likes})

@login_required
def video_upload(request):
    """上传视频"""
    if request.user.role != 'teacher':
        messages.error(request, '只有教师才能上传视频')
        return redirect('videos:list')
        
    if request.method == 'POST':
        title = request.POST.get('title')
        description = request.POST.get('description')
        category_id = request.POST.get('category')
        video_file = request.FILES.get('video')
        cover = request.FILES.get('cover')
        
        if all([title, description, category_id, video_file, cover]):
            try:
                video = Video.objects.create(
                    title=title,
                    description=description,
                    category_id=category_id,
                    file=video_file,
                    cover=cover,
                    author=request.user,
                    status='pending'
                )
                messages.success(request, '视频上传成功，等待审核')
                return redirect('videos:manage')
            except Exception as e:
                messages.error(request, f'上传失败：{str(e)}')
        else:
            messages.error(request, '请填写所有必填字段')
    
    categories = Category.objects.all()
    return render(request, 'videos/video_upload.html', {
        'categories': categories
    })

@login_required
def video_manage(request):
    """教师的视频管理"""
    if request.user.role != 'teacher':
        messages.error(request, '只有教师才能管理视频')
        return redirect('videos:list')
    
    videos = Video.objects.filter(author=request.user).select_related('category').annotate(
        view_count=Count('videoview', distinct=True),
        like_count=Count('videolike', distinct=True),
        comment_count=Count('comments', distinct=True)
    ).order_by('-created_at')
    
    return render(request, 'videos/video_manage.html', {
        'videos': videos
    })

@login_required
def video_edit(request, video_id):
    """编辑视频"""
    video = get_object_or_404(Video, id=video_id, author=request.user)
    if request.user.role != 'teacher':
        messages.error(request, '只有教师才能编辑视频')
        return redirect('videos:list')
    
    if request.method == 'POST':
        title = request.POST.get('title')
        description = request.POST.get('description')
        category_id = request.POST.get('category')
        
        if all([title, description, category_id]):
            try:
                video.title = title
                video.description = description
                video.category_id = category_id
                
                # 处理封面图片
                if 'cover' in request.FILES:
                    video.cover = request.FILES['cover']
                
                # 处理视频文件
                if 'video' in request.FILES:
                    video.file = request.FILES['video']
                
                video.save()
                messages.success(request, '视频更新成功')
                return redirect('videos:manage')
            except Exception as e:
                messages.error(request, f'更新失败：{str(e)}')
        else:
            messages.error(request, '请填写所有必填字段')
    
    categories = Category.objects.all()
    return render(request, 'videos/video_edit.html', {
        'video': video,
        'categories': categories
    })

@login_required
def video_delete(request, video_id):
    """删除视频"""
    video = get_object_or_404(Video, id=video_id, author=request.user)
    if request.user.role != 'teacher':
        messages.error(request, '只有教师才能删除视频')
        return redirect('videos:list')
    video.delete()
    messages.success(request, '视频已删除')
    return redirect('videos:manage')
