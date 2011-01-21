from django.conf.urls.defaults import *


urlpatterns = patterns('wow.views',
    url(r'^$', 'home', name='wow.home'),
    url(r'^submit_demo$', 'submit_demo', name='wow.submit_demo'),
)
