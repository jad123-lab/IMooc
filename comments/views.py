from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import JsonResponse
from .models import Comment, CommentLike
from videos.models import Video

# Create your views here.

@login_required
def add_comment(request, video_id):
    """添加评论"""
    if request.method == 'POST':
        video = get_object_or_404(Video, id=video_id)
        content = request.POST.get('content')
        
        if content:
            comment = Comment.objects.create(
                video=video,
                user=request.user,
                content=content
            )
            
            # 返回JSON响应
            return JsonResponse({
                'status': 'success',
                'message': '评论成功',
                'comment': {
                    'id': comment.id,
                    'content': comment.content,
                    'user': comment.user.username,
                    'created_at': comment.created_at.strftime('%Y-%m-%d %H:%M'),
                    'likes_count': 0
                }
            })
        
    return JsonResponse({'status': 'error', 'message': '评论失败'})

@login_required
def reply_comment(request, comment_id):
    """回复评论"""
    if request.method != 'POST':
        return JsonResponse({'status': 'error', 'message': '无效的请求方法'})
    
    parent_comment = get_object_or_404(Comment, id=comment_id)
    content = request.POST.get('content')
    
    if not content:
        return JsonResponse({'status': 'error', 'message': '回复内容不能为空'})
    
    reply = Comment.objects.create(
        video=parent_comment.video,
        user=request.user,
        content=content,
        parent=parent_comment
    )
    
    return JsonResponse({
        'status': 'success',
        'message': '回复成功',
        'reply': {
            'id': reply.id,
            'content': reply.content,
            'user': reply.user.username,
            'created_at': reply.created_at.strftime('%Y-%m-%d %H:%M:%S')
        }
    })

@login_required
def like_comment(request, comment_id):
    try:
        comment = Comment.objects.get(id=comment_id)
        like, created = CommentLike.objects.get_or_create(user=request.user, comment=comment)
        
        if not created:  # 如果已经点过赞，则取消点赞
            like.delete()
            is_liked = False
        else:
            is_liked = True
            
        likes_count = comment.comment_likes.count()
        
        return JsonResponse({
            'status': 'success',
            'is_liked': is_liked,
            'likes_count': likes_count
        })
    except Comment.DoesNotExist:
        return JsonResponse({
            'status': 'error',
            'message': '评论不存在'
        }, status=404)
    except Exception as e:
        return JsonResponse({
            'status': 'error',
            'message': str(e)
        }, status=500)

@login_required
def delete_comment(request, comment_id):
    """删除评论"""
    comment = get_object_or_404(Comment, id=comment_id)
    
    # 只有评论作者或视频作者可以删除评论
    if request.user != comment.user and request.user != comment.video.author:
        return JsonResponse({'status': 'error', 'message': '没有权限删除此评论'})
    
    comment.delete()
    return JsonResponse({'status': 'success', 'message': '评论已删除'})

def comment_list(request, video_id):
    """获取评论列表"""
    video = get_object_or_404(Video, id=video_id)
    comments = Comment.objects.filter(video=video, parent=None).order_by('-created_at')
    
    # 分页处理
    page = request.GET.get('page', 1)
    per_page = 20
    start = (int(page) - 1) * per_page
    end = start + per_page
    
    comments_data = []
    for comment in comments[start:end]:
        # 获取回复
        replies = Comment.objects.filter(parent=comment).order_by('created_at')
        replies_data = [{
            'id': reply.id,
            'content': reply.content,
            'user': reply.user.username,
            'created_at': reply.created_at.strftime('%Y-%m-%d %H:%M:%S'),
            'likes': reply.likes.count()
        } for reply in replies]
        
        comments_data.append({
            'id': comment.id,
            'content': comment.content,
            'user': comment.user.username,
            'created_at': comment.created_at.strftime('%Y-%m-%d %H:%M:%S'),
            'likes': comment.likes.count(),
            'replies': replies_data
        })
    
    return JsonResponse({
        'status': 'success',
        'comments': comments_data,
        'total': comments.count(),
        'has_more': end < comments.count()
    })
