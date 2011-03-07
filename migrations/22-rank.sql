UPDATE wow_demodetails SET rank=1 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'shadows');
UPDATE wow_demodetails SET rank=2 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'immersivevideo');
UPDATE wow_demodetails SET rank=3 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'globetweeter');
UPDATE wow_demodetails SET rank=4 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'motivational');
UPDATE wow_demodetails SET rank=5 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'remixingreality');
UPDATE wow_demodetails SET rank=6 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'londonproject');
UPDATE wow_demodetails SET rank=7 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'dashboard');

UPDATE auth_user SET first_name = 'Simurai', last_name = '' WHERE username = 'simurai';