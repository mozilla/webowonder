/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */
/**
 * Mozilla Web O'(pen) Wonder JavaScript
 *
 * Initial version created by Weightshift
 * http://weightshift.com/
 *
 * @copyright 2011 Mozilla Corporation
 * @license   http://www.mozilla.org/MPL/ Mozilla Public License
 */
 
/**
 * Namespace
 */
if (typeof mozilla == 'undefined') {
    var mozilla = {};
}

mozilla.wow = function() {
    return {
        vars: {
          scrollSpeed: 350,
          flipSpeed: 300,
          cardWidth: 520
        },
        
        init: function() {
            mozilla.wow.browserCompatibility();
            // Remove CSS class to help progressively enhance
            $('.init').removeClass('init');            

            // Add div to be used for media query detection
            $('body').append('<div id="_mediaquerytest"> </div>');

            // Handle window resizes on mobile
            $(window).resize(function() {
                mozilla.wow.handleResize();
            });
            
            // Side Scroller
            mozilla.wow.sideScroller();
            
            // Flippable Cards
            mozilla.wow.flippableCards();
            
            // Sortable cards
            mozilla.wow.sortableCards();
            
            // Tooltips
            mozilla.wow.tooltips();
            
            // Keyboard Nav
            mozilla.wow.keynav();
            
            // Ssshhh...it's a not-so-secret
            mozilla.wow.lightsdown();
            
            // Setup lightboxes
            $('.watch-video, .incompatible .demo-image a').live('click', function (e) {
                    if (mozilla.wow.isDesktopLayout()) {
                        e.preventDefault();
                        $.colorbox({href: $(this).attr('href'),
                                    title: $(this).attr('title'),
                                    iframe: true,
                                    width: 700,
                                    height: 500});
                    }
                });
            var _handleEvents = function (e) {
                if ('subtitles-ui' == e.data) {

                    $.colorbox.resize({width: 700, height: 775});
                } else if ('subtitles-editor' == e.data) {
                    $.colorbox.resize({width: 1000, height: 800});
                } else if ('subtitles-shrink' == e.data) {
                    $.colorbox.resize({width: 700, height: 500});
                }
            };
            if ( window['addEventListener'] ) {
                window.addEventListener('message', _handleEvents, false);
            } else {
                window.attachEvent('onmessage', _handleEvents);
            }

            $('a.cbox-submit').colorbox();

            mozilla.wow.cher();

            mozilla.wow.comingSoon();
            mozilla.wow.handleResize();
        }
    };
}();

/**
 * Page initialization
 */
$(document).ready(function() { mozilla.wow.init(); });

/**
 * Detect if the Desktop Layout is being shown
 */
mozilla.wow.isDesktopLayout = function () {
    /* if #_mediaquerytest is display:none, the media query has been triggered, and we're looking at the Desktop Layout */
    return ($("#_mediaquerytest").css("display") == "none");
};

/**
 * Handle window resizes for the Mobile Layout
 */
mozilla.wow.previousLayoutWasDesktop = null;
mozilla.wow.desktopDemosInnerMargin = $("#demos-inner").css("margin-left");
if ($('.get-it').attr('data-url') === undefined) {
    $('.get-it').attr('data-url', $('#firefox-four').attr('href'));
}
mozilla.wow.handleResize = function () {
    /* if we're on the mobile layout, clear out any margin-left on #demos-inner from the desktop site */
    var newLayoutIsDesktop = mozilla.wow.isDesktopLayout();
    if (newLayoutIsDesktop != mozilla.wow.previousLayoutWasDesktop) {
        /* we have just switched from one layout to another */
        if (newLayoutIsDesktop) {
            /* and the new layout is desktop */
            /* so retreive the stored value of the demos-inner margin */
            $("#demos-inner").css("margin-left", mozilla.wow.desktopDemosInnerMargin);
            /* set the previousLayout as Desktop */
            mozilla.wow.previousLayoutWasDesktop = true;
            /* show any demos or the marvels await poster that might have been hidden from the sorting nav */
            $(".demo, #marvels-await").show();
            if (window.navigator.userAgent.indexOf('Firefox/4') > 0) {
                $('#firefox-four').attr('href', $('.get-it-mobile').attr('data-url'));
                $('.get-it-mobile').show();
            } else {
                $('#firefox-four').attr('href', $('.get-it').attr('data-url'));
            }
            
        } else {
            /* the new layout is mobile */
            /* so store the demos-inner margin and set it to 0 */
            mozilla.wow.desktopDemosInnerMargin = $("#demos-inner").css("margin-left");
            $("#demos-inner").css("margin-left", "0");        
            /* set the previousLayout as Desktop */
            mozilla.wow.previousLayoutWasDesktop = false;
            if (window.navigator.userAgent.indexOf('Firefox/4') > 0) {
                $('#firefox-four').attr('href', $('.get-it').attr('data-url'));
                $('.get-it-mobile').hide();
            } else {
                $('#firefox-four').attr('href', $('.get-it-mobile').attr('data-url'));
            }
        }
    }
};

