-- New Demo AR Mobile
INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Augmented Reality (Mobile)", "AR_photobooth", "", "Mobile Augmented Reality, with Javascript and the HTML5 video and WebGL.", b'1', b'0', "Canvas, JavaScript, WebGL, Video", "/augmented_reality/screenshot.jpg", "", "", "", "", "", "", "http://github.com/kig/augmented", "", 4, NOW(), NOW());

-- hide all demos
UPDATE demos_submission SET hidden = b'1';

-- Source is flowing in, update slug names and revel
UPDATE demos_submission SET slug = 'AR_models', hidden = b'0' WHERE slug = 'augmented reality';

-- Leave AR_photobooth hidden

UPDATE demos_submission SET slug = 'globe_twitter', hidden = b'0' WHERE slug = 'globetweeter';
UPDATE demos_submission SET hidden = b'0'  WHERE slug = 'particles';
UPDATE demos_submission SET hidden = b'0'  WHERE slug = 'planetarium';
UPDATE demos_submission SET hidden = b'0'  WHERE slug = 'runfield';
UPDATE demos_submission SET slug = 'shadows', hidden = b'0' WHERE slug = 'shadow';


UPDATE demos_submission SET slug = 'londonproject', hidden = b'0' WHERE slug = 'london';
UPDATE demos_submission SET slug = 'motivational', hidden = b'0' WHERE slug = 'motivational_poster';
