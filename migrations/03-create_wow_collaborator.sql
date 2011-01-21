DROP TABLE IF EXISTS `wow_collaborator`;
CREATE TABLE `wow_collaborator` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `demo_id` integer,
    `details_id` integer,
    `rank` smallint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
ALTER TABLE `wow_collaborator` ADD CONSTRAINT `details_id_refs_auth_user_id_fk` FOREIGN KEY (`details_id`) REFERENCES `auth_user` (`id`);
ALTER TABLE `wow_collaborator` ADD CONSTRAINT `demo_id_refs_demo_id_fk` FOREIGN KEY (`demo_id`) REFERENCES `demos_submission` (`id`);

-- populate table

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 1, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'unknown1' AND first_name = 'Geoffrey') 
    FROM demos_submission WHERE slug = 'motivational';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 1, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'kig') 
    FROM demos_submission WHERE slug = 'AR_models';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 1, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'unknown1' AND first_name = 'Geoffrey') 
    FROM demos_submission WHERE slug = 'immersive';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 2, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'unknown3' AND first_name = 'Benjamin') 
    FROM demos_submission WHERE slug = 'immersive';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 1, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'glecollinet')
    FROM demos_submission WHERE slug = 'globe_twitter';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 1, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'cjcliffe')
    FROM demos_submission WHERE slug = 'flight';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 2, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'corbanbrook')
    FROM demos_submission WHERE slug = 'flight';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 3, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'f1lt3r')
    FROM demos_submission WHERE slug = 'flight';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 4, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'unknown4' AND first_name = 'Andor')
    FROM demos_submission WHERE slug = 'flight';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 5, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'unknown5' AND first_name = 'Maciej')
    FROM demos_submission WHERE slug = 'flight';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 1, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'unknown1' AND first_name = 'Geoffrey')
    FROM demos_submission WHERE slug = 'mobile_player';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 1, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'unknown1' AND first_name = 'Geoffrey')
    FROM demos_submission WHERE slug = 'html5_poster';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 1, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'sork')
    FROM demos_submission WHERE slug = 'planetarium';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 1, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'cjcliffe')
    FROM demos_submission WHERE slug = 'dj_kraddy';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 2, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'corbanbrook')
    FROM demos_submission WHERE slug = 'dj_kraddy';

INSERT INTO `wow_collaborator` (rank, demo_id, details_id) 
    SELECT 3, demos_submission.id, 
           (SELECT id FROM auth_user WHERE username = 'f1lt3r')
    FROM demos_submission WHERE slug = 'dj_kraddy';

-- update demo metadata

UPDATE demos_submission SET slug = 'immersivevideo', hidden = b'0' WHERE slug = 'immersive';

