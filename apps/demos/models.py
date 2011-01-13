""" see __init__.py before editing this file """
from django.db import models

from django.contrib.auth.models import User

from django.utils.translation import ugettext_lazy as _

class TagDescription(models.Model):
    """Description of a tag"""
    tag_name = models.CharField(_('name'), 
            max_length=50, unique=True, db_index=True, primary_key=True)
    title = models.CharField(_("title"), 
            max_length=255, blank=False, unique=True)
    description = models.TextField(_("description"), 
            blank=True)

class Submission(models.Model):
    """ReadOnly Representation of a demo submission from MDN Demo Studio"""

    title = models.CharField(
            _("what is your demo's name?"), 
            max_length=255, blank=False, unique=True)
    slug = models.SlugField(_("slug"), 
            blank=False, unique=True)
    summary = models.CharField(
            _("describe your demo in one line"),
            max_length=255, blank=False)
    description = models.TextField(
            _("describe your demo in more detail (optional)"), 
            blank=True)

    featured = models.BooleanField()
    hidden = models.BooleanField()
    
    # Read this... is it a string or a list of strings or...?
    tags = models.CharField(max_length=255)

    screenshot_1 = models.CharField(max_length=100)
    screenshot_2 = models.CharField(max_length=100)
    screenshot_3 = models.CharField(max_length=100)
    screenshot_4 = models.CharField(max_length=100)
    screenshot_5 = models.CharField(max_length=100)

    video_url = models.URLField(
            _("have a video of your demo in action? (optional)"),
            verify_exists=False, blank=True, null=True)

    demo_package = models.CharField(max_length=100)

    source_code_url = models.URLField(
            _("is your source code hosted online? (optional)"),
            verify_exists=False, blank=True, null=True)
    license_name = models.CharField(max_length=64)

    creator = models.ForeignKey(User, blank=False, null=True)
    
    created = models.DateTimeField( _('date created'), 
            auto_now_add=True, blank=False)
    modified = models.DateTimeField( _('date last modified'), 
            auto_now=True, blank=False)

    def __unicode__(self):
        return 'Submission "%(title)s"' % dict(
            title=self.title )

    def category(self):
        # TODO understand MDN's category approach
        # HTML5, Design, Video, webgl
        categories = {
            'particles': 'webgl',
            'motivational_poster': 'html5',
            'augmented reality': 'video',
            'london': 'design',
            'shadow': 'design',
            'immersive': 'video',
            'globe_twitter': 'webgl',
            'multitouch': 'html5',
            'double_ui': 'design',
            'hologram': 'design',
            'runfield': 'html5',
            'flight': 'webgl',
            'mobile_player': 'video',
            'html5_poster': 'html5',
            'planetarium': 'design',
            'dj_kraddy': 'webgl',
        }
        return categories[self.slug]

def get_root_for_submission(instance):
    c_name = instance.creator.username
    return 'uploads/demos/%(h1)s/%(h2)s/%(username)s/%(slug)s' % dict(
         h1=c_name[0], h2=c_name[1], username=c_name, slug=instance.slug,)
