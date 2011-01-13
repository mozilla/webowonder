######################## Authors ######################

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (2, 'cedricpinson', 'Cédric', 'Pinson', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (3, 'paulrouget', 'Paul', 'Rouget', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (4, 'kig', 'Ilmari', 'Heikkinen', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (5, 'unknown1', 'Geoffrey', 'Dorne', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (6, 'unknown2', 'Patrick', 'King', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (7, 'simurai', 'Sim', 'Lus', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (8, 'unknown3', 'Benjamin', 'DeLillo', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (9, 'glecollinet', 'Guillaume', 'Lecollinet', '', '', 0, 0, 0, NOW(), NOW());
  
INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (10, 'humphd', 'David', 'Humphrey', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (11, 'cjcliffe', 'Charles J.', 'Cliffe', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (12, 'corbanbrook', 'Corban', 'Brook', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (13, 'f1lt3r', 'Alistair', 'Macdonald', '', '', 0, 0, 0, NOW(), NOW());


INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (14, 'unknown4', 'Andor', 'Salga', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (15, 'unknown5', 'Maciej', 'Adwent', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (16, 'unknown6', 'Boaz', 'Sender', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (17, 'sork', 'Franck', 'Lecollinet', '', '', 0, 0, 0, NOW(), NOW());

######################## Demos ######################

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Particles", "particles", "", "A nice animation of the Firefox logo transformed in particles", b'1', b'0', "WebGL", "/particles/screenshot.jpg", "", "", "", "", "", "", "http://github.com/cedricpinson/particles", "", 2, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Motivational Poster", "motivational_poster", "", "Create your own Motivational poster (Drag'n Drop).", b'1', b'0', "Canvas, Files, Forms, DnD, XMLHttpRequest", "/motivational_poster/screenshot.jpg", "", "", "", "", "", "", "http://github.com/paulrouget/poster", "", 3, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Augmented Reality", "augmented reality", "", "Augmented Reality, with Javascript and the HTML5 video and WebGL.", b'1', b'0', "Canvas, JavaScript, WebGL, Video", "/augmented_reality/screenshot.jpg", "", "", "", "", "", "", "http://github.com/kig/augmented", "", 4, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("London Project", "london", "", "Nice Video visualisation with HTML5, CSS3 and SVG", b'1', b'0', "CSS3, HTML5, Video, SVG", "/london/screenshot.jpg", "", "", "", "", "", "", "http://github.com/paulrouget/london", "", 3, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("The Letter-heads", "shadow", "", "What can you do with beautiful CSS shadows and a nice font-face.", b'1', b'0', "CSS3, Fonts", "/shadow/screenshot.jpg", "", "", "", "", "", "", "http://github.com/simurai/shadow", "", 7, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Immersive Video", "immersive", "", "Browse a 3D/Panoramic video with WebGL.", b'1', b'0', "WebGL, Video, JavaScript", "/immersive/screenshot.jpg", "", "", "", "", "", "", "http://github.com/paulrouget/immersive", "", 3, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("GlobeTwitter", "globe_twitter", "", "See twitter activity all over the globe", b'1', b'0', "WebGL, XMLHttpRequest, GeoLocation", "/globe_twitter/screenshot.jpg", "", "", "", "", "", "", "http://github.com/cedricpinson/globetwitter", "", 2, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("MultiTouch", "multitouch", "", "How to manipulate HTML5 content with your fingers", b'1', b'0', "MultiTouch, Video, Canvas, CSS3", "/multitouch/screenshot.jpg", "", "", "", "", "", "", "http://github.com/paulrouget/multitouch", "", 3, NOW(), NOW());


INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Double UI", "double_ui", "", "Search for a word. Turn you phone to have flickr results, turn again to have twitter results.", b'1', b'0', "CSS3, XMLHttpRequest", "/double_ui/screenshot.jpg", "", "", "", "", "", "", "http://github.com/paulrouget/double_ui", "", 3, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("CSS Hologram", "hologram", "", "Create the illusing of 3D.", b'1', b'0', "CSS3, mobile", "/hologram/screenshot.jpg", "", "", "", "", "", "", "http://github.com/paulrouget/hologram", "", 3, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Runfield", "runfield", "", "A Canabalt like 2D Game", b'1', b'0', "Canvas, Mobile", "/runfield/screenshot.jpg", "", "", "", "", "", "", "http://github.com/kig/runfield", "", 4, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Flight of the Navigator", "flight", "", "A 3D city, with HTML5 content.", b'1', b'0', "WebGL, Video, Audio", "/flight/screenshot.jpg", "", "", "", "", "", "", "http://github.com/humphd/flight", "", 10, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Mobile Video Player", "mobile_player", "", "A pretty video player for mobile", b'1', b'0', "Video, CSS3, Mobile", "/mobile_player/screenshot.jpg", "", "", "", "", "", "", "http://github.com/paulrouget/mobile_player/", "", 3, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("HTML5 Poster", "html5_poster", "", "An interactive poster, with all Firefox's OpenWeb features (80 blocks), organized in a comprehensive way, with inline little demos and documentation.", b'1', b'0', "HTML5, Mobile", "/html5_poster/screenshot.jpg", "", "", "", "", "", "", "http://github.com/paulrouget/html5_poster", "", 3, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Planetarium", "planetarium", "", "A CSS3 Planetarium", b'1', b'0', "CSS3, Fonts", "/planetarium/screenshot.jpg", "", "", "", "", "", "", "http://github.com/glecollinet/planetarium", "", 9, NOW(), NOW());

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("DJ Kraddy HTML5 Clip", "dj_kraddy", "", "A 3D animation driven by the music.", b'1', b'0', "WebGL, Audio", "/dj_kraddy/screenshot.jpg", "", "", "", "", "", "", "http://github.com/humphd/dj_kraddy", "", 10, NOW(), NOW());

