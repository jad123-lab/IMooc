from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.views.decorators.cache import never_cache
from django.views.decorators.http import require_POST, require_http_methods
from django.contrib import messages
from django.core.paginator import Paginator
from django.db.models import Q, Count, Sum
from django.utils import timezone
from users.models import User, TeacherVerification
from django.http import JsonResponse
from videos.models import Video, Category, VideoView
from comments.models import Comment, CommentLike
from chat.models import ChatRoom, ChatMessage, ChatRoomMember
from django.template.loader import render_to_string
from stats.models import DailyStatistics, UserStatistics, VideoStatistics
from .decorators import admin_required
import datetime
import json
from django.contrib.auth import login, logout

# Create your views here.

@never_cache
def index(request):
    """管理后台首页"""
    return redirect('myadmin:dashboard')

@never_cache
@admin_required
def dashboard(request):
    """控制面板"""
    # 获取基础统计数据
    total_users = User.objects.count()
    total_videos = Video.objects.count()
    total_comments = Comment.objects.count()
    total_views = VideoView.objects.count()
    
    # 获取最近注册的用户
    recent_users = User.objects.order_by('-date_joined')[:5]
    
    # 获取最近的视频
    recent_videos = Video.objects.order_by('-created_at')[:5]
    
    context = {
        'total_users': total_users,
        'total_videos': total_videos,
        'total_comments': total_comments,
        'total_views': total_views,
        'recent_users': recent_users,
        'recent_videos': recent_videos,
    }
    
    return render(request, 'admin/dashboard.html', context)

@login_required
@never_cache
def user_list(request):
    """用户列表"""
    search_query = request.GET.get('q', '')
    role = request.GET.get('role', '')
    
    users = User.objects.all()
    
    if search_query:
        users = users.filter(
            Q(username__icontains=search_query) |
            Q(email__icontains=search_query)
        )
    
    if role:
        users = users.filter(role=role)
    
    paginator = Paginator(users.order_by('-date_joined'), 10)
    page = request.GET.get('page', 1)
    users = paginator.get_page(page)
    
    return render(request, 'admin/user_list.html', {
        'users': users,
        'search_query': search_query,
        'role': role
    })

@login_required
@never_cache
def user_add(request):
    """添加用户"""
    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        password1 = request.POST.get('password1')
        password2 = request.POST.get('password2')
        role = request.POST.get('role')
        phone = request.POST.get('phone')
        avatar = request.FILES.get('avatar')
        
        if password1 != password2:
            messages.error(request, '两次输入的密码不一致')
            return redirect('myadmin:user_add')
        
        if User.objects.filter(username=username).exists():
            messages.error(request, '用户名已存在')
            return redirect('myadmin:user_add')
        
        if User.objects.filter(email=email).exists():
            messages.error(request, '邮箱已存在')
            return redirect('myadmin:user_add')
        
        user = User.objects.create_user(
            username=username,
            email=email,
            password=password1,
            role=role,
            phone=phone
        )
        
        if avatar:
            user.avatar = avatar
            user.save()
        
        messages.success(request, '用户添加成功')
        return redirect('myadmin:user_list')
    
    return render(request, 'admin/user_form.html')

@login_required
@never_cache
def user_edit(request, user_id):
    """编辑用户"""
    user_obj = get_object_or_404(User, id=user_id)
    
    if request.method == 'POST':
        email = request.POST.get('email')
        role = request.POST.get('role')
        phone = request.POST.get('phone')
        avatar = request.FILES.get('avatar')
        
        if User.objects.exclude(id=user_id).filter(email=email).exists():
            messages.error(request, '邮箱已存在')
            return redirect('myadmin:user_edit', user_id=user_id)
        
        user_obj.email = email
        user_obj.role = role
        user_obj.phone = phone
        
        if avatar:
            user_obj.avatar = avatar
        
        user_obj.save()
        messages.success(request, '用户信息更新成功')
        return redirect('myadmin:user_list')
    
    return render(request, 'admin/user_form.html', {
        'user_obj': user_obj
    })

@require_POST
@admin_required
def user_delete(request, user_id):
    """删除用户"""
    user = get_object_or_404(User, id=user_id)
    
    if user.username == 'admin':
        return JsonResponse({
            'status': 'error',
            'message': '不能删除管理员账号'
        })
    
    user.delete()
    return JsonResponse({
        'status': 'success',
        'message': '用户删除成功'
    })

