# -*- coding: utf-8 -*-
"""Example views. Feel free to delete this app."""

from django import http

import jingo

from tower import ugettext as _, ungettext as ngettext

from demos.models import Submission

tags = {
    # L10n: Technology Tags. A demo can have up to 5 of these. Keep them short.
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
     # L10n: Last of the Technology Tags.
    'XMLHttpRequest': _('XMLHttpRequest'),
}

def home(request):
    global tags
    data = {'demos': Submission.objects.filter(hidden=False)}
    for demo in data['demos']:

        ltags = [tags[x.strip()] for x in demo.tags.split(',')]
        # L10n: TagList: (see also Tag Glue)
        # There will never be a case with 0 Tags
        # One Tag - {0} is replaced with a Tag.
        # Two Tags- {0} is replaced with the first tag. {1} is replaced with the 
        #           second tag.
        # Three or more - {0} is replaced with a list of Tags glued together with 
        #           the Tag Glue. {1} is replaced with the last tag.
        #           Be careful not to remove the <a href='#'> and </a> HTML.
        t = ngettext("Built with <a href='#'>{0}</a>.",
               "Built with <a href='#'>{0}</a>, and <a href='#'>{1}</a>.",
               len(ltags))
        # L10n: Tag Glue
        #       HTML and punctuation used to glue the Tag List together.
        glue = _("</a>, <a href='#'>")

        if len(ltags) < 2:
            demo.tag_copy = t.format(ltags[0])
        else:
            demo.tag_copy = t.format(glue.join(ltags[0:-1]), ltags[-1])
        # L10n {0} is the title of a demo
        demo.video_title = _('The Making of {0}').format(demo.title)
        # TODO new db field
        demo.video_description = 'See how John Smith brothers brought space down to earth.'

    return jingo.render(request, 'wow/home.html', data)
