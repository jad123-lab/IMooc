"""
URL configuration for IMooc project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from django.shortcuts import redirect

def index(request):
    """网站首页"""
    return redirect('users:index')

urlpatterns = [
    path('', index, name='index'),  # 网站首页，重定向到用户端首页
    path('admin/', include('myadmin.urls')),  # 管理后台
    path('videos/', include('videos.urls')),  # 视频相关
    path('chat/', include('chat.urls')),  # 聊天室
    path('comments/', include('comments.urls')),  # 评论
    path('users/', include('users.urls')),  # 用户相关
    path('django-admin/', admin.site.urls),  # Django自带管理后台
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