@require_POST
@admin_required
def toggle_user_status(request, user_id):
    """切换用户状态"""
    user = get_object_or_404(User, id=user_id)
    
    if user.username == 'admin':
        return JsonResponse({
            'status': 'error',
            'message': '不能禁用管理员账号'
        })
    
    user.is_active = not user.is_active
    user.save()
    
    return JsonResponse({
        'status': 'success',
        'is_active': user.is_active
    })

@login_required
@never_cache
def teacher_verification(request):
    """教师认证管理"""
    verifications = TeacherVerification.objects.select_related('user').order_by('-created_at')
    
    paginator = Paginator(verifications, 10)
    page = request.GET.get('page', 1)
    verifications = paginator.get_page(page)
    
    return render(request, 'admin/teacher_verification.html', {
        'verifications': verifications
    })

@never_cache
@admin_required
def admin_list(request):
    """管理员列表"""
    search_query = request.GET.get('q', '')
    
    admins = User.objects.filter(role='admin')
    
    if search_query:
        admins = admins.filter(
            Q(username__icontains=search_query) |
            Q(email__icontains=search_query)
        )
    
    paginator = Paginator(admins, 10)
    page = request.GET.get('page', 1)
    admins = paginator.get_page(page)
    
    context = {
        'title': '管理员列表',
        'admins': admins,
        'search_query': search_query,
    }
    return render(request, 'admin/admin_list.html', context)

@never_cache
@admin_required
def video_list(request):
    """视频列表"""
    search_query = request.GET.get('q', '')
    category_id = request.GET.get('category', '')
    status = request.GET.get('status', '')
    
    videos = Video.objects.all().select_related('author', 'category').order_by('-created_at')
    
    if search_query:
        videos = videos.filter(
            Q(title__icontains=search_query) |
            Q(description__icontains=search_query)
        )
    
    if category_id:
        videos = videos.filter(category_id=category_id)
        
    if status:
        videos = videos.filter(status=status)
    
    categories = Category.objects.all()
    
    paginator = Paginator(videos, 10)
    page = request.GET.get('page')
    videos = paginator.get_page(page)
    
    return render(request, 'admin/video_list.html', {
        'videos': videos,
        'categories': categories,
        'search_query': search_query,
        'category_id': category_id,
        'status': status
    })

@admin_required
@require_http_methods(['GET'])
def video_detail(request, video_id):
    """获取视频详情"""
    video = get_object_or_404(Video.objects.select_related('category'), id=video_id)
    data = {
        'id': video.id,
        'title': video.title,
        'description': video.description,
        'category_id': video.category_id,
        'video_url': video.file.url if hasattr(video, 'file') and video.file else '',
        'cover_url': video.cover.url if hasattr(video, 'cover') and video.cover else '/static/images/default-cover.jpg',
        'status': video.status
    }
    return JsonResponse(data)

@require_http_methods(['POST'])
@admin_required
def video_add(request):
    """添加视频"""
    try:
        title = request.POST['title']
        description = request.POST['description']
        category_id = request.POST['category']
        file = request.FILES['video']
        cover = request.FILES.get('cover')
        
        video = Video.objects.create(
            title=title,
            description=description,
            category_id=category_id,
            file=file,
            cover=cover,
            author=request.user,
            status='pending'
        )
        
        return JsonResponse({'status': 'success', 'video_id': video.id})
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': str(e)})

@require_http_methods(['POST'])
@admin_required
def video_edit(request, video_id):
    """编辑视频"""
    video = get_object_or_404(Video, id=video_id)
    try:
        video.title = request.POST['title']
        video.description = request.POST['description']
        video.category_id = request.POST['category']
        
        if 'video' in request.FILES:
            video.file = request.FILES['video']
        if 'cover' in request.FILES:
            video.cover = request.FILES['cover']
            
        video.save()
        return JsonResponse({'status': 'success'})
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': str(e)})

@require_http_methods(['POST'])
@admin_required
def video_delete(request, video_id):
    """删除视频"""
    video = get_object_or_404(Video, id=video_id)
    try:
        video.delete()
        return JsonResponse({'status': 'success'})
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': str(e)})

@require_http_methods(['POST'])
@admin_required
def video_status(request, video_id):
    """更新视频状态"""
    video = get_object_or_404(Video, id=video_id)
    try:
        data = json.loads(request.body)
        status = data.get('status')
        if status not in ['pending', 'published', 'rejected']:
            raise ValueError('Invalid status')
            
        video.status = status
        video.save()
        return JsonResponse({'status': 'success'})
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': str(e)})

