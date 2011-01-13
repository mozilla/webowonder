# -*- coding: utf-8 -*-
"""Example views. Feel free to delete this app."""

from django import http

import jingo

from demos.models import Submission

def home(request):
    data = {'demos': Submission.objects.filter(hidden=False)}
    return jingo.render(request, 'wow/home.html', data)

