from django import forms
from .models import Tratamiento

class TratamientoForm(forms.ModelForm):
    ESTADO_CHOICES = [
        ('Vigente', 'Vigente'),
        ('No Vigente', 'No Vigente'),
    ]

    estado = forms.ChoiceField(choices=ESTADO_CHOICES) 

    class Meta:
        model = Tratamiento
        fields = ['enfermedad', 'descripcion', 'duracion_total', 'dias_mejora', 'estado', 'recomendaciones']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        for field_name, field in self.fields.items():
            if isinstance(field.widget, forms.Select):
                field.widget.attrs['class'] = 'form-select'
            else:
                field.widget.attrs['class'] = 'form-control'