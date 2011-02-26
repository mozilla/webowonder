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

    return {
        init: function() {
            // TODO: set up onresize->detectAndRun()

            // deploy the proper JS for either the mobile or desktop site
            mozilla.page.detectAndRun()
        },

        // detect if we are looking at mobile or desktop layout
        _detectLayout: function() {
            // TODO: don't always default to the desktop JS
            _desktop = true;
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
    return {
        vars: {
            // define constants here
        },

        init: function() {
            // enable mobile javascript functionality on the page 
            $("#page-container").addClass("mobilejs");
        }
    };
}();
