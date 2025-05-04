from django.db import models

class Enfermedad(models.Model):
    ESTADO_CHOICES = [
        ('Verificada', 'Verificada'),
        ('En proceso', 'En proceso'),
    ]

    nombre = models.CharField(max_length=100)
    caracteristicas = models.TextField()
    descripcion = models.TextField()
    estado = models.CharField(max_length=20, choices=ESTADO_CHOICES)

    def __str__(self):
        return self.nombre