/**
 * Make a demo's DOM reflect that it is not compatible witht the user's browser.
 * (for now, this just swaps the "Experience it Now" and "Watch a Video" buttons)
 */
mozilla.wow.markDemoAsIncompatible = function (demo /* jQuery object of the Demo's DOM */) {
    if (demo.length > 0) {
        demo.addClass("incompatible");
        var container = demo.find(".experience-it").first().parent();

        /* make the video button primary */
        var video_button = container.find(".watch-video");
        video_button.remove().prependTo(container);
        video_button.removeClass("secondary").addClass("primary");
        var video_link = video_button.attr("href");
        var video_title = video_button.attr("title");
        $(".demo-image a").attr("href", video_link).attr("title", video_title);

        /* make the experience it button secondary */
        var exp_button = container.find(".experience-it");
        exp_button.remove().appendTo(container);
        exp_button.removeClass("primary").addClass("secondary");
    }
};



/**
 * Browser Compatibility
 */
mozilla.wow.browserCompatibility = function () {    
    $('#compat-canvas').remove();
    $('#webgl button').click(function (e) {
        e.preventDefault();
        
        if ('localStorage' in window && window['localStorage'] != null &&
            $('#remeber-webgl').attr('checked')) {

            if ('browser' == $('#remeber-webgl').val()) {
                localStorage['/home/webgl_browser_shown_once'] = 'true';
            } else if ('drivers' == $('#remeber-webgl').val()) {
                localStorage['/home/webgl_drivers_shown_once'] = 'true';
            }
        }
        $('#webgl-compatibility, #compatibility').remove();
    });

    if (! window.webGLOK) {
        $(".demo.WebGL").each(function() {
            mozilla.wow.markDemoAsIncompatible($(this));
        });
    }

    if ($("body").hasClass("mobile-content")) {
        $(".demo.D").each(function() {
            mozilla.wow.markDemoAsIncompatible($(this));
        });
    } else if ($("body").hasClass("desktop-content")) {
        $(".demo.M").each(function() {
            mozilla.wow.markDemoAsIncompatible($(this));
        });
    }
    
    // Tweaks for Safari 4 and -webkit-transform problem
    if ($.browser.safari && (navigator.appVersion.indexOf('4.') != -1)) {
        $("#twitter iframe, #facebook iframe").css("-webkit-transform", "none");
    }
};

/**
 * Side Scroller
 */
