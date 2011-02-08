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

def get_root_for_submission(instance):
    c_name = instance.creator.username
    return 'uploads/demos/%(h1)s/%(h2)s/%(username)s/%(slug)s' % dict(
         h1=c_name[0], h2=c_name[1], username=c_name, slug=instance.slug,)

class UserProfile(models.Model):
    """
    Want to track some data that isn't in dekiwiki's db?
    This is the proper grab bag for user profile info.

    Also, dekicompat middleware and backends use this 
    class to find Django user objects.

    The UserProfile *must* exist for each 
    django.contrib.auth.models.User object. This may be relaxed
    once Dekiwiki isn't the definitive db for user info.
    """
    # This could be a ForeignKey, except wikidb might be
    # a different db
    deki_user_id = models.PositiveIntegerField(default=0,
                                               editable=False)
    homepage = models.URLField(max_length=255, blank=True, default='',
                               verify_exists=False)
    # Duplicates phpBB's location field, but it's days are numbered
    location = models.CharField(max_length=255, default='', blank=True)
    user = models.ForeignKey(User, null=True, editable=False, blank=True)
    
    class Meta:
        db_table = 'user_profiles'

    def __unicode__(self):
        return '%s: %s' % (self.id, self.deki_user_id)
