#!/usr/bin/env python
"""
    {'friendly_name': '', 
     'string_id':     '',
     'css_selector':  ''},
"""
elements = [
    {'friendly_name': 'Golden Tickets', 
     'string_id':     'magic-tickets',
     'css_selector':  '#magic-tickets'},

    {'friendly_name': 'Marvels Await Poster', 
     'string_id':     'marvels-await-poster',
     'css_selector':  '#marvels-await'},

    {'friendly_name': 'Marvels Await Title', 
     'string_id':     'marvels-await-title',
     'css_selector':  '#marvels-await h3'},

    {'friendly_name': 'Marvels Await Title Line', 
     'string_id':     'marvels-await-title-line',
     'css_selector':  '#marvels-await h3 span'},

    {'friendly_name': 'Submit Demo!', 
     'string_id':     'submit-demo',
     'css_selector':  '#submit-demo a'},

    {'friendly_name': 'Mozilla Presents', 
     'string_id':     'mozilla-presents',
     'css_selector':  '#home-link'},

    {'friendly_name': 'This Way', 
     'string_id':     'this-way',
     'css_selector':  '#this-way'},

    {'friendly_name': 'That Way', 
     'string_id':     'that-way',
     'css_selector':  '#that-way'},


    {'friendly_name': 'Experience it now button', 
     'string_id':     'experience-it',
     'css_selector':  '#experience-it'},

    ]

t = """

%(css_selector)s {
{# L10n: DO NOT LOCALIZE! Controls size of %(friendly_name)s. Value is a number. Examples: 0.8 or 1.0 or 1.3 #}
{%% if _('custom-css-%(string_id)s-size') and _('custom-css-%(string_id)s-size') != 'custom-css-%(string_id)s-size' %%}
    font-size: {{ _('custom-css-%(string_id)s-size') }}em;
{%% endif %%}
{# L10n: DO NOT LOCALIZE! Controls font family for %(friendly_name)s.   Values: Arial, sans-serif #}
{%% if _('custom-css-%(string_id)s-font') and _('custom-css-%(string_id)s-font') != 'custom-css-%(string_id)s-font' %%}
    font-family: {{ _('custom-css-%(string_id)s-font') }};
{%% endif %%}
}
"""

for el in elements:
    print t % el
