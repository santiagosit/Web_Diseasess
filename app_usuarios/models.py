from django.db import models
from django.contrib.auth.models import AbstractUser


class Usuario(AbstractUser):
    ROL_CHOICES = (('admin', 'Administrador'), ('experto', 'Experto'))
    ESTADOS = (('pendiente', 'Pendiente'), ('activo', 'Activo'), ('inactivo', 'Inactivo'))

    rol = models.CharField(max_length=10, choices=ROL_CHOICES, default='experto')
    estado = models.CharField(max_length=10, choices=ESTADOS, default='pendiente')
    especialidad = models.CharField(max_length=100, blank=True, null=True)
    dependencia = models.CharField(max_length=100, blank=True, null=True)
    documentos = models.FileField(upload_to='documentos/', blank=True, null=True)
    es_superadmin = models.BooleanField(default=False)


    def __str__(self):
        return f"{self.username} ({self.rol})"