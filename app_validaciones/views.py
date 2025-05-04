from django.shortcuts import render, redirect
from .preguntas import PREGUNTAS
from .models import Cuestionario
from app_usuarios.models import Usuario


def cuestionario_view(request):
    if request.method == 'POST':
        respuestas = request.POST
        correctas = 0
        total = len(PREGUNTAS)

        for pregunta in PREGUNTAS:
            respuesta_usuario = respuestas.get(str(pregunta['id']))
            if respuesta_usuario == pregunta['respuesta']:
                correctas += 1

        puntaje = round((correctas / total) * 100, 2)
        aprobado = puntaje >= 60  # regla simple

        Cuestionario.objects.create(
            experto=request.user,
            puntaje=puntaje,
            aprobado=aprobado
        )

        return render(request, 'app_validaciones/resultado.html', {
            'puntaje': puntaje,
            'aprobado': aprobado
        })

    return render(request, 'app_validaciones/cuestionario.html', {'preguntas': PREGUNTAS})
