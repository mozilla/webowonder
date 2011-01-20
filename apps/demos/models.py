""" see __init__.py before editing this file """
from django.db import models

from django.contrib.auth.models import User

class TagDescription(models.Model):
    """Description of a tag"""
    tag_name = models.CharField(max_length=50, unique=True, db_index=True, 
                                primary_key=True)
    title = models.CharField(max_length=255, blank=False, unique=True)
    description = models.TextField(blank=True)

class Submission(models.Model):
    """ReadOnly Representation of a demo submission from MDN Demo Studio"""

    title = models.CharField(max_length=255, blank=False, unique=True)
    slug = models.SlugField(blank=False, unique=True)
    summary = models.CharField(max_length=255, blank=False)
    description = models.TextField(blank=True)

    featured = models.BooleanField()
    hidden = models.BooleanField()
    
    # Read this... is it a string or a list of strings or...?
    tags = models.CharField(max_length=255)

    screenshot_1 = models.CharField(max_length=100)
    screenshot_2 = models.CharField(max_length=100)
    screenshot_3 = models.CharField(max_length=100)
    screenshot_4 = models.CharField(max_length=100)
    screenshot_5 = models.CharField(max_length=100)

    video_url = models.URLField(verify_exists=False, blank=True, null=True)

    demo_package = models.CharField(max_length=100)

    source_code_url = models.URLField(verify_exists=False, blank=True, 
                                      null=True)
    license_name = models.CharField(max_length=64)

    creator = models.ForeignKey(User, blank=False, null=True)
    
    created = models.DateTimeField(auto_now_add=True, blank=False)
    modified = models.DateTimeField(auto_now=True, blank=False)

    def __unicode__(self):
        return 'Submission "%(title)s"' % dict(
            title=self.title )

    def category(self):
        # TODO understand MDN's category approach
        # HTML5, Design, Video, webgl
        categories = {
            'AR_models': 'video',
            'AR_photobooth': 'video',
            'debug': 'html5',
            'dj_kraddy': 'webgl',
            'double_ui': 'design',
            'flight': 'webgl',
            'globe_twitter': 'webgl',
            'hologram': 'design',
            'html5_poster': 'html5',
            'immersive': 'video',
            'londonproject': 'design',
            'mobile_player': 'video',
            'motivational': 'html5',
            'multitouch': 'html5',
            'particles': 'webgl',
            'planetarium': 'design',
            'runfield': 'html5',
            'shadows': 'design',
        }
        return categories[self.slug]

def get_root_for_submission(instance):
    c_name = instance.creator.username
    return 'uploads/demos/%(h1)s/%(h2)s/%(username)s/%(slug)s' % dict(
         h1=c_name[0], h2=c_name[1], username=c_name, slug=instance.slug,)
