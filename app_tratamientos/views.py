from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from .models import Tratamiento
from .forms import TratamientoForm

@login_required
def listar_tratamientos(request):
    tratamientos = Tratamiento.objects.filter(experto=request.user)
    return render(request, 'app_tratamientos/listar.html', {'tratamientos': tratamientos})

@login_required
def crear_tratamiento(request):
    if request.user.rol != 'experto' or request.user.estado != 'activo':
        return redirect('login')

    if request.method == 'POST':
        form = TratamientoForm(request.POST)
        if form.is_valid():
            tratamiento = form.save(commit=False)
            tratamiento.experto = request.user
            tratamiento.save()
            return redirect('listar_tratamientos')
    else:
        form = TratamientoForm()

    return render(request, 'app_tratamientos/formulario.html', {'form': form, 'accion': 'Crear'})

@login_required
def editar_tratamiento(request, tratamiento_id):
    tratamiento = get_object_or_404(Tratamiento, id=tratamiento_id, experto=request.user)
    if request.method == 'POST':
        form = TratamientoForm(request.POST, instance=tratamiento)
        if form.is_valid():
            form.save()
            return redirect('listar_tratamientos')
    else:
        form = TratamientoForm(instance=tratamiento)

    return render(request, 'app_tratamientos/formulario.html', {'form': form, 'accion': 'Editar'})

@login_required
def eliminar_tratamiento(request, tratamiento_id):
    tratamiento = get_object_or_404(Tratamiento, id=tratamiento_id, experto=request.user)
    tratamiento.delete()
    return redirect('listar_tratamientos')
