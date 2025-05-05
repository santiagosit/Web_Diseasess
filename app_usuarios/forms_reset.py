from django import forms

class EmailRecoveryForm(forms.Form):
    email = forms.EmailField(label='Correo electrónico', widget=forms.EmailInput(attrs={'class': 'form-control'}))

class PinVerificationForm(forms.Form):
    pin = forms.CharField(label='Código PIN', max_length=6, widget=forms.TextInput(attrs={'class': 'form-control'}))

class PasswordResetForm(forms.Form):
    new_password1 = forms.CharField(label='Nueva contraseña', widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    new_password2 = forms.CharField(label='Confirmar contraseña', widget=forms.PasswordInput(attrs={'class': 'form-control'}))

    def clean(self):
        cleaned_data = super().clean()
        p1 = cleaned_data.get('new_password1')
        p2 = cleaned_data.get('new_password2')
        if p1 and p2 and p1 != p2:
            raise forms.ValidationError('Las contraseñas no coinciden.')
        return cleaned_data
