# -*- coding: utf-8 -*-
"""Web O Wonder views."""

import itertools

import jingo

from tower import ugettext as _
from tower import ugettext_lazy as _lazy

from django.conf import settings
from django.http import HttpResponse
from django.views.decorators.cache import cache_page
from django.views.decorators.vary import vary_on_headers

from demos.models import Submission
from wow.models import DemoDetails

# TODO, need actual urls and such
tags = {
    # L10n: Tag MDN urls. You can change these if your locale has a better url

    # L10n: Technology Tags. A demo can have up to 5 of these. Keep them short.
    'Audio':       (_lazy('https://developer.mozilla.org/en/Introducing_the_Audio_API_Extension'), 
                    _lazy(u'Audio')),
    'Canvas':      (_lazy('https://developer.mozilla.org/En/Canvas'), 
                    _lazy(u'Canvas')),
    'CSS3':        (_lazy('https://developer.mozilla.org/En/CSS'),
                    _lazy(u'CSS3')),
    'DnD':         (_lazy('https://developer.mozilla.org/en/DragDrop/Drag_and_Drop'),
                    _lazy(u'DnD')),
    'Files':       (_lazy('https://developer.mozilla.org/en/using_files_from_web_applications'),
                    _lazy(u'Files')), 
    'Fonts':       (_lazy('https://developer.mozilla.org/en/css/@font-face'),
                    _lazy(u'Fonts')),
    'Forms':       (_lazy('https://developer.mozilla.org/en/HTML/HTML5/Forms_in_HTML5'),
                    _lazy(u'Forms')),
    'GeoLocation': (_lazy('https://developer.mozilla.org/En/Using_geolocation'), 
                    _lazy(u'GeoLocation')),
    'JavaScript':  (_lazy('https://developer.mozilla.org/En/javascript'), 
                    _lazy(u'JavaScript')), 
    'HTML5':       (_lazy('https://developer.mozilla.org/En/HTML5/HTML5'),
                    _lazy(u'HTML5')), 
    'Mobile':      (_lazy('https://developer.mozilla.org/En/Mobile'),
                    _lazy(u'Mobile')), 
    'MultiTouch':  (_lazy('https://developer.mozilla.org/En/MultiTouch'),
                    _lazy(u'MultiTouch')),
    'SVG':         (_lazy('https://developer.mozilla.org/En/SVG'), 
                    _lazy(u'SVG')), 
    'Video':       (_lazy('https://developer.mozilla.org/En/Using_audio_and_video_in_Firefox'),
                    _lazy(u'Video')), 
    'WebGL':       (_lazy('https://developer.mozilla.org/En/WebGL'),
                    _lazy(u'WebGL')), 
     # L10n: Last of the Technology Tags.
    'XMLHttpRequest': (_lazy('https://developer.mozilla.org/En/XMLHttpRequest/Using_XMLHttpRequest'),
                    _lazy(u'XMLHttpRequest')),
}

#@cache_page(60 * 15) # 15 minutes
#@vary_on_headers('X-Mobile')
def home(request):
    global tags
    # Desktop - desktop only, independent, mobile only
    # Mobile - mobile only, independent, desktop only
    platform = 'demodetails__platform'
    if request.MOBILE:
        platform = '-demodetails__platform'
    data = {'demos': Submission.objects.filter(hidden=False).order_by(platform, 'demodetails__rank'),
            'share_url': 'http://webowonder.org/',
            'mozillademos_host': settings.DEMOLAND,
            'mobile_content': request.MOBILE,
            'firefox_download': 'http://www.mozilla.com/firefox/?WT.mc_id=webwonder&WT.mc_ev=click',
            'chrome_download': 'http://www.google.com/landing/chrome/beta',}

    desktop_only = _(u'Desktop Only')
    mobile_only = _(u'Mobile Only')

    for demo in data['demos']:
        ltags = [(tags[x.strip()][0], tags[x.strip()][1],) for x in demo.tags.split(',')]
        tag_pairs = list(itertools.chain(*ltags))

        # This may be ugly to a programmer, but the simplicity
        # is for ease of L10n. Please don't make this more terse
        copy = None
        if len(ltags) == 1:
            # L10n {1} is a tag like HTML5 or GeoLocation {0} is a url
            copy = _(u"Built with <a href='{0}'>{1}</a>.")
        elif len(ltags) == 2:
            # L10n {1} and {3} are tags like HTML5 and GeoLocation, {0} and {2} are urls
            copy = _(u"Built with <a href='{0}'>{1}</a> and <a href='{2}'>{3}</a>.")
        elif len(ltags) == 3:
            copy = _(u"Built with <a href='{0}'>{1}</a>, <a href='{2}'>{3}</a> and <a href='{4}'>{5}</a>.")
        elif len(ltags) == 4:
            copy = _(u"Built with <a href='{0}'>{1}</a>, <a href='{2}'>{3}</a>, <a href='{4}'>{5}</a> and <a href='{6}'>{7}</a>.")
        elif len(ltags) == 5:
            copy = _(u"Built with <a href='{0}'>{1}</a>, <a href='{2}'>{3}</a>, <a href='{4}'>{5}</a>, <a href='{6}'>{7}</a> and <a href='{8}'>{9}</a>.")

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
        demo.platform = demo.demodetails.platform
        authors = [(demo.creator.userprofile_set.all()[0].homepage, demo.creator.get_full_name(), )]

        [_collect(authors, c) for c in demo.collaborator_set.all()]

        formatted_authors = [_format_author(a[0], a[1]) for a in authors]
        demo.by_authors = _(u"by {0}").format(", ".join(formatted_authors))
        demo.category = category(demo)

    return jingo.render(request, 'wow/home.html', data)


