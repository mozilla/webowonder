""" Models for Web O' Wonder """

from django.db import models

from django.contrib.auth.models import User

from demos.models import Submission as Demo

class Collaborator(models.Model):
    """ A demo can be created by several people.
    To keep our db schema compatible with the
    MDN Demo Room, we've added a one to many mapping
    table. The first author is from demos_submissions
    but the 2nd, 3rd etc authors will come from here.

    rank is used to re-order the 2nd through nth author.
    """
    demo = models.ForeignKey(Demo, blank=False, null=True)
    details = models.ForeignKey(User, blank=False, null=True)
    rank = models.SmallIntegerField(default=1)

class DemoDetails(models.Model):
    """ Our microsite needs a little more data than 
    MDN Demo Room schema provides.

    * Demo sort order via rank
    """
    
    demo = models.OneToOneField(Demo, primary_key=True, unique=True)
    documentary_description = models.TextField(blank=True)
    rank = models.SmallIntegerField(default=1)
