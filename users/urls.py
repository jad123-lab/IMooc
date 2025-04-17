from django.urls import path
from . import views

app_name = 'users'

urlpatterns = [
    # 首页
    path('', views.index, name='index'),
    # 用户认证
    path('login/', views.login_view, name='login'),
    path('register/', views.register, name='register'),
    path('logout/', views.logout_view, name='logout'),
    # 用户中心
    path('profile/', views.profile, name='profile'),
    path('profile/edit/', views.edit_profile, name='edit_profile'),
    path('profile/change-password/', views.change_password, name='change_password'),
    # 教师认证
    path('teacher/apply/', views.teacher_apply, name='teacher_apply'),
    path('teacher/status/', views.teacher_status, name='teacher_status'),
] 