mozilla.wow.sideScroller = function() {

    // Private, reusable function to animate cards
    function _animateCards(nextCard, moveBy) {

        //if(!mozilla.wow.isDesktopLayout()) return; /* we're on the mobile layout, ignore */
        
        // Mutex until the animation is done
        if( $('body').hasClass('scrolling') ) return;
        $('body').addClass('scrolling');
        
        // Opaquify the currently selected card
        $('.demo.selected').removeClass('selected');
        
        // Animate and setup the next card
        if (mozilla.wow.isDesktopLayout()) {
            try { $('#demos').animate({backgroundPosition: moveBy + 'px center'}, mozilla.wow.vars.scrollSpeed); } catch(err) { /* Do nothing */ }
        }
        $('#demos-inner').animate({marginLeft: moveBy}, mozilla.wow.vars.scrollSpeed, function() {
                    nextCard.find('.demo-over').animate({opacity: 0}, 200, function() {
                       nextCard.addClass('selected');
                       $(this).css({opacity: 0.8});
                       
                       // Change location hash
                       if (window.history && window.history.pushState) {
                           window.history.pushState({playing: false}, 
                                                    $('h1', nextCard).text(), 
                                                    "#" + nextCard.attr('data-hash'));
                       } else {
                           window.location.hash = nextCard.attr('data-hash');
                       }
                       $('body').removeClass('scrolling');
                    });
                });
    }
    
    function _moveByLeap(nextCard) {
        
        var selectedCard = $('.demo.selected'),
            offsetDiff, moveBy;
        if (selectedCard.size() > 0) {
            offsetDiff = selectedCard.offset().left - nextCard.offset().left;
            moveBy = parseInt($('#demos-inner').css('marginLeft')) + offsetDiff;
                        
            // Animate
            _animateCards(nextCard, moveBy);
        }
    }
    
    // Move the cards left or right, and set the selected class    
    $('#this-way, #that-way').click(function(e) {
        var selectedCard = $('.demo.selected'),
            nextCard, moveBy;
    
        // Prevent the click behaviour
        e.preventDefault();
        
        // Setup the variables
        if( $(this).is('#that-way') ) {
            nextCard = selectedCard.prev('.demo');
            moveBy = '+=' + mozilla.wow.vars.cardWidth;
        } else {
            nextCard = selectedCard.next('.demo');
            moveBy = '-=' + mozilla.wow.vars.cardWidth;
        }
        
        // If we don't have a next card
        if(nextCard.length == 0 && !$('body').hasClass('scrolling')) {
            mozilla.wow.spin();
            return;
        };
        
        // Animate
        _animateCards(nextCard, moveBy);
    });
    
    // Add click functionality to 'demo-over' DIVs, just in case
    $('.demo-over').live('click', function(e) {
        // Prevent the click behaviour
        e.preventDefault();
        
        // Animate
        _moveByLeap( $(this).parents('.demo') );
    });
    
    // If we've been passed a hashed URL, try to move to the correct card    
    var hashCard = $('.demo[data-hash=' + window.location.hash.substring(1) + ']');
    if( hashCard.length > 0 ) {
        // Leap to the right location
        var selectedCard = $('.demo.selected'),            
            offsetDiff = selectedCard.offset().left - hashCard.offset().left,
            moveBy = parseInt($('#demos-inner').css('marginLeft')) + offsetDiff;
        
        selectedCard.removeClass('selected');
        $('#demos-inner').css('marginLeft', moveBy);
        hashCard.addClass('selected');
    }

    // Handle Back/Forward
    var updateScollFromHash = function (e) {
        if ($('.demo.selected').attr('data-hash') != window.location.hash.substring(1)) {
            var hashCard = $('.demo[data-hash=' + window.location.hash.substring(1) + ']');
            if( hashCard.length > 0 ) _moveByLeap(hashCard);
        }
    };
    // TODO handle in/out of demo play state
    if (window.history && window.history.pushState) {
        $(window).bind('popstate', function (e) {
            var state = e.originalEvent.state;
            if (state && state.playing == false) {
                $('#magic-tickets').click();
            }


            updateScollFromHash();
        });
    } else {
        $(window).bind('hashchange', updateScollFromHash);
    }
};

/**
 * Sortable Cards
 */
