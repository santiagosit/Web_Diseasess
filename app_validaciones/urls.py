from django.urls import path
from . import views

urlpatterns = [
    path('', views.cuestionario_view, name='cuestionario'),
]
