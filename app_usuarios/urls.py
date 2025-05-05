from django.urls import path
from . import views

urlpatterns = [
    path('registro/', views.registro_experto, name='registro_experto'),
    path('login/', views.login_usuario, name='login'),
    path('logout/', views.logout_usuario, name='logout'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('revisar/', views.revisar_solicitudes, name='revisar_solicitudes'),
    path('cambiar_estado/<int:experto_id>/<str:nuevo_estado>/', views.cambiar_estado_experto, name='cambiar_estado'),
    path('reportes/', views.reportes_admin, name='reportes_admin'),
    path('crear-admin/', views.crear_admin, name='crear_admin'),

    # Recuperación de contraseña
    path('recuperar/', views.recuperar, name='recuperar'),
    path('verificar_pin/', views.verificar_pin, name='verificar_pin'),
    path('reset_password/', views.reset_password, name='reset_password'),
]
