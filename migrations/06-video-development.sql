DROP TABLE IF EXISTS `wow_demodetails`;
CREATE TABLE `wow_demodetails` (
    `demo_id` integer NOT NULL PRIMARY KEY,
    `documentary_description` longtext NOT NULL,
    `rank` smallint NOT NULL
)
;
ALTER TABLE `wow_demodetails` ADD CONSTRAINT `demo_id_refs_id_demos_submissions_fk` FOREIGN KEY (`demo_id`) REFERENCES `demos_submission` (`id`);

INSERT INTO `wow_demodetails` (demo_id, documentary_description, rank) VALUES
((SELECT id FROM demos_submission WHERE slug = 'particles'), 'Paul Rouget shows how to manipulate your browser with expanded input control.', 1);

-- Pre-populate wow_demodetails
INSERT INTO wow_demodetails (demo_id, documentary_description, rank) (select id, '', 1 from demos_submission WHERE id != 1);