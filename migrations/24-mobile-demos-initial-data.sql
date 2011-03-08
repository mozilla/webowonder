
INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Mobile HTML5 Poster", "dashboard-mobile", "", "Explore a beautiful CSS3 version of our universe.", b'1', b'0', "HTML5, Mobile", "/particles/screenshot.jpg", "", "", "", "", "", "", "https://github.com/paulrouget/html5dashboard_mobile", "", 3, NOW(), NOW());

UPDATE demos_submission SET slug = "doubleui-mobile", hidden = b'0' WHERE slug = 'double_ui';

UPDATE demos_submission SET slug = "holo-mobile", hidden = b'0' WHERE slug = 'hologram';

INSERT INTO demos_submission (title, slug, summary, description, featured, hidden, tags, screenshot_1, screenshot_2, screenshot_3, screenshot_4, screenshot_5, video_url, demo_package, source_code_url, license_name, creator_id, created, modified) 
VALUES ("Mobile Runfield", "runfield-mobile", "", "Build awesome games without plugins! How fast can your fox run?", b'1', b'0', "Canvas, Mobile", "/particles/screenshot.jpg", "", "", "", "", "", "", "https://github.com/kig/runfield", "", 4, NOW(), NOW());

ALTER TABLE wow_demodetails ADD COLUMN platform char DEFAULT 'D';

UPDATE wow_demodetails SET platform = 'M' WHERE demo_id IN (SELECT id FROM demos_submission WHERE slug IN ('dashboard-mobile', 'doubleui-mobile', 'holo-mobile', 'runfield-mobile'));