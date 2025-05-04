from django import forms
from django.contrib.auth.forms import UserCreationForm
from .models import Usuario

class RegistroExpertoForm(UserCreationForm):
    DEPENDENCIA_CHOICES = [
        ('Universidad', 'Universidad'),
        ('Independiente', 'Independiente'),
        ('Externo', 'Externo'),
    ]

    ESPECIALIDAD_CHOICES = [
        ('Fitomejoramiento', 'Fitomejoramiento: Mejoramiento genético de plantas para aumentar la productividad, resistencia a enfermedades y otras características deseables.'),
        ('Control biológico', 'Control biológico: Utilización de organismos naturales, como insectos y hongos, para controlar plagas y enfermedades en cultivos.'),
        ('Cultivos protegidos', 'Cultivos protegidos: Diseño y gestión de invernaderos y otros sistemas de cultivo controlados para mejorar la producción y la calidad.'),
        ('Producción de semillas', 'Producción de semillas: Desarrollo de técnicas y sistemas para producir semillas de alta calidad para diferentes cultivos.'),
        ('Control de plagas', 'Control de plagas: Identificación y gestión de plagas en cultivos, incluyendo el uso de pesticidas y otras técnicas de control.'),
        ('Horticultura', 'Horticultura: Cultivo de frutas, verduras, flores y otras plantas ornamentales.'),
        ('Productos forestales', 'Productos forestales: Gestión de bosques y producción de productos forestales, como madera y otros materiales.'),
        ('Protección forestal', 'Protección forestal: Mantenimiento y protección de los bosques contra incendios, enfermedades y otros problemas.'),
        ('Edafología', 'Edafología: Estudio de los suelos, su fertilidad y manejo para la producción agrícola.'),
        ('Fisiología vegetal', 'Fisiología vegetal: Estudio de los procesos vitales de las plantas, como el crecimiento, el desarrollo y la reproducción.'),
        ('Fitopatología', 'Fitopatología: Estudio de las enfermedades de las plantas y desarrollo de estrategias para su control.'),
        ('Genética vegetal', 'Genética vegetal: Estudio de la herencia y variación genética en las plantas.'),
    ]

    dependencia = forms.ChoiceField(choices=DEPENDENCIA_CHOICES)  # Campo limitado a las opciones
    especialidad = forms.ChoiceField(choices=ESPECIALIDAD_CHOICES)  # Campo limitado a las especialidades

    class Meta:
        model = Usuario
        fields = [
            'username', 'first_name', 'last_name', 'email',
            'especialidad', 'dependencia', 'documentos', 'password1', 'password2'
        ]

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        for field_name, field in self.fields.items():
            if isinstance(field.widget, forms.Select):
                field.widget.attrs['class'] = 'form-select'
            else:
                field.widget.attrs['class'] = 'form-control'

class CrearAdminForm(UserCreationForm):
    class Meta:
        model = Usuario
        fields = ['username', 'email', 'first_name', 'last_name', 'password1', 'password2']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'
            field.widget.attrs['placeholder'] = field.label