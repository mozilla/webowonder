SET NAMES 'utf8';
SET CHARACTER SET 'utf8';

UPDATE demos_submission SET description = "TBD";

UPDATE demos_submission SET hidden = b'0' WHERE slug in ('AR_photobooth', 'flight', 'globe_twitter', 'html5_poster', 'multitouch');

-- New arrivals, fix their actual slug
UPDATE demos_submission SET slug = "plztouchme" WHERE slug = "multitouch";

UPDATE demos_submission SET slug = "flight-of-the-navigator" WHERE slug = "flight";

UPDATE demos_submission SET slug = "dashboard" WHERE slug = "html5_poster";

UPDATE demos_submission SET slug = "globetweeter" WHERE slug = "globe_twitter";

-- Copy Updates Bug#627036#c9
UPDATE demos_submission SET description = "With CSS3, your UI can change when you flip your mobile device. In portrait mode, see Twitter feeds. In landscape mode, see Flickr photos." WHERE slug = "double_ui";

UPDATE demos_submission SET description = "WebGL and JavaScript performance upgrades are changing the face of browser content. Add real-time, immersive effects to your visual media.", title = "Remixing Reality", hidden = b'1' WHERE slug = "AR_models";

UPDATE demos_submission SET description = "Energize static content with stunning WebGL animations. Transform how people see graphics online – capture the energy that lies within them!" WHERE slug = "particles";

UPDATE demos_submission SET description = "Create inspiring custom posters with Drag n’ Drop by easily importing images and other media directly from your computer’s user interface." WHERE slug = "motivational";

UPDATE demos_submission SET description = "Want your multi-media to wow the world? Use CSS3, HTML5, and SVG to frame your creations with an interactive, fun and layered design." WHERE slug = "londonproject";

UPDATE demos_submission SET description = "Letters in your browser have more personality than you might think. Thanks to CSS3, you can shed some light on these familiar \“characters.\” " WHERE slug = "shadows";

UPDATE demos_submission SET description = "Open up control of video content with WebGL and HTML5. Explore new and exotic locations in vivid panoramic 3D – you’ll swear you were there!", title = "360° Video" WHERE slug = "immersivevideo";

UPDATE demos_submission SET description = "When you combine WebGL with tweets, the data transforms into spellbinding visual effects. See the networks of Twitter from space!" WHERE slug = "globetweeter";

UPDATE demos_submission SET description = "Multitouch unlocks even more tactile ways to access your browser’s media. Use your fingers to manipulate pictures, videos and more!" WHERE slug = "plztouchme";


UPDATE demos_submission SET description = "Forget messing about with plug-ins: Canvas 2D and JavaScript make it easy to build awesome web-based applications. How fast can your Fox run?" WHERE slug = "runfield";

UPDATE demos_submission SET description = "Travel in style with HTML5, WebGL, and Audio API. Dive through 3D cities, serenaded by music, glimpsing live Twitter and Flickr streams.", title = "The Navigator" WHERE slug = "flight-of-the-navigator"; 

UPDATE demos_submission SET description = "HTML5 makes your mobile entertainment awesome. Watch gorgeous movies from your mobile device`s browser without the trouble of plug-ins." WHERE slug = "mobile_player";

UPDATE demos_submission SET description = "There’s a lot happening under the hood of every HTML5 webpage. Discover how Firefox 4’s OpenWeb features are improving your online experience." WHERE slug = "dashboard";



UPDATE demos_submission SET description = "Be a cosmic explorer with CSS3. Discover your universe, and create engaging presentations using layered images, fonts, and animations." WHERE slug = "planetarium";

UPDATE demos_submission SET description = "Animate the soul of your songs using WebGL and AudioAPI technology. Bring your audio and visual elements together in harmony!", title = "Labyrinth" WHERE slug = "dj_kraddy";

-- UPDATE demos_submission SET description = "Looking for an easy way to give simple images perspective and depth? Now you can create 3D illusions useing CSS3." WHERE slug = "hologram";
