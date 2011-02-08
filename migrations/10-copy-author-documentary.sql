UPDATE wow_demodetails SET documentary_description = '' WHERE demo_id IN 
  (SELECT id FROM demos_submission WHERE slug = 'particles');

-- Bug#631331#c6
UPDATE wow_demodetails SET documentary_description = 'The creators discuss the concept of mixing 3D objects and video without plugins.' WHERE demo_id IN 
  (SELECT id FROM demos_submission WHERE slug = 'AR_models');

UPDATE demos_submission SET slug = 'remixingreality', hidden = b'0' WHERE slug = 'AR_models';

-- Bug#631562
-- select username, first_name, last_name, homepage from auth_user JOIN user_profiles ON auth_user.id = user_profiles.user_id order by username;
DROP TABLE IF EXISTS `user_profiles`;

CREATE TABLE `user_profiles` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `deki_user_id` integer UNSIGNED NOT NULL,
    `homepage` varchar(255) NOT NULL,
    `location` varchar(255) NOT NULL,
    `user_id` integer
);

ALTER TABLE `user_profiles` ADD CONSTRAINT `user_id_refs_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

-- Alistair MacDonald
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 101, 'http://www.twitter.com/F1LT3R', '', id FROM auth_user WHERE username = 'f1lt3r';

INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 102, 'http://www.twitter.com/asalga', '', id FROM auth_user WHERE username = 'unknown4';

-- Benjamin DeLillo: 
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 103, 'http://www.one-geek.com/', '', id FROM auth_user WHERE username = 'unknown3';

-- Bobby Richter:
INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (19, 'unknown7', 'Bobby', 'Richter', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 104, 'http://www.twitter.com/secretrobotron', '', id FROM auth_user WHERE username = 'unknown7';

-- Bret Gaylor:
INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (20, 'unknown8', 'Bret', 'Gaylor', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 105, 'http://www.twitter.com/remixmanifesto', '', id FROM auth_user WHERE username = 'unknown8';

-- Cedric Pinson
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 106, 'http://plopbyte.net', '', id FROM auth_user WHERE username = 'cedricpinson';

-- Charles J. Cliffe: 
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 107, 'http://www.twitter.com/ccliffe', '', id FROM auth_user WHERE username = 'cjcliffe';

-- Corban Brook
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 108, 'http://twitter.com/corban', '', id FROM auth_user WHERE username = 'corbanbrook';

-- David Humphrey
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 109, 'http://twitter.com/humphd', '', id FROM auth_user WHERE username = 'humphd';

-- Franck 
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 110, 'http://www.littleworkshop.fr', '', id FROM auth_user WHERE username = 'sork';

-- Geoffrey Dorne <>
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 111, 'http://graphism.fr', '', id FROM auth_user WHERE username = 'unknown1';

-- Guillaume Lecollinet
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 112, 'http://www.littleworkshop.fr', '', id FROM auth_user WHERE username = 'glecollinet';

-- Ilmari Heikkenen
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 113, 'http://twitter.com/ilmarihei', '', id FROM auth_user WHERE username = 'kig';

-- Mauri Heikkinen
INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (21, 'unknown9', 'Mauri', 'Heikkinen', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 114, 'http://myspace.com/karhumauri', '', id FROM auth_user WHERE username = 'unknown9';

-- Maciej Adwent: 
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 115, 'http://www.twitter.com/Maciek416', '', id FROM auth_user WHERE username = 'unknown5';

-- Omar Noory
INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (22, 'unknown10', 'Omar', 'Noory', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 116, 'http://www.twitter.com/thesearethings', '', id FROM auth_user WHERE username = 'unknown10';

-- Patrick King
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 117, 'http://www.patricking.com/', '', id FROM auth_user WHERE username = 'unknown2';

-- Paul Rouget
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 118, 'http://twitter.com/paulrouget', '', id FROM auth_user WHERE username = 'paulrouget';

-- Seth Bindernagel
INSERT INTO auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES (23, 'unknown11', 'Seth', 'Bindernagel', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 119, 'http://twitter.com/binder', '', id FROM auth_user WHERE username = 'unknown11';

-- Sim Lus  
INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 120, 'http://simurai.com/', '', id FROM auth_user WHERE username = 'simurai';

-- ------------- Fix collaborators Bug#631562#c4---------------
-- select slug, auth_user.first_name, auth_user.last_name from demos_submission JOIN auth_user ON creator_id = auth_user.id UNION select slug, auth_user.first_name, auth_user.last_name from demos_submission JOIN wow_collaborator ON wow_collaborator.demo_id = demos_submission.id JOIN  auth_user ON wow_collaborator.details_id = auth_user.id ORDER BY slug;

INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'runfield'),
       (SELECT id FROM auth_user WHERE username = 'unknown9'),
       1;

INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'nocomply'),
       (SELECT id FROM auth_user WHERE username = 'unknown11'),
       1;

INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'nocomply'),
       (SELECT id FROM auth_user WHERE username = 'corbanbrook'),
       1;


INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'nocomply'),
       (SELECT id FROM auth_user WHERE username = 'cjcliffe'),
       1;

INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'nocomply'),
       (SELECT id FROM auth_user WHERE username = 'unknown8'),
       1;

INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'nocomply'),
       (SELECT id FROM auth_user WHERE username = 'humphd'),
       1;

INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'nocomply'),
       (SELECT id FROM auth_user WHERE username = 'f1lt3r'),
       1;

INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'nocomply'),
       (SELECT id FROM auth_user WHERE username = 'unknown10'),
       1;


INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'nocomply'),
       (SELECT id FROM auth_user WHERE username = 'unknown7'),
       1;


INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'remixingreality'),
       (SELECT id FROM auth_user WHERE username = 'unknown2'),
       1;

INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'double_ui'),
       (SELECT id FROM auth_user WHERE username = 'unknown1'),
       1;

