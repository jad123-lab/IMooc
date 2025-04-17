from django.shortcuts import redirect

class AuthRequiredMiddleware:
    """
    中间件，用于控制特定URL的访问权限
    - 未登录状态访问/admin时重定向到/admin/login
    - 未登录状态访问/user时重定向到/user/login
    """
    
    def __init__(self, get_response):
        self.get_response = get_response
        
    def __call__(self, request):
        # 处理请求前的逻辑
        
        # 检查用户是否已登录
        if not request.user.is_authenticated:
            # 获取当前的完整路径
            path = request.path_info
            
            # 检查是否访问admin路径
            if path == '/admin/' or path == '/admin':
                return redirect('myadmin:login')
                
            # 检查是否访问user路径
            if path == '/user/' or path == '/user':
                return redirect('users:login')
        
        # 调用视图或下一个中间件
        response = self.get_response(request)
        
        # 处理响应后的逻辑
        
        return response 