@never_cache
@admin_required
def video_category(request):
    """视频分类管理"""
    if request.method == 'POST':
        action = request.POST.get('action')
        if action == 'add':
            name = request.POST.get('name')
            description = request.POST.get('description')
            if name and description:
                Category.objects.create(name=name, description=description)
                messages.success(request, '分类添加成功')
            else:
                messages.error(request, '请填写完整的分类信息')
        elif action == 'edit':
            category_id = request.POST.get('category_id')
            name = request.POST.get('name')
            description = request.POST.get('description')
            if category_id and name and description:
                category = get_object_or_404(Category, id=category_id)
                category.name = name
                category.description = description
                category.save()
                messages.success(request, '分类更新成功')
            else:
                messages.error(request, '请填写完整的分类信息')
        elif action == 'delete':
            category_id = request.POST.get('category_id')
            if category_id:
                category = get_object_or_404(Category, id=category_id)
                if category.video_set.exists():
                    messages.error(request, '该分类下还有视频，无法删除')
                else:
                    category.delete()
                    messages.success(request, '分类删除成功')
            else:
                messages.error(request, '请选择要删除的分类')
    
    categories = Category.objects.all()
    context = {
        'title': '分类管理',
        'categories': categories,
    }
    return render(request, 'admin/video_category.html', context)

@login_required
@never_cache
def video_pending(request):
    """待审核视频"""
    videos = Video.objects.filter(status='pending').select_related('author', 'category')
    
    paginator = Paginator(videos, 10)
    page = request.GET.get('page', 1)
    videos = paginator.get_page(page)
    
    context = {
        'title': '待审核视频',
        'videos': videos,
    }
    return render(request, 'admin/video_pending.html', context)

@login_required
@never_cache
def comment_list(request):
    """评论管理"""
    search_query = request.GET.get('q', '')
    video_id = request.GET.get('video', '')
    is_deleted = request.GET.get('is_deleted', '')
    
    comments = Comment.objects.all().select_related('user', 'video')
    
    if search_query:
        comments = comments.filter(
            Q(content__icontains=search_query) |
            Q(user__username__icontains=search_query) |
            Q(video__title__icontains=search_query)
        )
    
    if video_id:
        comments = comments.filter(video_id=video_id)
        
    if is_deleted:
        comments = comments.filter(is_deleted=is_deleted == 'true')
    
    paginator = Paginator(comments, 10)
    page = request.GET.get('page', 1)
    comments = paginator.get_page(page)
    
    videos = Video.objects.filter(status='published')
    
    context = {
        'title': '评论管理',
        'comments': comments,
        'videos': videos,
        'search_query': search_query,
        'video_id': video_id,
        'is_deleted': is_deleted,
    }
    return render(request, 'admin/comment_list.html', context)

@login_required
@never_cache
def chat_list(request):
    """聊天室管理"""
    # 获取搜索参数
    search_query = request.GET.get('q', '')
    is_active = request.GET.get('is_active', '')
    
    # 查询聊天室
    rooms = ChatRoom.objects.all()
    
    # 应用搜索过滤
    if search_query:
        rooms = rooms.filter(
            Q(name__icontains=search_query) |
            Q(description__icontains=search_query) |
            Q(owner__username__icontains=search_query)
        )
    
    # 按状态过滤
    if is_active == 'true':
        rooms = rooms.filter(is_active=True)
    elif is_active == 'false':
        rooms = rooms.filter(is_active=False)
    
    # 分页
    paginator = Paginator(rooms.order_by('-created_at'), 10)
    page = request.GET.get('page', 1)
    rooms = paginator.get_page(page)
    
    context = {
        'rooms': rooms,
        'search_query': search_query,
        'is_active': is_active,
    }
    
    return render(request, 'admin/chat_list.html', context)

