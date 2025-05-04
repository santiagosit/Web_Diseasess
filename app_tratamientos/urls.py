from django.urls import path
from . import views

urlpatterns = [
    path('', views.listar_tratamientos, name='listar_tratamientos'),
    path('crear/', views.crear_tratamiento, name='crear_tratamiento'),
    path('editar/<int:tratamiento_id>/', views.editar_tratamiento, name='editar_tratamiento'),
    path('eliminar/<int:tratamiento_id>/', views.eliminar_tratamiento, name='eliminar_tratamiento'),
]
