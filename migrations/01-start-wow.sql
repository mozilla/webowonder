CREATE TABLE `django_content_type` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(100) NOT NULL,
    `app_label` varchar(100) NOT NULL,
    `model` varchar(100) NOT NULL,
    UNIQUE (`app_label`, `model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `auth_permission` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(50) NOT NULL,
    `content_type_id` integer NOT NULL,
    `codename` varchar(100) NOT NULL,
    UNIQUE (`content_type_id`, `codename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

ALTER TABLE `auth_permission` ADD CONSTRAINT `content_type_id_refs_id_auth_permidx` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

CREATE TABLE `auth_group_permissions` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `group_id` integer NOT NULL,
    `permission_id` integer NOT NULL,
    UNIQUE (`group_id`, `permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
ALTER TABLE `auth_group_permissions` ADD CONSTRAINT `permission_id_refs_id_auth_group_idx` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);
CREATE TABLE `auth_group` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(80) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
ALTER TABLE `auth_group_permissions` ADD CONSTRAINT `group_id_refs_id_auth_group_perm_idx` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);
CREATE TABLE `auth_user_user_permissions` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `user_id` integer NOT NULL,
    `permission_id` integer NOT NULL,
    UNIQUE (`user_id`, `permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
ALTER TABLE `auth_user_user_permissions` ADD CONSTRAINT `permission_id_refs_id_auth_perm_idx` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);
CREATE TABLE `auth_user_groups` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `user_id` integer NOT NULL,
    `group_id` integer NOT NULL,
    UNIQUE (`user_id`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
ALTER TABLE `auth_user_groups` ADD CONSTRAINT `group_id_refs_id_group_idx` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);
CREATE TABLE `auth_user` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `username` varchar(30) NOT NULL UNIQUE,
    `first_name` varchar(30) NOT NULL,
    `last_name` varchar(30) NOT NULL,
    `email` varchar(75) NOT NULL,
    `password` varchar(255) NOT NULL,
    `is_staff` bool NOT NULL,
    `is_active` bool NOT NULL,
    `is_superuser` bool NOT NULL,
    `last_login` datetime NOT NULL,
    `date_joined` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
ALTER TABLE `auth_user_user_permissions` ADD CONSTRAINT `user_id_refs_id_auth_user_user_perm_idx` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
ALTER TABLE `auth_user_groups` ADD CONSTRAINT `user_id_refs_id_auth_user_idx` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
CREATE TABLE `auth_message` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `user_id` integer NOT NULL,
    `message` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
ALTER TABLE `auth_message` ADD CONSTRAINT `user_id_refs_id_auth_message_idx` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
CREATE INDEX `auth_permission_idx` ON `auth_permission` (`content_type_id`);
CREATE INDEX `auth_message_idx` ON `auth_message` (`user_id`);
CREATE TABLE `demos_tagdescription` (
    `tag_name` varchar(50) NOT NULL PRIMARY KEY,
    `title` varchar(255) NOT NULL UNIQUE,
    `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `demos_submission` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `title` varchar(255) NOT NULL UNIQUE,
    `slug` varchar(50) NOT NULL UNIQUE,
    `summary` varchar(255) NOT NULL,
    `description` longtext NOT NULL,
    `featured` bool NOT NULL,
    `hidden` bool NOT NULL,
    `tags` varchar(255) NOT NULL,
    `screenshot_1` varchar(100) NOT NULL,
    `screenshot_2` varchar(100) NOT NULL,
    `screenshot_3` varchar(100) NOT NULL,
    `screenshot_4` varchar(100) NOT NULL,
    `screenshot_5` varchar(100) NOT NULL,
    `video_url` varchar(200),
    `demo_package` varchar(100) NOT NULL,
    `source_code_url` varchar(200),
    `license_name` varchar(64) NOT NULL,
    `creator_id` integer,
    `created` datetime NOT NULL,
    `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
ALTER TABLE `demos_submission` ADD CONSTRAINT `creator_id_refs_id_demo_sumbiss_idx` FOREIGN KEY (`creator_id`) REFERENCES `auth_user` (`id`);
CREATE INDEX `demos_submission_idx` ON `demos_submission` (`creator_id`);
CREATE TABLE `wow_collaborator` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `demo_id` integer,
    `details_id` integer,
    `rank` smallint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
ALTER TABLE `wow_collaborator` ADD CONSTRAINT `details_id_refs_id_wow_collab_details_idx` FOREIGN KEY (`details_id`) REFERENCES `auth_user` (`id`);
ALTER TABLE `wow_collaborator` ADD CONSTRAINT `demo_id_refs_id_wow_collab_demos_idx` FOREIGN KEY (`demo_id`) REFERENCES `demos_submission` (`id`);
CREATE TABLE `wow_demodetails` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `video_url` varchar(200),
    `rank` smallint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE INDEX `wow_collaborator_demo_id_idx` ON `wow_collaborator` (`demo_id`);
CREATE INDEX `wow_collaborator_details_id_idx` ON `wow_collaborator` (`details_id`);