from django.apps import AppConfig


class MyadminConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'myadmin'
    verbose_name = '后台管理'
