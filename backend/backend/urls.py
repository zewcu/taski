from django.contrib import admin
from django.urls import include, path
from rest_framework import routers
from django.views.generic import TemplateView

from api import views

router = routers.DefaultRouter()
router.register('tasks', views.TaskView, 'task')

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
    path('', TemplateView.as_view(template_name="index.html")),
]
