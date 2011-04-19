SET NAMES 'utf8';
SET CHARACTER SET 'utf8';


-- select MAX(id) from auth_user;
-- select MAX(deki_user_id) from user_profiles

-- David Strauß
INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (25, 'stravid', 'David', 'Strauß', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 122, 'http://stravid.com', '', id FROM auth_user WHERE username = 'stravid';

-- Mathias Paumgarten 
INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (26, 'mathias', 'Mathias', 'Paumgarten', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 123, 'http://mathias-paumgarten.com', '', id FROM auth_user WHERE username = 'mathias';

-- Eberhard Gräther 
INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (27, 'egraether', 'Eberhard', 'Gräther', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 124, 'http://egraether.com', '', id FROM auth_user WHERE username = 'egraether';

-- Matthias Paul Hempt
INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (28, 'hempt', 'Matthias Paul', 'Hempt', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 125, 'http://hempt.at', '', id FROM auth_user WHERE username = 'hempt';

-- Nicola Lieser 
INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (29, 'nicolalieser', 'Nicola', 'Lieser', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 126, 'http://nicolalieser.com', '', id FROM auth_user WHERE username = 'nicolalieser';




INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Marble Run", "marblerun", "", "The winner of Mozilla GameOn Challenge builds a gorgeous HTML5 game without plugins.", b'1', b'0', "HTML5, Canvas", "/particles/screenshot.jpg", "", "", "", "", "", "", "https://github.com/MathiasPaumgarten/marblerun", "", 25, NOW(), NOW());

INSERT INTO `wow_demodetails` (demo_id, documentary_description, rank, platform) VALUES
((SELECT id FROM demos_submission WHERE slug = 'marblerun'), '', 1, 'D');


INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'marblerun'),
       (SELECT id FROM auth_user WHERE username = 'mathias'),
       1;  
INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'marblerun'),
       (SELECT id FROM auth_user WHERE username = 'egraether'),
       2;
INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'marblerun'),
       (SELECT id FROM auth_user WHERE username = 'hempt'),
       3;
INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'marblerun'),
       (SELECT id FROM auth_user WHERE username = 'nicolalieser'),
       4;


-- Sort desktop demos
UPDATE wow_demodetails SET rank=11 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'marblerun');
UPDATE wow_demodetails SET rank=12 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'flight-of-the-navigator');
UPDATE wow_demodetails SET rank=13 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'nocomply');
UPDATE wow_demodetails SET rank=14 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'globetweeter');
UPDATE wow_demodetails SET rank=15 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'planetarium');
UPDATE wow_demodetails SET rank=16 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'runfield');
UPDATE wow_demodetails SET rank=17 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'shadows');
UPDATE wow_demodetails SET rank=18 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'immersivevideo');

UPDATE wow_demodetails SET rank=19 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'motivational');
UPDATE wow_demodetails SET rank=20 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug ='remixingreality');
UPDATE wow_demodetails SET rank=21 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'londonproject');
UPDATE wow_demodetails SET rank=22 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'dashboard');

-- Sort mobile demos
UPDATE wow_demodetails SET rank=32 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'holo-mobile');
UPDATE wow_demodetails SET rank=33 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'doubleui-mobile');
UPDATE wow_demodetails SET rank=34 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'dashboard-mobile');
UPDATE wow_demodetails SET rank=35 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'runfield-mobile');