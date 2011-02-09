# ASYNC by default, settings to override
try:
    from django.conf import settings
except ImportError:
    settings = {}

from django.shortcuts import redirect

import jingo

from  . import forms

try:
    if 'ID' not in settings.RESPONSYS or \
       'CAMPAIGN_ID' not in settings.RESPONSYS:
        raise Exception("Please configure Responsys in settings.py")
except AttributeError:
    raise Exception("Please configure Responsys in settings.py")

try:
    if True == settings.CELERY_ENABLED:
        from . import responsys_async as responsys
    else:
        from . import responsys
except AttributeError:
    from . import responsys

def subscribe(request):
    """ Subscribe a new email address to our contact list """
    form = forms.EmailSubscribeForm(request.POST or None)

    if request.method == 'POST':
        if form.is_valid():
            data = form.cleaned_data
            responsys.subscribe(settings.RESPONSYS['CAMPAIGN_ID'], 
                                data['email'],
                                'text',
                                responsys.make_source_url(request),
                                request.locale)
            return redirect('wow_home')
    return jingo.render(request, 'responsys/error.html')
