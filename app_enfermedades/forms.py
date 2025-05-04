from django import forms
from .models import Enfermedad

class EnfermedadForm(forms.ModelForm):
    
    ESTADO_CHOICES = [
            ('Verificada', 'Verificada'),
            ('En Proceso', 'En Proceso'),
        ]

    estado = forms.ChoiceField(choices=ESTADO_CHOICES)

    class Meta:

        model = Enfermedad
        fields = ['nombre', 'caracteristicas', 'descripcion', 'estado']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        for field_name, field in self.fields.items():
            if isinstance(field.widget, forms.Select):
                field.widget.attrs['class'] = 'form-select'
            else:
                field.widget.attrs['class'] = 'form-control'
