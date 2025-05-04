from django.db import models
from app_usuarios.models import Usuario
from app_enfermedades.models import Enfermedad  # asegúrate de tener esta app creada

class Tratamiento(models.Model):
    enfermedad = models.ForeignKey(Enfermedad, on_delete=models.CASCADE)
    experto = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    fecha_creacion = models.DateField(auto_now_add=True)
    descripcion = models.TextField()
    duracion_total = models.IntegerField(help_text="Duración en días")
    dias_mejora = models.CharField(max_length=100)
    estado = models.CharField(max_length=20, choices=[('Vigente', 'Vigente'), ('No vigente', 'No vigente')])
    recomendaciones = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.enfermedad.nombre} - {self.experto.username}"
