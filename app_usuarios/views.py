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
from .forms_reset import EmailRecoveryForm, PinVerificationForm, PasswordResetForm
from django.core.mail import send_mail
import random, string, time
from django.utils import timezone
from django.contrib.auth.hashers import make_password
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
from django.conf import settings
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

    # Enviar correo al solicitante
    subject = 'Notificación de decisión de solicitud'
    from_email = settings.DEFAULT_FROM_EMAIL
    to_email = [experto.email]
    context = {
        'username': experto.username,
        'aprobado': nuevo_estado == 'activo',
        'puntaje': getattr(experto, 'puntaje', 'N/A') # si se quiere mostrar puntaje
    }
    html_content = render_to_string('email_decision.html', context)
    msg = EmailMultiAlternatives(subject, '', from_email, to_email)
    msg.attach_alternative(html_content, "text/html")
    msg.send()

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


def recuperar(request):
    if request.method == 'POST':
        form = EmailRecoveryForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            try:
                usuario = Usuario.objects.get(email=email)
            except Usuario.DoesNotExist:
                messages.error(request, 'No existe usuario con ese correo.')
                return render(request, 'app_usuarios/recuperar.html', {'form': form})
            # Generar PIN y guardar en sesión
            pin = ''.join(random.choices(string.digits, k=6))
            expires_at = time.time() + 600  # 10 minutos
            request.session['reset_email'] = email
            request.session['reset_pin'] = pin
            request.session['reset_pin_expires'] = expires_at
            # Enviar correo
            send_mail(
                'Tu código de recuperación',
                f'Tu código PIN es: {pin}',
                None,
                [email],
                fail_silently=False,
            )
            messages.success(request, 'Se ha enviado un PIN a tu correo.')
            return redirect('verificar_pin')
    else:
        form = EmailRecoveryForm()
    return render(request, 'app_usuarios/recuperar.html', {'form': form})


def verificar_pin(request):
    if not request.session.get('reset_email'):
        return redirect('recuperar')
    if request.method == 'POST':
        form = PinVerificationForm(request.POST)
        if form.is_valid():
            pin = form.cleaned_data['pin']
            session_pin = request.session.get('reset_pin')
            expires = request.session.get('reset_pin_expires')
            if not session_pin or not expires or time.time() > expires:
                messages.error(request, 'El PIN ha expirado. Solicita uno nuevo.')
                return redirect('recuperar')
            if pin == session_pin:
                request.session['reset_pin_verified'] = True
                return redirect('reset_password')
            else:
                messages.error(request, 'PIN incorrecto.')
    else:
        form = PinVerificationForm()
    return render(request, 'app_usuarios/verificar_pin.html', {'form': form})


def reset_password(request):
    if not request.session.get('reset_pin_verified'):
        return redirect('recuperar')
    if request.method == 'POST':
        form = PasswordResetForm(request.POST)
        if form.is_valid():
            email = request.session.get('reset_email')
            password = form.cleaned_data['new_password1']
            try:
                usuario = Usuario.objects.get(email=email)
            except Usuario.DoesNotExist:
                messages.error(request, 'Error inesperado. Intenta de nuevo.')
                return redirect('recuperar')
            usuario.password = make_password(password)
            usuario.save()
            # Limpiar sesión
            for key in ['reset_email','reset_pin','reset_pin_expires','reset_pin_verified']:
                request.session.pop(key, None)
            messages.success(request, 'Contraseña restablecida. Ahora puedes iniciar sesión.')
            return redirect('login')
    else:
        form = PasswordResetForm()
    return render(request, 'app_usuarios/reset_password.html', {'form': form})
