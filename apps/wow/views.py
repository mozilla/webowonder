# -*- coding: utf-8 -*-
"""Example views. Feel free to delete this app."""

import itertools

import jingo

from tower import ugettext as _

from django.conf import settings

from demos.models import Submission
from wow.models import DemoDetails

# TODO, need actual urls and such
tags = {
    # L10n: Tag MDN urls. You can change these if your locale has a better url
    'Audio':       (_('https://developer.mozilla.org/en/Introducing_the_Audio_API_Extension'), 
    # L10n: Technology Tags. A demo can have up to 5 of these. Keep them short.
                    _('Audio')),
    'Canvas':      (_('https://developer.mozilla.org/En/Canvas'), 
                    _('Canvas')),
    'CSS3':        (_('https://developer.mozilla.org/En/CSS'),
                    _('CSS3')),
    'DnD':         (_('https://developer.mozilla.org/en/DragDrop/Drag_and_Drop'),
                    _('DnD')),
    'Files':       (_('https://developer.mozilla.org/en/using_files_from_web_applications'),
                    _('Files')), 
    'Fonts':       (_('https://developer.mozilla.org/en/css/@font-face'),
                    _('Fonts')),
    'Forms':       (_('https://developer.mozilla.org/en/HTML/HTML5/Forms_in_HTML5'),
                    _('Forms')),
    'GeoLocation': (_('https://developer.mozilla.org/En/Using_geolocation'), 
                    _('GeoLocation')),
    'JavaScript':  (_('https://developer.mozilla.org/En/javascript'), 
                    _('JavaScript')), 
    'HTML5':       (_('https://developer.mozilla.org/En/HTML5/HTML5'),
                    _('HTML5')), 
    'Mobile':      (_('https://developer.mozilla.org/En/Mobile'),
                    _('Mobile')), 
    'MultiTouch':  (_('https://developer.mozilla.org/En/MultiTouch'),
                    _('MultiTouch')),
    'SVG':         (_('https://developer.mozilla.org/En/SVG'), 
                    _('SVG')), 
    'Video':       (_('https://developer.mozilla.org/En/Using_audio_and_video_in_Firefox'),
                    _('Video')), 
    'WebGL':       (_('https://developer.mozilla.org/En/WebGL'),
                    _('WebGL')), 
     # L10n: Last of the Technology Tags.
    'XMLHttpRequest': (_('https://developer.mozilla.org/En/XMLHttpRequest/Using_XMLHttpRequest'),
                    _('XMLHttpRequest')),
}

def home(request):
    global tags
    data = {'demos': Submission.objects.filter(hidden=False),
            'share_url': 'https://demos.mozilla.org/',
            'mozillademos_host': settings.DEMOLAND}

    desktop_only = _('Desktop Only')
    mobile_only = _('Mobile Only')

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
        demo.video_title = _(u'The Making of {0}').format(demo.title)
        # TODO new db field
        
        demo.video_description = None
        try:
            demo.video_description = demo.demodetails.documentary_description
        except DemoDetails.DoesNotExist:
            deets = DemoDetails(demo=demo)
            deets.save()
        
        authors = [(demo.creator.username, demo.creator.get_full_name(), )]

        [_collect(authors, c) for c in demo.collaborator_set.all()]

        formatted_authors = [_format_author(a[0], a[1]) for a in authors]
        demo.by_authors = _(u"by {0}").format(", ".join(formatted_authors))
        demo.category = category(demo)

    return jingo.render(request, 'wow/home.html', data)

def submit_demo(request):
    """ Collects email addresses or intersticial to MDN Demo Studio. """
    return jingo.render(request, 'wow/coming_soon.html', {})
    #return jingo.render(request, 'wow/submit.html', {})

def screencast(request, slug):
    return _show_video(request, slug, 'screencasts')

def documentary(request, slug):
    return _show_video(request, slug, 'documentary')

########################### Helper functions ########################

def category(demo):
    """ TODO understand MDN's category approach
        HTML5, Design, Video, webgl """
    categories = {
        'AR_models': 'video',
        'AR_photobooth': 'video',
        'dashboard': 'html5',
        'debug': 'html5',
        'dj_kraddy': 'webgl',
        'double_ui': 'design',
        'flight-of-the-navigator': 'webgl',
        'globetweeter': 'webgl',
        'hologram': 'design',
        'immersivevideo': 'video',
        'londonproject': 'design',
        'mobile_player': 'video',
        'motivational': 'html5',
        'particles': 'webgl',
        'planetarium': 'design',
        'plztouchme': 'html5',
        'runfield': 'html5',
        'shadows': 'design',
    }
    return categories[demo.slug]

def _format_author(url, full_name):
    """ Helper function to make author link """
    return u"<a class='more-info' href='http://github.com/%s'>%s</a>" % (url,  full_name)

def _collect(authors, c):
    """ Helper function that appends the a collaborator to the list """
    authors.append( (c.details.username, c.details.get_full_name(), ))

def _show_video(request, slug, videoType):
    if not videoType in ['documentary', 'screencasts']:
        raise Exception("Invalid type of video")
    if 'documentary' == videoType:
        fileName ='documentary'
    else:
        fileName ='screencast'
    base = "http://videos-cdn.mozilla.net/serv/mozhacks/demos"
    details = (base, videoType, slug, fileName)
    ctx = {
        'webm':"%s/%s/%s/%s.webm" % details,
        'ogg': "%s/%s/%s/%s.ogv"  % details,
        'mp4': "%s/%s/%s/%s.mp4"  % details,
    }
    return jingo.render(request, 'wow/video.html', ctx)
