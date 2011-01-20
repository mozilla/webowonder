# -*- coding: utf-8 -*-
"""Example views. Feel free to delete this app."""

import itertools

import jingo

from tower import ugettext as _

from demos.models import Submission

# TODO, need actual urls and such
tags = {
    # L10n: Tag MDN urls. You can change these if your locale has a better url
    'Audio':       (_('http://developer.mozilla.org/En/Audio'), 
    # L10n: Technology Tags. A demo can have up to 5 of these. Keep them short.
                    _('Audio')),
    'Canvas':      (_('http://developer.mozilla.org/En/Canvas'), 
                    _('Canvas')),
    'CSS3':        (_('http://developer.mozilla.org/En/CSS'),
                    _('CSS3')),
    'DnD':         (_('http://developer.mozilla.org/En/DnD'),
                    _('DnD')),
    'Files':       (_('http://developer.mozilla.org/En/Files'),
                    _('Files')), 
    'Fonts':       (_('http://developer.mozilla.org/En/Fonts'),
                    _('Fonts')),
    'Forms':       (_('http://developer.mozilla.org/En/Forms'),
                    _('Forms')),
    'GeoLocation': (_('http://developer.mozilla.org/En/GeLocation'), 
                    _('GeoLocation')),
    'JavaScript':  (_('http://developer.mozilla.org/En/JavaScript'), 
                    _('JavaScript')), 
    'HTML5':       (_('http://developer.mozilla.org/En/HTML5'),
                    _('HTML5')), 
    'Mobile':      (_('http://developer.mozilla.org/En/Mobile'),
                    _('Mobile')), 
    'MultiTouch':  (_('http://developer.mozilla.org/En/MultiTouch'),
                    _('MultiTouch')),
    'SVG':         (_('http://developer.mozilla.org/En/SVG'), 
                    _('SVG')), 
    'Video':       (_('http://developer.mozilla.org/En/Video'),
                    _('Video')), 
    'WebGL':       (_('http://developer.mozilla.org/En/WebGL'),
                    _('WebGL')), 
     # L10n: Last of the Technology Tags.
    'XMLHttpRequest': ('http://developer.mozilla.org/En/',
                       _('XMLHttpRequest'))
}

def home(request):
    global tags
    data = {'demos': Submission.objects.filter(hidden=False)}
    for demo in data['demos']:

        ltags = [(tags[x.strip()][0], tags[x.strip()][1],) for x in demo.tags.split(',')]
        tag_pairs = list(itertools.chain(*ltags))

        # This may be ugly to a programmer, but the simplicity
        # is for ease of L10n. Please don't make this more terse
        copy = None
        if len(ltags) == 1:
            # L10n {1} is a tag like HTML5 or GeoLocation {0} is a url
            copy = _("Built with <a href='{0}'>{1}</a>.")
        elif len(ltags) == 2:
            # L10n {1} and {3} are tags like HTML5 and GeoLocation, {0} and {2} are urls
            copy = _("Built with <a href='{0}'>{1}</a> and <a href='{2}'>{3}</a>.")
        elif len(ltags) == 3:
            copy = _("Built with <a href='{0}'>{1}</a>, <a href='{2}'>{3}</a> and <a href='{4}'>{5}</a>.")
        elif len(ltags) == 4:
            copy = _("Built with <a href='{0}'>{1}</a>, <a href='{2}'>{3}</a>, <a href='{4}'>{5}</a> and <a href='{6}'>{7}</a>.")
        elif len(ltags) == 5:
            copy = _("Built with <a href='{0}'>{1}</a>, <a href='{2}'>{3}</a>, <a href='{4}'>{5}</a>, <a href='{6}'>{7}</a> and <a href='{8}'>{9}</a>.")

        if copy:
            demo.tag_copy = copy.format(*tag_pairs)

        # L10n {0} is the title of a demo
        demo.video_title = _('The Making of {0}').format(demo.title)
        # TODO new db field
        demo.video_description = 'See how John Smith brothers brought space down to earth.'

    return jingo.render(request, 'wow/home.html', data)
