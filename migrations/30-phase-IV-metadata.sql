
INSERT INTO wow_collaborator (demo_id, details_id, rank)
SELECT (SELECT id FROM demos_submission WHERE slug = 'holo-mobile'),
       (SELECT id FROM auth_user WHERE username = 'unknown1'),
       1;

UPDATE demos_submission SET description = 'An in-depth tutorial on Web technologies featured in Firefox 4 Mobile.' WHERE slug = 'dashboard-mobile';

UPDATE demos_submission SET description = 'Explore a beautiful CSS3 version of our universe.' WHERE slug = 'holo-mobile';

UPDATE wow_demodetails SET documentary_description = 'Yes' WHERE demo_id IN   (SELECT id FROM demos_submission WHERE slug = 'doubleui-mobile');

UPDATE wow_demodetails SET documentary_description = 'Yes' WHERE demo_id IN   (SELECT id FROM demos_submission WHERE slug = 'planetarium');

UPDATE wow_demodetails SET documentary_description = 'Yes' WHERE demo_id IN   (SELECT id FROM demos_submission WHERE slug = 'holo-mobile');

