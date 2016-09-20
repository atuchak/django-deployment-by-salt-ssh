from django.conf.urls import url
from django.contrib import admin

from .views import root_view

urlpatterns = [
    url(r'^$', root_view),
    url(r'^admin/', admin.site.urls),
]