mozilla.wow.sortableCards = function() {
    // Clone of the cards, for quicksand sorting
    var demos = $('#demos-inner'),
        clones, merged;
    
    function _setZIndices() {
        // Set the z-indexes to make the shuffle smoother
        $('.demo').each(function(k,v) {
           $(this).css('z-index', k); 
        });
    };
    _setZIndices();
        
    $('#navigation a').click(function(e) {
        // Prevent the click behaviour
        e.preventDefault();

        if (mozilla.wow.isDesktopLayout()) {
            /* Desktop-layout behavor */

            var selectedCat = $(this).text().toLowerCase(),
                scrollSpeed;
        
            // Is this already selected?
            if( $(this).hasClass('selected') ) return;
            
            // Mutex until the animation is done
            if( $('body').hasClass('sorting') ) return;
            $('body').addClass('sorting');
            
            // Swap the navigation's selected class
            $('#navigation a.selected').removeClass('selected');
            $(this).addClass('selected');
            
            // Unselect the current demo
            $('.demo.selected').removeClass('selected');
            
            // Scroll back to the starting position (if we're not already there)
            scrollSpeed = ( parseInt($('#demos-inner').css('marginLeft')) == mozilla.wow.vars.cardWidth * -1.5 ) ? 0 : mozilla.wow.vars.scrollSpeed;
            try { $('#demos').animate({backgroundPosition: mozilla.wow.vars.cardWidth * -1.5 + 'px center'}, scrollSpeed); } catch(err) { /* Do nothing */ }
            $('#demos-inner').animate({marginLeft: mozilla.wow.vars.cardWidth * -1.5}, scrollSpeed, function() {
               
               // Sort by category, selected category first
               clones = demos.find('.demo:not(.coming-soon)');
               clones.sort(function(a, b) {
                   var catA = $(a).find('.flag').text().toLowerCase(),
                       catB = $(b).find('.flag').text().toLowerCase();

                   return (catA == selectedCat) ? -1 :
                          (catB == selectedCat) ? 1 :
                          (catA < catB) ? -1 :
                          (catA > catB) ? 1 : 0;
               });

               // Prepend coming-soon
               merged = $.merge($('.coming-soon').clone(), clones);

               // Reorder the cards
               demos.quicksand(merged, {
                   adjustHeight: false,
                   attribute: function(v) { return $(v).find('h1').text(); },
                   enhancement: function() { $('.coming-soon').css('position', 'static'); }
               }, function() {
                   // Select the first card
                   $('.demo').eq(1).addClass('selected');
                   _setZIndices();

                   // Change location hash
                   if (window.history && window.history.postState) {                   
                       window.history.pushState({playing:false}, 
                                                $('.demo.selected h1').text(), 
                                                "#" + $('.demo').eq(1).attr('data-hash'));
                   } else {
                       window.location.hash = $('.demo').eq(1).attr('data-hash');
                   }
                   $('body').removeClass('sorting');
               });
                
            });
        } else {
            /* Mobile-layout behavior */

            // Is this already selected?
            if( $(this).hasClass('selected') ) {
                $(this).removeClass('selected');
                $(".demo").not(".coming-soon").show();
                $("#marvels-await").slideDown();
            } else {

                var selectedCat = $(this).text();

                // Swap the navigation's selected class
                $('#navigation a.selected').removeClass('selected');
                $(this).addClass('selected');

                // Hide all demos
                $(".demo").hide();

                // Slide up "Marvels Await" poster
                $("#marvels-await").slideUp();

                // Make sure the category that has been selected is shown
                $(".demo." + selectedCat).show();
            }
        }
    });
};

/**
 * Card Flip
 */
mozilla.wow.flippableCards = function() {
    // Bug#632120Comment#11
    $('.demo-info-extra').parent().addClass('js');
    $('.more-info, .flip-card-back').live('click', function(e) {
       var card = $(this).parents('.demo');
       var innerCard = $(this).parents('.demo-inner');
       // Bug#641237
       if ( parseInt(innerCard.css('height'), 10) < 310) {//310px from desktop.css
           console.info("Setting up demo card");
           innerCard.css('height', innerCard.height() + 'px');
           console.info("Setting up demo card height to", innerCard.css('height'));
       } else {
           console.info("We're good", innerCard.css('height'));
       }
       if( $(this).hasClass('more-info') && card.hasClass('flipped') ) {
           // They are clicking the authors homepage url... 
       } else {       
           e.preventDefault();
           card.toggleClass('flipped');
       }              
    });

};

/**
 * Tooltips
 */
mozilla.wow.tooltips = function() {
        
    if(!mozilla.wow.isDesktopLayout()) return; /* we're on the mobile layout, ignore - makes you tap two or three times on demos to share */
    
    // Show tooltips above social icons
	$('.social-media').live('mouseover mouseout', function(e) {
	    if (e.type == 'mouseover') {
		    $('.social-tooltip span').text( $(this).attr('title') )
		                        .parent()
		                        .appendTo( $(this) )
	                            .show();
		} else {
		    $('.social-tooltip').hide();
		}
	});  

};

