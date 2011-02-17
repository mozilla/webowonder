/**
 * Only used from /documentary/{slug} or /screencast/{slug}
 */
//mirosubs-videoTab - Initial menu expansion to tweak language or turn off subtitles
$('.mirosubs-subtitleMeLink, .mirosubs-videoTab').live('click', function () {
    console.info("Iframe click expand");
    if (window.parent && window.parent.postMessage) 
        window.parent.postMessage('subtitles-ui', '*');
    return true;
});

// mirosubs -big- Before a video has availible subtitles
$('.mirosubs-actions, .mirosubs-big').live('click', function () {
    console.info("Iframe click editor");
    if (window.parent && window.parent.postMessage) 
        window.parent.postMessage('subtitles-editor', '*');
    return true;
});

$('.mirosubs-modal-widget-title-close, .mirosubs-otherClose').live('click', function () {
    if (window.parent && window.parent.postMessage) 
        window.parent.postMessage('subtitles-shrink', '*');
});
window.parent.postMessage("subtitles-shrink", '*');//Coming back from Universial Subtitles