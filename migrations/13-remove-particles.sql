UPDATE demos_submission SET hidden = b'1'  WHERE slug = 'particles';

-- Due to Bug#632559 we're playing with hiding the description.... so for now 
-- setting these to 'Yes' to trigger documentary block being shown.

UPDATE wow_demodetails SET documentary_description = 'Yes' WHERE demo_id IN 
  (SELECT id FROM demos_submission WHERE slug = 'globetweeter');

UPDATE wow_demodetails SET documentary_description = 'Yes' WHERE demo_id IN 
  (SELECT id FROM demos_submission WHERE slug = 'remixingreality');

UPDATE demos_submission SET description = "Energize static content with stunning WebGL animations." WHERE slug = "particles";

UPDATE demos_submission SET description = "Create inspiring custom posters with images from your desktop." WHERE slug = "motivational";

UPDATE demos_submission SET description = "Add real-time, immersive effect to your visual media with WebGL." WHERE slug = "remixingreality";

UPDATE demos_submission SET description = "Frame your videos with an interactive, fun and layered design." WHERE slug = "londonproject";

UPDATE demos_submission SET description = "CSS3 Sheds light on familiar characters." WHERE slug = "shadows";

UPDATE demos_submission SET description = "WebGL and HTML5 combine to explore panoramic video." WHERE slug = "immersivevideo";

UPDATE demos_submission SET description = "See Geolocated Tweets from space!" WHERE slug = "globetweeter";

UPDATE demos_submission SET description = "Build awesome games without plugins!" WHERE slug = "runfield";

UPDATE demos_submission SET description = "Explore a 3D city with real-time Twitter and Flickr streams." WHERE slug = "flight-of-the-navigator";

UPDATE demos_submission SET description = "An in depth tutorial on Firefox 4's Web technologies." WHERE slug = "dashboard";

UPDATE demos_submission SET description = "Explore the universe built with CSS3" WHERE slug = "planetarium";

UPDATE demos_submission SET description = "Animate the soul of your songs using WebGL and AudioAPI technology." WHERE slug = "nocomply";