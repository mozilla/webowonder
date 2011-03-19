UPDATE demos_submission SET hidden = b'0' WHERE slug IN ('flight-of-the-navigator', 'nocomply', 'globetweeter');

-- Sort desktop demos
UPDATE wow_demodetails SET rank=1 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'flight-of-the-navigator');
UPDATE wow_demodetails SET rank=2 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'nocomply');
UPDATE wow_demodetails SET rank=3 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'globetweeter');
UPDATE wow_demodetails SET rank=4 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'planetarium');
UPDATE wow_demodetails SET rank=5 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'runfield');
UPDATE wow_demodetails SET rank=6 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'shadows');
UPDATE wow_demodetails SET rank=7 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'immersivevideo');

UPDATE wow_demodetails SET rank=8 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'motivational');
UPDATE wow_demodetails SET rank=9 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug ='remixingreality');
UPDATE wow_demodetails SET rank=10 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'londonproject');
UPDATE wow_demodetails SET rank=11 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'dashboard');

-- Sort mobile demos
UPDATE wow_demodetails SET rank=12 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'holo-mobile');
UPDATE wow_demodetails SET rank=13 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'doubleui-mobile');
UPDATE wow_demodetails SET rank=14 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'dashboard-mobile');
UPDATE wow_demodetails SET rank=15 WHERE demo_id = (SELECT id FROM demos_submission WHERE slug = 'runfield-mobile');