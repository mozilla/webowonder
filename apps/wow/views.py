# -*- coding: utf-8 -*-
"""Example views. Feel free to delete this app."""

from django import http

import jingo

from tower import ugettext as _, ungettext as _n

from demos.models import Submission

tags = {
    'Audio': _('Audio'),
    'Canvas': _('Canvas'),
    'CSS3': _('CSS3'),
    'DnD': _('DnD'),
    'Files': _('Files'),
    'Fonts': _('Fonts'),
    'Forms': _('Forms'),
    'GeoLocation': _('GeoLocation'),
    'JavaScript': _('JavaScript'),
    'HTML5': _('HTML5'),
    'Mobile': _('Mobile'),
    'MultiTouch': _('MultiTouch'),
    'SVG': _('SVG'),
    'Video': _('Video'),
    'WebGL': _('WebGL'),
    'XMLHttpRequest': _('XMLHttpRequest'),
}

def home(request):
    global tags
    data = {'demos': Submission.objects.filter(hidden=False)}
    for demo in data['demos']:

        ltags = [tags[x.strip()] for x in demo.tags.split(',')]

        t = _n('Built with <a href="#">%s</a>.',
               'Built with <a href="#">%s</a>, and <a href="#">%s</a>',
               len(ltags))
        glue = '</a>, <a href="#">'

        if len(ltags) < 2:
            demo.tag_copy = t % ltags[-1]
        else:
            demo.tag_copy = t % (glue.join(ltags[0:-1]), ltags[-1]) 
        demo.video_title = _('The Making of %s') % demo.title
        #demo.tag_copy =  % '</a>, <a href="#">'.join(tags[-1])

    return jingo.render(request, 'wow/home.html', data)
