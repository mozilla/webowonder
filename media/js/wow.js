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
            // Remove CSS class to help progressively enhance
            $('.init').removeClass('init');            
            
            // Side Scroller
            mozilla.wow.sideScroller();
            
            // Flippable Cards
            mozilla.wow.flippableCards();
            
            // Sortable cards
            mozilla.wow.sortableCards();
            
            // Demo events
            mozilla.wow.demoEvents();
            
            // Tooltips
            mozilla.wow.tooltips();
            
            // Keyboard Nav
            mozilla.wow.keynav();
            
            // Ssshhh...it's a not-so-secret
            mozilla.wow.lightsdown();
            
            // Setup lightboxes
            $('.watch-video').live('click', function (e) {
                    e.preventDefault();
                    $.colorbox({href: $(this).attr('href'),
                                title: $(this).attr('title')});
                });
            $('a.cbox-submit').colorbox();
        }
    };
}();

/**
 * Page initialization
 */
$(document).ready(function() { mozilla.wow.init(); });

/**
 * Side Scroller
 */
mozilla.wow.sideScroller = function() {
    
    // Private, reusable function to animate cards
    function _animateCards(nextCard, moveBy) {
        
        // Mutex until the animation is done
        if( $('body').hasClass('scrolling') ) return;
        $('body').addClass('scrolling');
        
        // Opaquify the currently selected card
        $('.demo.selected').removeClass('selected');
        
        // Animate and setup the next card
        try { $('#demos').animate({backgroundPosition: moveBy + 'px center'}, mozilla.wow.vars.scrollSpeed); } catch(err) { /* Do nothing */ }
        $('#demos-inner').animate({marginLeft: moveBy}, mozilla.wow.vars.scrollSpeed, function() {
                    nextCard.find('.demo-over').animate({opacity: 0}, 200, function() {
                       nextCard.addClass('selected');
                       $(this).css({opacity: 0.8});
                       
                       // Change location hash
                       window.location.hash = nextCard.attr('data-hash');
                       
                       $('body').removeClass('scrolling');
                    });
                });
    }
    
    function _moveByLeap(nextCard) {        
        var selectedCard = $('.demo.selected'),
            offsetDiff = selectedCard.offset().left - nextCard.offset().left,
            moveBy = parseInt($('#demos-inner').css('marginLeft')) + offsetDiff;
                        
            // Animate
            _animateCards(nextCard, moveBy);
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
            mozilla.wow.shake();
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
    if( hashCard.length > 0 ) _moveByLeap(hashCard);
	
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
        var selectedCat = $(this).text().toLowerCase(),
            scrollSpeed;
        
        // Prevent the click behaviour
        e.preventDefault();
        
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
               window.location.hash = $('.demo').eq(1).attr('data-hash');
           
               $('body').removeClass('sorting');
           });
            
        });
    });
};

/**
 * Card Flip
 */
mozilla.wow.flippableCards = function() {
    
    $('.more-info, .flip-card-back').live('click', function(e) {
       var card = $(this).parents('.demo');
       
       // Prevent the default behaviour
       e.preventDefault();
       
       // Shouldn't do anything if the card is flipped
       // TODO: Should we open the author's website link?
       if( $(this).hasClass('more-info') && card.hasClass('flipped') ) return;
       
       card.toggleClass('flipped');
              
    });

};

/**
 * Demo Events
 */
