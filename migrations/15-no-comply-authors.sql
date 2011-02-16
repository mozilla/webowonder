
-- No Comply had a posse
DELETE from wow_collaborator WHERE demo_id IN (select id from demos_submission WHERE slug = 'nocomply');

-- Create user for Audio team
INSERT INTO auth_user (username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES ('mozillaaudio', 'Mozilla Audio API team', '', '', '', 0, 0, 0, NOW(), NOW());

INSERT INTO user_profiles (deki_user_id, homepage, location, user_id) 
    SELECT 121, 'https://wiki.mozilla.org/Audio_Data_API', '', id FROM auth_user WHERE username = 'mozillaaudio';

-- And make the author
UPDATE demos_submission SET creator_id = (SELECT id FROM auth_user where username = 'mozillaaudio') WHERE slug = 'nocomply';