@login_required
@never_cache
def stats_overview(request):
    """统计概览"""
    today = timezone.localtime().date()
    
    # 获取今日统计数据
    daily_stats = DailyStatistics.objects.filter(date=today).first()
    if not daily_stats:
        daily_stats = DailyStatistics(date=today)
        
    # 获取用户总数和分布
    total_users = User.objects.count()
    user_distribution = {
        'normal': User.objects.filter(role='normal').count(),
        'teacher': User.objects.filter(role='teacher').count(),
        'admin': User.objects.filter(role='admin').count()
    }
    
    # 获取今日新增用户
    new_users_today = User.objects.filter(date_joined__date=today).count()
    
    # 获取视频相关统计
    total_videos = Video.objects.count()
    views_today = VideoView.objects.filter(viewed_at__date=today).count()
    
    # 获取热门视频
    popular_videos = Video.objects.filter(status='published').annotate(
        view_count=Count('videoview'),
        like_count=Count('videolike')
    ).order_by('-view_count')[:5]
    
    # 获取活跃用户
    active_users = User.objects.annotate(
        video_count=Count('video'),
        comment_count=Count('comment'),
        like_count=Count('videolike')
    ).order_by('-video_count')[:5]
    
    # 获取最近7天的用户增长数据
    dates = []
    new_users = []
    for i in range(6, -1, -1):
        date = today - datetime.timedelta(days=i)
        dates.append(date.strftime('%m-%d'))
        count = User.objects.filter(date_joined__date=date).count()
        new_users.append(count)
    
    context = {
        'title': '统计概览',
        'total_users': total_users,
        'new_users_today': new_users_today,
        'total_videos': total_videos,
        'views_today': views_today,
        'user_distribution': list(user_distribution.values()),
        'popular_videos': popular_videos,
        'active_users': active_users,
        'dates': dates,
        'new_users': new_users,
    }
    return render(request, 'admin/stats_overview.html', context)

@login_required
@never_cache
def stats_user(request):
    """用户统计"""
    # 获取用户统计数据，直接从关联表计算
    users = User.objects.annotate(
        video_count=Count('video', distinct=True),  # 发布的视频数
        view_count=Count('video__videoview', distinct=True),  # 视频获得的观看数
        like_count=Count('video__videolike', distinct=True),  # 视频获得的点赞数
        comment_count=Count('comment', distinct=True)  # 发表的评论数
    ).order_by('-video_count')
    
    # 分页
    paginator = Paginator(users, 10)
    page = request.GET.get('page', 1)
    users = paginator.get_page(page)
    
    context = {
        'title': '用户统计',
        'users': users,
    }
    return render(request, 'admin/stats_user.html', context)

@login_required
@never_cache
def stats_video(request):
    """视频统计"""
    from django.db.models import Count, Q
    from videos.models import Video, VideoView, VideoLike
    from comments.models import Comment
    
    videos = Video.objects.select_related('author', 'category').annotate(
        view_count=Count('videoview', distinct=True),
        like_count=Count('videolike', distinct=True),
        comment_count=Count('comments', distinct=True)
    ).order_by('-created_at')
    
    # 分页
    paginator = Paginator(videos, 10)
    page = request.GET.get('page')
    videos = paginator.get_page(page)
    
    return render(request, 'admin/stats_video.html', {
        'videos': videos,
    })

@login_required
@never_cache
def system_profile(request):
    """个人信息设置"""
    if request.method == 'POST':
        user = request.user
        username = request.POST.get('username')
        email = request.POST.get('email')
        
        if username and email:
            user.username = username
            user.email = email
            user.save()
            messages.success(request, '个人信息更新成功')
        else:
            messages.error(request, '请填写完整的个人信息')
    
    context = {
        'title': '个人信息',
    }
    return render(request, 'admin/system_profile.html', context)

@login_required
@never_cache
def system_security(request):
    """安全设置"""
    if request.method == 'POST':
        user = request.user
        old_password = request.POST.get('old_password')
        new_password = request.POST.get('new_password')
        confirm_password = request.POST.get('confirm_password')
        
        if old_password and new_password and confirm_password:
            if user.check_password(old_password):
                if new_password == confirm_password:
                    user.set_password(new_password)
                    user.save()
                    messages.success(request, '密码修改成功，请重新登录')
                    return redirect('myadmin:logout')
                else:
                    messages.error(request, '两次输入的新密码不一致')
            else:
                messages.error(request, '原密码错误')
        else:
            messages.error(request, '请填写完整的密码信息')
    
    context = {
        'title': '安全设置',
    }
    return render(request, 'admin/system_security.html', context)

