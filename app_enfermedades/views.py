from django.shortcuts import render, redirect, get_object_or_404
from .models import Enfermedad
from .forms import EnfermedadForm
from django.contrib.auth.decorators import user_passes_test

def es_admin(user):
    return user.is_authenticated and user.rol == 'admin'

@user_passes_test(es_admin)
def listar_enfermedades(request):
    enfermedades = Enfermedad.objects.all()
    return render(request, 'app_enfermedades/listar_enfermedades.html', {'enfermedades': enfermedades})

@user_passes_test(es_admin)
def crear_enfermedad(request):
    if request.method == 'POST':
        form = EnfermedadForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('listar_enfermedades')
    else:
        form = EnfermedadForm()
    return render(request, 'app_enfermedades/formulario_enfermedades.html', {'form': form, 'accion': 'Crear'})

@user_passes_test(es_admin)
def editar_enfermedad(request, enfermedad_id):
    enfermedad = get_object_or_404(Enfermedad, id=enfermedad_id)
    if request.method == 'POST':
        form = EnfermedadForm(request.POST, instance=enfermedad)
        if form.is_valid():
            form.save()
            return redirect('listar_enfermedades')
    else:
        form = EnfermedadForm(instance=enfermedad)
    return render(request, 'app_enfermedades/formulario_enfermedades.html', {'form': form, 'accion': 'Editar'})

@user_passes_test(es_admin)
def eliminar_enfermedad(request, enfermedad_id):
    enfermedad = get_object_or_404(Enfermedad, id=enfermedad_id)
    enfermedad.delete()
    return redirect('listar_enfermedades')
