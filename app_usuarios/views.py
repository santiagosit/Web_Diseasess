from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import user_passes_test
from django.contrib.auth.forms import UserCreationForm
from app_tratamientos.models import Tratamiento
from django.db.models import Count
from app_enfermedades.models import Enfermedad
from .models import Usuario
from .forms import RegistroExpertoForm
from django.contrib import messages

def registro_experto(request):
    if request.method == 'POST':
        form = RegistroExpertoForm(request.POST, request.FILES)
        if form.is_valid():
            usuario = form.save(commit=False)
            usuario.rol = 'experto'
            usuario.estado = 'pendiente'
            usuario.save()
            messages.success(request, 'Registro exitoso. Inicia sesión para continuar con el cuestionario.')
            return redirect('login')  # Redirige al login, no al cuestionario directamente
    else:
        form = RegistroExpertoForm()
    return render(request, 'app_usuarios/registro_experto.html', {'form': form})

def login_usuario(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        usuario = authenticate(request, username=username, password=password)
        if usuario:
            if usuario.rol == 'experto' and usuario.estado == 'inactivo':
                messages.error(request, 'Tu cuenta ha sido desactivada por un administrador.')
                return redirect('login')

            login(request, usuario)

            if usuario.rol == 'experto' and usuario.estado == 'pendiente':
                return redirect('cuestionario')

            return redirect('dashboard')  # aquí redirigimos a una sola vista común
        else:
            messages.error(request, 'Credenciales incorrectas.')
    return render(request, 'app_usuarios/login.html')


def es_admin(user):
    return user.is_authenticated and user.rol == 'admin'

@user_passes_test(es_admin)
def revisar_solicitudes(request):
    expertos_pendientes = Usuario.objects.filter(rol='experto', estado='pendiente')
    expertos_otros = Usuario.objects.filter(rol='experto').exclude(estado='pendiente')

    return render(request, 'app_usuarios/revisar_solicitudes.html', {
        'expertos': expertos_pendientes,
        'expertos_otros': expertos_otros
    })

@user_passes_test(es_admin)
def cambiar_estado_experto(request, experto_id, nuevo_estado):
    experto = Usuario.objects.get(id=experto_id)
    experto.estado = nuevo_estado
    experto.save()
    return redirect('revisar_solicitudes')

from django.contrib.auth.decorators import login_required

@login_required
def dashboard(request):
    if request.user.rol == 'admin':
        # 1. Primeras 5 solicitudes pendientes
        solicitudes = Usuario.objects.filter(rol='experto', estado='pendiente')[:5]

        # 2. Enfermedad con más tratamientos
        enfermedad_top = Enfermedad.objects.annotate(total=Count('tratamiento')) \
                          .order_by('-total').first()

        # 3. Total de tratamientos
        total_tratamientos = Tratamiento.objects.count()

        # 4. Número de expertos activos
        expertos_activos = Usuario.objects.filter(rol='experto', estado='activo').count()

        return render(request, 'app_usuarios/dashboard_admin.html', {
            'solicitudes': solicitudes,
            'enfermedad_top': enfermedad_top,
            'total_tratamientos': total_tratamientos,
            'expertos_activos': expertos_activos,
        })

    # Redirección para expertos
    elif request.user.rol == 'experto' and request.user.estado == 'activo':
        # Últimos 5 tratamientos creados/editados por el experto
        tratamientos_propios = Tratamiento.objects.filter(experto=request.user).order_by('-fecha_creacion')[:5]

        # Enfermedades tratadas por él, ordenadas por última actividad
        enfermedades_tratadas = Enfermedad.objects.filter(
            tratamiento__experto=request.user
        ).distinct().order_by('-tratamiento__fecha_creacion')[:5]

        # Feed: tratamientos recientes de otros expertos
        feed_otros = Tratamiento.objects.exclude(experto=request.user).order_by('-fecha_creacion')[:5]

        return render(request, 'app_usuarios/dashboard_experto.html', {
            'tratamientos_propios': tratamientos_propios,
            'enfermedades_tratadas': enfermedades_tratadas,
            'feed_otros': feed_otros
        })

    return redirect('login')


@user_passes_test(es_admin)
def reportes_admin(request):
    expertos = Usuario.objects.filter(rol='experto', estado='activo') \
        .annotate(num_tratamientos=Count('tratamiento')) \
        .order_by('-num_tratamientos')

    enfermedades = Enfermedad.objects.annotate(num_tratamientos=Count('tratamiento')) \
        .order_by('-num_tratamientos')

    return render(request, 'app_usuarios/reportes.html', {
        'expertos': expertos,
        'enfermedades': enfermedades
    })


def es_superadmin(user):
    return user.is_authenticated and getattr(user, 'es_superadmin', False)

class CrearAdminForm(UserCreationForm):
    class Meta:
        model = Usuario
        fields = ['username', 'email', 'first_name', 'last_name', 'password1', 'password2']

@user_passes_test(es_superadmin)
def crear_admin(request):
    if request.method == 'POST':
        form = CrearAdminForm(request.POST)
        if form.is_valid():
            nuevo_admin = form.save(commit=False)
            nuevo_admin.rol = 'admin'
            nuevo_admin.estado = 'activo'
            nuevo_admin.es_superadmin = False  # este NO es superadmin
            nuevo_admin.is_superuser = False
            nuevo_admin.save()
            messages.success(request, 'Administrador creado con éxito.')
            return redirect('dashboard')
    else:
        form = CrearAdminForm()
    return render(request, 'app_usuarios/crear_admin.html', {'form': form})

def logout_usuario(request):
    logout(request)
    return redirect('login')
