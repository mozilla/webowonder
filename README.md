Web O' Wonder
=============

Based off Mozilla's [Playdoh][gh-playdoh] web application template,
Web O Wonder is [hosted on github][gh-wow]. 

Please follow [Playdoh's docs][gh-playdoh], except for the follow:

* cd webowonder
* git clone --recursive git://github.com/mozilla/webowonder-lib.git vendor
* svn co [gh-wow-l10n] into a directory named locale
* Setup Apache or another web server on another domain to host your demos
* Run schema migrations instead of syncdb (see bin/update_site.py)
** clone [gh-wow-demos] which is a bunch of static files
** Map Doc Root to the root of this repository
** Test that you can go to http://demoland/demos/shadows/ and see a demo load
* settings_local.py
** DEMOLAND = 'http://demoland/'

[gh-playdoh]: http://mozilla.github.com/playdoh
[gh-wow]: https://github.com/mozilla/webowonder
[gh-wow-lib]: https://github.com/mozilla/webowonder
[gh-wow-demos]: https://github.com/mozilla/webowonder
[gh-wow-l10n]: http://svn.mozilla.org/projects/TBD


Vendor vs Virtualenvs
---------------------
Optional, but the new way of setting up virtual envs is:

* pip install only compiled requirements into a virtualenv
* Django will pickup other requirements from vendor

Remember vendor and locale are not submodules. You'll need to cd into them and make commits.
::
    webowonder
        apps
        ...
        locale <- SVN
        vendor <- git

Phases
------
This demo site will be released in phases... To hide later phases do;
1) set hidden flag in database
2) Comment out webtrends tracking in base.html
3) Never make this repo public ;)

License
-------
This software is licensed under the [New BSD License][BSD]. For more
information, read the file ``LICENSE``.

[BSD]: http://creativecommons.org/licenses/BSD/

