from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.db.models import Count, Q
from .models import User, TeacherVerification
from videos.models import Video, Category

def index(request):
    """首页视图"""
    # 获取课程分类
    categories = Category.objects.all()
    
    # 获取热门课程(按观看数排序)
    popular_videos = Video.objects.filter(
        status='published'
    ).annotate(
        view_count=Count('videoview', distinct=True),
        like_count=Count('videolike', distinct=True),
        comment_count=Count('comments', distinct=True)
    ).order_by('-view_count')[:8]
    
    # 获取最新课程
    latest_videos = Video.objects.filter(
        status='published'
    ).annotate(
        view_count=Count('videoview', distinct=True),
        like_count=Count('videolike', distinct=True),
        comment_count=Count('comments', distinct=True)
    ).order_by('-created_at')[:8]
    
    # 获取优秀教师(已认证的教师)
    teachers = User.objects.filter(
        role='teacher',
        is_active=True,
        verification__status='approved'
    ).order_by('?')[:4]  # 随机选择4个教师
    
    context = {
        'categories': categories,
        'popular_videos': popular_videos,
        'latest_videos': latest_videos,
        'teachers': teachers,
    }
    return render(request, 'users/index.html', context)

def login_view(request):
    """用户登录视图"""
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        remember = request.POST.get('remember')
        
        user = authenticate(username=username, password=password)
        if user is not None:
            if user.is_active:
                login(request, user)
                # 设置session过期时间
                if not remember:
                    request.session.set_expiry(0)
                messages.success(request, '登录成功！')
                return redirect('users:index')
            else:
                messages.error(request, '账号已被禁用')
        else:
            messages.error(request, '用户名或密码错误')
    
    return render(request, 'users/login.html')

def register(request):
    """用户注册视图"""
    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        password1 = request.POST.get('password1')
        password2 = request.POST.get('password2')
        phone = request.POST.get('phone')
        
        # 表单验证
        if password1 != password2:
            messages.error(request, '两次输入的密码不一致')
            return render(request, 'users/register.html')
        
        if User.objects.filter(username=username).exists():
            messages.error(request, '用户名已存在')
            return render(request, 'users/register.html')
        
        if User.objects.filter(email=email).exists():
            messages.error(request, '邮箱已被注册')
            return render(request, 'users/register.html')
        
        # 创建用户
        user = User.objects.create_user(
            username=username,
            email=email,
            password=password1,
            phone=phone,
            role='student'  # 默认为学生角色
        )
        
        # 自动登录
        login(request, user)
        messages.success(request, '注册成功！')
        return redirect('users:index')
    
    return render(request, 'users/register.html')

@login_required
def logout_view(request):
    """用户登出视图"""
    logout(request)
    messages.success(request, '已安全退出')
    return redirect('users:login')

@login_required
def profile(request):
    """用户个人中心"""
    # 获取用户的统计数据
    if request.user.role == 'teacher':
        videos = Video.objects.filter(author=request.user).annotate(
            view_count=Count('videoview', distinct=True),
            like_count=Count('videolike', distinct=True),
            comment_count=Count('comments', distinct=True)
        )
        video_count = videos.count()
        total_views = sum(video.view_count for video in videos)
        total_likes = sum(video.like_count for video in videos)
    else:
        # 学生查看自己观看和点赞的视频数
        video_count = Video.objects.filter(videoview__user=request.user).distinct().count()
        total_views = video_count  # 观看的视频数
        total_likes = Video.objects.filter(videolike__user=request.user).distinct().count()
    
    context = {
        'video_count': video_count,
        'total_views': total_views,
        'total_likes': total_likes,
    }
    return render(request, 'users/profile.html', context)

@login_required
def edit_profile(request):
    """编辑个人信息"""
    if request.method == 'POST':
        user = request.user
        user.email = request.POST.get('email', user.email)
        user.phone = request.POST.get('phone', user.phone)
        
        # 处理头像上传
        if request.FILES.get('avatar'):
            user.avatar = request.FILES['avatar']
        
        user.save()
        messages.success(request, '个人信息更新成功')
        return redirect('users:profile')
    
    return render(request, 'users/edit_profile.html')

@login_required
def change_password(request):
    """修改密码"""
    if request.method == 'POST':
        old_password = request.POST.get('old_password')
        new_password1 = request.POST.get('new_password1')
        new_password2 = request.POST.get('new_password2')
        
        if not request.user.check_password(old_password):
            messages.error(request, '原密码错误')
        elif new_password1 != new_password2:
            messages.error(request, '两次输入的新密码不一致')
        else:
            request.user.set_password(new_password1)
            request.user.save()
            messages.success(request, '密码修改成功，请重新登录')
            return redirect('users:login')
    
    return render(request, 'users/change_password.html')

@login_required
def teacher_apply(request):
    """教师认证申请"""
    if request.user.role == 'teacher':
        messages.error(request, '您已经是教师身份')
        return redirect('users:profile')
    
    if TeacherVerification.objects.filter(user=request.user).exists():
        messages.error(request, '您已提交过教师认证申请')
        return redirect('users:teacher_status')
    
    if request.method == 'POST':
        certificate = request.FILES.get('certificate')
        description = request.POST.get('description')
        
        if not certificate:
            messages.error(request, '请上传教师资格证')
            return render(request, 'users/teacher_apply.html')
        
        # 创建认证申请
        TeacherVerification.objects.create(
            user=request.user,
            certificate=certificate,
            description=description,
            status='pending'
        )
        
        messages.success(request, '教师认证申请已提交，请等待审核')
        return redirect('users:teacher_status')
    
    return render(request, 'users/teacher_apply.html')

@login_required
def teacher_status(request):
    """查看教师认证状态"""
    verification = get_object_or_404(TeacherVerification, user=request.user)
    return render(request, 'users/teacher_status.html', {'verification': verification})