#@cache_page(60 * 60) # one hour
#@vary_on_headers('X-Mobile')
def submit_demo(request):
    """ Collects email addresses or intersticial to MDN Demo Studio. """
    return jingo.render(request, 'wow/submit.html', {})

#@cache_page(60 * 60 ) # one hour
def screencast(request, slug):
    resp = _show_video(request, slug, 'screencasts')
    resp['x-frame-options'] = 'SAMEORIGIN'
    return resp

#@cache_page(60 * 60) # one hour
def documentary(request, slug):
    resp = _show_video(request, slug, 'documentaries')
    resp['x-frame-options'] = 'SAMEORIGIN'
    return resp

@cache_page(60 * 60 * 24) # one day
def robots(request):
    resp = HttpResponse("User-agent: *\n")
    return resp

########################### Helper functions ########################

def category(demo):
    """ TODO understand MDN's category approach
        HTML5, Design, Video, webgl """
    categories = {
        'remixingreality': _('Video'),
        'AR_photobooth': _('Video'),
        'dashboard': _('HTML5'),
        'dashboard-mobile': _('HTML5'),
        'debug': _('HTML5'),
        'nocomply': _('WebGL'),
        'doubleui-mobile': _('Design'),
        'flight-of-the-navigator': _('WebGL'),
        'globetweeter': _('WebGL'),
        'holo-mobile': _('Design'),
        'immersivevideo': _('Video'),
        'londonproject': _('Design'),
        'marblerun': _('HTML5'),
        'mobile_player': _('Video'),
        'motivational': _('HTML5'),
        'particles': _('WebGL'),
        'planetarium': _('Design'),
        'plztouchme': _('HTML5'),
        'runfield': _('HTML5'),
        'runfield-mobile': _('HTML5'),
        'shadows': _('Design'),
    }
    return categories[demo.slug]

def _format_author(url, full_name):
    """ Helper function to make author link """
    return u"<a class='more-info' href='%s'>%s</a>" % (url,  full_name)

def _collect(authors, c):
    """ Helper function that appends the a collaborator to the list """
    authors.append( (c.details.userprofile_set.all()[0].homepage, c.details.get_full_name(), ))

def _show_video(request, slug, videoType):
    if not videoType in ['documentaries', 'screencasts']:
        raise Exception("Invalid type of video")
    if 'documentaries' == videoType:
        fileName ='documentary'
    else:
        fileName ='screencast'
    base = "http://videos-cdn.mozilla.net/serv/mozhacks/demos"
    poster = settings.DEMOLAND + "/demos/" + slug + "/screenshot.jpg"
    details = (base, videoType, slug, fileName)
    ctx = {
        'webm':"%s/%s/%s/%s.webm" % details,
        'ogg': "%s/%s/%s/%s.ogv"  % details,
        'mp4': "%s/%s/%s/%s.mp4"  % details,
        'flash_mp4': "serv/mozhacks/demos/%s/%s/%s.mp4" % (videoType, slug, fileName),
        'mobile_m4v': "%s/%s/%s/%s_mobile.m4v"  % details,
        'poster': poster,
        'mobile_content': request.MOBILE,
    }
    return jingo.render(request, 'wow/video.html', ctx)
