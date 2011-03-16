-- Pre-populate wow_demodetails
INSERT INTO wow_demodetails (demo_id, documentary_description, rank) 
(select id, '', 1 from demos_submission WHERE slug IN ('dashboard-mobile', 'runfield-mobile'));

UPDATE wow_demodetails SET platform = 'M' WHERE demo_id IN (SELECT id FROM demos_submission WHERE slug IN ('dashboard-mobile', 'runfield-mobile'));

