from django.urls import path
from . import views

urlpatterns = [
    path('', views.listar_enfermedades, name='listar_enfermedades'),
    path('crear/', views.crear_enfermedad, name='crear_enfermedad'),
    path('editar/<int:enfermedad_id>/', views.editar_enfermedad, name='editar_enfermedad'),
    path('eliminar/<int:enfermedad_id>/', views.eliminar_enfermedad, name='eliminar_enfermedad'),
]
