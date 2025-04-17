from django.urls import path
from . import views

app_name = 'videos'

urlpatterns = [
    # 视频列表和搜索
    path('', views.video_list, name='list'),
    path('search/', views.video_search, name='search'),
    path('category/<int:category_id>/', views.video_by_category, name='category'),
    # 视频详情
    path('<int:video_id>/', views.video_detail, name='detail'),
    path('<int:video_id>/like/', views.video_like, name='like'),
    # 教师视频管理
    path('teacher/upload/', views.video_upload, name='upload'),
    path('teacher/manage/', views.video_manage, name='manage'),
    path('teacher/<int:video_id>/edit/', views.video_edit, name='edit'),
    path('teacher/<int:video_id>/delete/', views.video_delete, name='delete'),
] 