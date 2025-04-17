from functools import wraps
from django.shortcuts import redirect
from django.contrib import messages

def admin_required(view_func):
    @wraps(view_func)
    def _wrapped_view(request, *args, **kwargs):
        # 检查用户是否登录且是管理员
        if not request.user.is_authenticated or request.user.role != 'admin':
            messages.error(request, '您没有权限访问该页面')
            return redirect('users:login')
        return view_func(request, *args, **kwargs)
    return _wrapped_view 