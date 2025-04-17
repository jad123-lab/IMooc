from django.urls import path
from . import views

app_name = 'chat'

urlpatterns = [
    # 聊天室列表
    path('', views.room_list, name='room_list'),
    # 聊天室详情
    path('room/<int:room_id>/', views.room_detail, name='room_detail'),
    # 聊天室管理(教师)
    path('room/create/', views.create_room, name='create_room'),
    path('room/<int:room_id>/edit/', views.edit_room, name='edit_room'),
    path('room/<int:room_id>/members/', views.manage_members, name='manage_members'),
    # WebSocket消息
    path('ws/room/<int:room_id>/', views.room_messages, name='room_messages'),
] 