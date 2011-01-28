from django.conf.urls.defaults import *


urlpatterns = patterns('wow.views',
    url(r'^$', 'home', name='wow.home'),
    url(r'^submit_demo$', 'submit_demo', name='wow.submit_demo'),
    url(r'^documentary/(?P<slug>[^/]+)/?$', 'documentary', name='wow.documentary'),
    url(r'^screencast/(?P<slug>[^/]+)/?$', 'screencast', name='wow.screencast'),
)
