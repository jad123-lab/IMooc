from django.urls import path
from . import views

app_name = 'myadmin'

urlpatterns = [
    # 首页重定向到dashboard
    path('', views.index, name='index'),
    # 登录登出
    path('login/', views.admin_login, name='login'),
    path('logout/', views.admin_logout, name='logout'),
    # 管理功能
    path('dashboard/', views.dashboard, name='dashboard'),
    # 用户管理
    path('users/', views.user_list, name='user_list'),
    path('users/add/', views.user_add, name='user_add'),
    path('users/<int:user_id>/edit/', views.user_edit, name='user_edit'),
    path('users/<int:user_id>/delete/', views.user_delete, name='user_delete'),
    path('users/<int:user_id>/toggle/', views.toggle_user_status, name='toggle_user_status'),
    path('admins/', views.admin_list, name='admin_list'),
    # 教师认证
    path('teachers/verify/', views.teacher_verification, name='teacher_verification'),
    path('teachers/verify/<int:verification_id>/', views.verify_teacher, name='verify_teacher'),
    # 视频管理
    path('videos/', views.video_list, name='video_list'),
    path('videos/<int:video_id>/detail/', views.video_detail, name='video_detail'),
    path('videos/add/', views.video_add, name='video_add'),
    path('videos/<int:video_id>/edit/', views.video_edit, name='video_edit'),
    path('videos/<int:video_id>/delete/', views.video_delete, name='video_delete'),
    path('videos/<int:video_id>/status/', views.video_status, name='video_status'),
    path('videos/categories/', views.video_category, name='video_category'),
    path('videos/pending/', views.video_pending, name='video_pending'),
    path('videos/<int:video_id>/toggle/', views.toggle_video_status, name='toggle_video_status'),
    # 评论管理
    path('comments/', views.comment_list, name='comment_list'),
    path('comments/<int:comment_id>/toggle/', views.toggle_comment_status, name='toggle_comment_status'),
    # 统计管理
    path('stats/users/', views.stats_user, name='stats_user'),
    path('stats/videos/', views.stats_video, name='stats_video'),
    # 系统设置
    path('system/profile/', views.system_profile, name='system_profile'),
    path('system/security/', views.system_security, name='system_security'),
] 