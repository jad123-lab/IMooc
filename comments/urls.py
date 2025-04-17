from django.urls import path
from . import views

app_name = 'comments'

urlpatterns = [
    # 评论操作
    path('add/<int:video_id>/', views.add_comment, name='add'),
    path('reply/<int:comment_id>/', views.reply_comment, name='reply'),
    path('like/<int:comment_id>/', views.like_comment, name='like'),
    path('delete/<int:comment_id>/', views.delete_comment, name='delete'),
    # 评论列表
    path('list/<int:video_id>/', views.comment_list, name='list'),
] 