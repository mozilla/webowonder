from django.conf.urls.defaults import *


urlpatterns = patterns('wow.views',
    url(r'^$', 'home', name='wow_home'),
    url(r'^submit_demo$', 'submit_demo', name='wow_submit_demo'),
    url(r'^documentary/(?P<slug>[^/]+)/?$', 'documentary', name='wow_documentary'),
    url(r'^screencast/(?P<slug>[^/]+)/?$', 'screencast', name='wow_screencast'),
)