@require_POST
@admin_required
def verify_teacher(request, verification_id):
    """审核教师认证"""
    verification = get_object_or_404(TeacherVerification, id=verification_id)
    status = request.POST.get('status')
    
    if status not in ['approved', 'rejected']:
        return JsonResponse({
            'status': 'error',
            'message': '无效的操作'
        })
    
    verification.status = status
    verification.save()
    
    if status == 'approved':
        user = verification.user
        user.role = 'teacher'
        user.is_verified = True
        user.save()
    
    return JsonResponse({
        'status': 'success',
        'message': '操作成功'
    })

@require_POST
@admin_required
def toggle_video_status(request, video_id):
    """切换视频状态"""
    video = get_object_or_404(Video, id=video_id)
    action = request.POST.get('action')
    
    if action == 'approve':
        video.status = 'published'
        messages.success(request, f'视频《{video.title}》已通过审核')
    elif action == 'reject':
        video.status = 'rejected'
        messages.warning(request, f'视频《{video.title}》已被拒绝')
    
    video.save()
    return JsonResponse({'status': 'success'})

@require_POST
@admin_required
def toggle_comment_status(request, comment_id):
    """切换评论状态"""
    comment = get_object_or_404(Comment, id=comment_id)
    comment.is_deleted = not comment.is_deleted
    comment.save()
    
    status = '删除' if comment.is_deleted else '恢复'
    messages.success(request, f'已{status}评论')
    return JsonResponse({'status': 'success', 'is_deleted': comment.is_deleted})

@require_POST
@admin_required
def toggle_room_status(request, room_id):
    """切换聊天室状态"""
    room = get_object_or_404(ChatRoom, id=room_id)
    room.is_active = not room.is_active
    room.save()
    
    return JsonResponse({
        'status': 'success',
        'is_active': room.is_active,
        'message': f'聊天室已{"启用" if room.is_active else "禁用"}'
    })

@require_POST
@admin_required
def delete_message(request, message_id):
    """删除聊天消息"""
    message = get_object_or_404(ChatMessage, id=message_id)
    message.is_deleted = True
    message.save()
    
    return JsonResponse({
        'status': 'success',
        'message': '消息已删除'
    })

@require_POST
@admin_required
def toggle_member_ban(request, member_id):
    """切换成员禁言状态"""
    member = get_object_or_404(ChatRoomMember, id=member_id)
    member.is_banned = not member.is_banned
    member.save()
    
    return JsonResponse({
        'status': 'success',
        'is_banned': member.is_banned,
        'message': f'用户已{"禁言" if member.is_banned else "解除禁言"}'
    })

@never_cache
@admin_required
def get_room_messages(request, room_id):
    """获取聊天室消息"""
    room = get_object_or_404(ChatRoom, id=room_id)
    messages = ChatMessage.objects.filter(room=room).select_related('user').order_by('-created_at')
    
    # 分页
    paginator = Paginator(messages, 20)
    page = request.GET.get('page', 1)
    messages = paginator.get_page(page)
    
    html = render_to_string('admin/chat_messages.html', {
        'messages': messages,
        'room': room,
    })
    
    return JsonResponse({
        'status': 'success',
        'html': html,
    })

@never_cache
@admin_required
def get_room_members(request, room_id):
    """获取聊天室成员"""
    room = get_object_or_404(ChatRoom, id=room_id)
    members = ChatRoomMember.objects.filter(room=room).select_related('user').order_by('-joined_at')
    
    # 分页
    paginator = Paginator(members, 20)
    page = request.GET.get('page', 1)
    members = paginator.get_page(page)
    
    html = render_to_string('admin/chat_members.html', {
        'members': members,
        'room': room,
    })
    
    return JsonResponse({
        'status': 'success',
        'html': html,
    })

@never_cache
def admin_login(request):
    """管理员登录"""
    if request.user.is_authenticated:
        if request.user.role == 'admin':
            return redirect('myadmin:dashboard')
        else:
            messages.error(request, '您不是管理员，无法访问管理后台')
            return redirect('users:login')
            
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        
        from django.contrib.auth import authenticate
        user = authenticate(request, username=username, password=password)
        
        if user is not None and user.role == 'admin':
            login(request, user)
            next_url = request.GET.get('next', 'myadmin:dashboard')
            return redirect(next_url)
        else:
            messages.error(request, '用户名或密码错误，或者您不是管理员')
    
    return render(request, 'admin/login.html')

@never_cache
def admin_logout(request):
    """管理员登出"""
    logout(request)
    messages.success(request, '您已成功退出管理后台')
    return redirect('myadmin:login')
