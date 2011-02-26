/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */
/**
 * Mozilla Web O'(pen) Wonder Common & Mobile JavaScript
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


/**
 * Page initialization
 */
$(function() { mozilla.page.init(); });


/**
 * mozilla.page object - decides which JS (mobile or desktop) to run
 */

mozilla.page = function() {
    var _desktop;
    var mobileMaxWidth = 600;

    return {
        init: function() {
            // TODO: set up onresize->detectAndRun()

            // deploy the proper JS for either the mobile or desktop site
            mozilla.page.detectAndRun()
        },

        // detect if we are looking at mobile or desktop layout
        _detectLayout: function() {
            _desktop = (document.documentElement.clientWidth > mobileMaxWidth);
        },

        // detect which layout we're looking at and run the JS
        detectAndRun: function() {
            // detect if we're on the mobile or desktop layout
            mozilla.page._detectLayout();

            // TODO: detect state change and de-init as well
            if ( _desktop ) {
                // launch desktop JS
                mozilla.wow.init();
            } else {
                // launch mobile JS
                mozilla.mwow.init();
            }
        }
    };
}();


/**
 * mozilla.mwow object - handles all mobile JS
 */

mozilla.mwow = function() {

    // Slideshow object
    var Slideshow = function() {
        var _slides;
        var _numslides;
        var _current;

        // initialize
        this.init = function() {
            _slides = $("#demos .demo, #mozilla-info")
            _numslides = _slides.length;
            _current = 0;

            // make #mozilla-info pretend to be the first selected demo 
            $("#demos .demo.selected").removeClass("selected")
            $("#mozilla-info").addClass("selected");
        };

        // move the slide forward one, but not if it's at the end
        this.advance = function() {
            //this.goToSlide((_current + 1) % _numslides, true);
            this.goToSlide(Math.min((_current + 1), _numslides - 1), true);
        };

        // move the slide backwards one, but not if it's at the beginning
        this.reverse = function() {
            this.goToSlide(Math.max((_current - 1), 0), false);
        };

        // return a slide, given the slide's index
        this.getSlide = function(n) {
            return $(_slides.get(n));
        }

        // animate to a given index of slide
        this.goToSlide = function(n, advancing) {
            var previous = _current;
            _current = n;

            // find what was previously selected
            var previous_slide = this.getSlide(previous);

            // find is now selected
            var current_slide = this.getSlide(_current);

            // make what was once selected, not selected
            previous_slide.removeClass("selected");

            // if we are advancing (not going in reverse),
            //  add the .past class to the previous slide
            //  so it exits to the left of the screen.
            if (advancing) {
                previous_slide.addClass("past");
            }

            // make what will be selected, selected
            current_slide.removeClass("past").addClass("selected");
        };

        // return true if at the last slide
        this.isAtEnd = function() {
            return _current == (_numslides - 1);
        }

        // return true if at the first slide
        this.isAtBeginning = function() {
            return _current == 0;
        }

        this.init();
    };

    return {
        update_nav: function(slideshow) {
            if (slideshow.isAtEnd()) {
                $("#this-way").hide()
            } else {
                $("#this-way").show()
            }

            if (slideshow.isAtBeginning()) {
                $("#that-way").hide()
            } else {
                $("#that-way").show()
            }
        },

        update_height: function() {
            var tallest_demo_height = 0;
            $("#demos .demo, #mozilla-info").each(function(i) {
                var height = $(this).outerHeight();
                tallest_demo_height = Math.max(height, tallest_demo_height);
            });
            var header_height = $("#header").outerHeight();
            $("#page-container").css("height", (100 + header_height + tallest_demo_height) + "px");
            $("#demo-controls").css("top", header_height + "px");
        },

        init: function() {

            // enable mobile javascript functionality on the page 
            $("#page-container").addClass("js");

            // initialize the slideshow navigation mechanism
            slideshow = new Slideshow();
            mozilla.mwow.update_nav(slideshow);

            // make the window be the size of the tallest demo + some 
            mozilla.mwow.update_height();
            $(window).resize(function() {
                mozilla.mwow.update_height();
            });

            // previous navigation
            $("#that-way").click(function(e){
                e.preventDefault();
                slideshow.reverse();
                mozilla.mwow.update_nav(slideshow);
            });

            // next navigation */
            $("#this-way").click(function(e){
                e.preventDefault();
                slideshow.advance();
                mozilla.mwow.update_nav(slideshow);
            });

            // add transition css after everything is set up,
            //  so things don't fly around the screen while
            //  they are being initialized
            $("#page-container").addClass("transitions");
        }
    };
}();