mozilla.wow.demoEvents = function() {
    var link, demoTitle;
    
    // Default behaviour for magic tickets
    $('#magic-tickets').click(function(e) {
        // Prevent the default behaviour
        e.preventDefault();

        // If we're not demoing, do nothing
        if( !$('body').hasClass('demoing') ) return;
        
        // Hide the viewport
        _hideViewport();
    })
    
    // Loading dialog
    function _showLoading() {
        $(".loading").find(".title").text(demoTitle).end()
                     .fadeIn("normal", function() {
                             /* $('#demo-viewport').get(0); */
                             var iframe = document.getElementById('demo-viewport');
                             
                             iframe.src = $(link).attr('href');
                             iframe.focus();
                             /*
                             setTimeout(function () {
                                     window.getElementById('demo-viewport').focus();
                                     }, 300);
*/
                     });
    }
    
    // Show/hide viewport
    function _showViewport() {
        // Animate the tickets
        $('#magic-tickets').animate({opacity: 0.5, top: '-50px'}, 500, function() {
           $('#demo-viewport').fadeIn('slow', function() {
               // Hide the loading
               $('.loading').hide();
               
               // Mouse events for magic tickets
               $("#magic-tickets").live('mouseover mouseout', function(e) {
                   if (e.type == 'mouseover') { $(this).css({top: '-30px', opacity: 0.8}); }
                   else { $(this).css({top: '-50px', opacity: 0.5}); }   
               });
               
               // Start the demo
               setTimeout(function() {
                   $('#demo-viewport').get(0).contentWindow.postMessage('start_demo', '*');    
               }, 750);
           });                               
       });
    }
    
    function _hideViewport() {
        $('#demo-viewport').get(0).contentWindow.postMessage('stop_demo', '*');
        
        // Return the magic tickets to their normal state
        $('#magic-tickets').die('mouseover mouseout')
                           .css({opacity: 1.0, top: '0px'});
        
        $('#demo-viewport').attr('src', '').fadeOut('slow', function() {
            $('body').removeClass('demoing'); 
        });  
    }
    
    // Make sure the demo viewport is always 100% height
    function _resizeViewport() {
       $('#demo-viewport, .loading').height( $(document).height() ); 
    }
    
    $(window).resize(function(){
       _resizeViewport();
    });
    _resizeViewport();
    
    // Experience It click
    $('.experience-it').live('click', function(e) {        
        // Prevent the default behaviour
        e.preventDefault();
        
        // Turn off the spotlight, just in case
        $('#spot').hide();
        
        // Get the demo title
        link = $(this);
        demoTitle = link.parents('.demo').find('.demo-info h1').text();
        
        // Add a mutex class
        $('body').addClass('demoing');
        
        // Show the loading dialog
        _showLoading();
        
    });
    
    // Listen for events
    function _handleEvents(e) {
       if ('loaded' == e.data) { _showViewport(); }
       else if ('finished_exit' == e.data || 'exiting' == e.data) { _hideViewport(); }
       else if ('hide_exit_ui') { $('#magic-tickets').hide(); }
       else if ('show_exit_ui') { $('#magic-tickets').show(); }
    }
    if ( window['addEventListener'] ) {
        window.addEventListener('message', _handleEvents, false);
    } else {
        window.attachEvent('onmessage', _handleEvents);
    }
};

/**
 * Tooltips
 */
mozilla.wow.tooltips = function() {
    
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
        
        // Ignore the keyboard nav during demos
        if( $('body').hasClass('demoing') ) return;
        
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

/**
 * Window Shake
 */
mozilla.wow.shake = function() {
    var multiplier = 1,
        rotateBy;
    
    // Shake the window
    for (var i=0, x, y; i<3; i++){
        x = Math.floor(Math.random() * 6) - 3;
        y = Math.floor(Math.random() * 6) - 3;
        window.moveBy(x,y);
        window.moveBy(-x,-y);        
    }
    
    // Disrupt some elements
    $('.disruptable iframe').each(function() {
       rotateBy = Math.floor(Math.random() * 10 * multiplier);
       $(this).css({
           '-moz-transform': 'rotate(' + rotateBy + 'deg)',
           '-webkit-transform': 'rotate(' + rotateBy + 'deg)',
           '-o-transform': 'rotate(' + rotateBy + 'deg)',
           '-ms-transform': 'rotate(' + rotateBy + 'deg)',
           'transform': 'rotate(' + rotateBy + 'deg)',
       });
       multiplier *= -1;
    });
    
};