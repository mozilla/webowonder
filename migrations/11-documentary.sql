-- Bug#631331#c6
-- I'm a dolt.. this is because on a clean insteance, no wow_demodetails exist yet...
UPDATE wow_demodetails SET documentary_description = 'The creators discuss the concept of mixing 3D objects and video without plugins.' WHERE demo_id IN 
  (SELECT id FROM demos_submission WHERE slug = 'remixingreality');