/**
 * Keyboard Navigation
 */
mozilla.wow.keynav = function() {
    // Attach left/right keyboard events to this/that way links
    $(document).keydown(function(e) {
        
        if(!mozilla.wow.isDesktopLayout()) return; /* we're on the mobile layout, ignore */

        // Ignore the keyboard nav during demos
            if( $('body').hasClass('demoing') ) return; /* demo has focus, shouldn't happen */
        if( e.keyCode == 37 ) {
            $('#that-way').trigger('click');
        } else if( e.keyCode == 39 ) {
            $('#this-way').trigger('click');
        }
    });
};

/**
 * Lights down!
 * http://svay.com/experiences/css3-spotlight/
 */
mozilla.wow.lightsdown = function() {
    var spot = $('#spot'),
        spotDOM = spot.get(0);
    
    function _moveSpot(e){
        var x = 0;
        var y = 0;

        if (!e) var e = window.event;
        if (e.pageX || e.pageY)
        {
            x = e.pageX;
            y = e.pageY;
        }
        else if (e.clientX || e.clientY)
        {
            x = e.clientX + document.body.scrollLeft;
            y = e.clientY + document.body.scrollTop;
        }

        if (navigator.userAgent.match('AppleWebKit')) {
            var style = '-webkit-gradient(radial, '+x+' '+y+', 0, '+x+' '+y+', 150, from(rgba(0,0,0,0)), to(rgba(0,0,0,0.8)), color-stop(0.8, rgba(0,0,0,0)))';
        } else {
            var style = '-moz-radial-gradient('+x+'px '+y+'px 45deg,circle closest-side,transparent 0,transparent 150px,rgba(0, 0, 0, 0.8) 180px)';
        }
        spotDOM.style.backgroundImage = style;
    }
    
    $('#lights-down').click(function(e) {
        e.preventDefault();
        
        if( spot.is(':visible') ) {
            spot.hide();
            $(window).unbind('mousemove');
        } else {
            spot.show();
            $(window).bind('mousemove', _moveSpot);
       }
    });
};

mozilla.wow.cher = function () {
    var _share = function (h, url_key, text_key, extras) {
        try {
            var  d = document,
                 url = d.location.href,
                 e = encodeURIComponent,
                 text = $(this).parents('.demo').find('.demo-info h1').text(),
                 l = '?' + url_key + '=' + e(url)+'&' + text_key + '=' + e(text),
                 k,
                 fn;
            
            if (extras) {
                for (k in extras) {
                    l += '&' + k + '=' + e(extras[k]);
                }
            }
            var win = window.open('', 'sharer', 'toolbar=0, status=0, resizable=1, width=626, height=436');
            fn  = function()  {
                win.location = h + l;
            };
            setTimeout(fn,0);
        } catch (doh) {window.console && console.info(doh);}
        return false;
    };
    $('.social-media.twitter').click(function (e) {
            e.preventDefault();
            return _share.call(this, 'http://twitter.com/share', 'url', 'text', {via: 'firefox', counturl: 'http://demos.mozilla.org/'});
    });
    $('.social-media.facebook').click(function (e) {
            e.preventDefault();
            return _share.call(this, 'http://www.facebook.com/sharer.php', 'u', 't');
    });
};

mozilla.wow.comingSoon = function () {
    $('#dr_launch_email').live('submit', function (e) {
        if (! $('#id_optin').attr('checked')) {
            $('#opt-in-req').fadeOut('fast', function () {
                    $('#opt-in-req').fadeIn('slow');
                });
            return false;
        }
        return true;
    });
};

/**
 * We have another winner!
 */
mozilla.wow.spin = function() {
    if (mozilla.wow.spin.even) {
        $('.magic-ticket-2').css(
            {'-moz-transform': 'rotate(-13deg)',
             '-o-transform': 'rotate(-13deg)',
             '-webkit-transform': 'rotate(-13deg)'});
        mozilla.wow.spin.even = false;
    } else {
        $('.magic-ticket-2').css(
            {'-moz-transform': 'rotate(347deg)',
             '-o-transform': 'rotate(347deg)',
             '-webkit-transform': 'rotate(347deg)'});
        mozilla.wow.spin.even = true;
    }
};
