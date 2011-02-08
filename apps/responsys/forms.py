from django import forms

from tower import ugettext as _

class EmailSubscribeForm(forms.Form):
    def __init__(self, *args, **kwargs):
        super(EmailSubscribeForm, self).__init__(*args, **kwargs)

    email = forms.EmailField()
    optin = forms.BooleanField()
