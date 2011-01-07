from django.conf.urls.defaults import *


urlpatterns = patterns('wow.views',
    url(r'^$', 'home', name='wow.home'),
)
