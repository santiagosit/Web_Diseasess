from django.db import models
from app_usuarios.models import Usuario

class Cuestionario(models.Model):
    experto = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    puntaje = models.DecimalField(max_digits=5, decimal_places=2)
    aprobado = models.BooleanField(default=False)
    fecha = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.experto.username} - {self.puntaje} puntos"
