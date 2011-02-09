-- Bug#632812
-- Bug#631562c#23


CREATE TABLE wow_cleanup (
    id integer
);

-- SELECT a.username, a.id, d.slug, d.creator_id FROM wow_collaborator AS wow   JOIN demos_submission AS d ON wow.demo_id = d.id    JOIN auth_user AS a ON wow.details_id = a.id ORDER BY d.slug ;

-- De dup

INSERT INTO wow_cleanup (id)
  SELECT wow.id FROM wow_collaborator AS wow
  JOIN demos_submission AS d ON wow.demo_id = d.id 
  JOIN auth_user AS a ON wow.details_id = a.id 
  WHERE wow.id > 
    (SELECT MIN(wow2.id) FROM wow_collaborator AS wow2
     WHERE wow2.demo_id = d.id  AND wow2.details_id = a.id  AND
           slug = 'nocomply' AND username = 'f1lt3r') AND 
           slug = 'nocomply' AND username = 'f1lt3r';

INSERT INTO wow_cleanup (id)
  SELECT wow.id FROM wow_collaborator AS wow
  JOIN demos_submission AS d ON wow.demo_id = d.id 
  JOIN auth_user AS a ON wow.details_id = a.id 
  WHERE wow.id > 
    (SELECT MIN(wow2.id) FROM wow_collaborator AS wow2
     WHERE wow2.demo_id = d.id  AND wow2.details_id = a.id  AND
           slug = 'nocomply' AND username = 'cjcliffe') AND 
           slug = 'nocomply' AND username = 'cjcliffe';

INSERT INTO wow_cleanup (id)
  SELECT wow.id FROM wow_collaborator AS wow
  JOIN demos_submission AS d ON wow.demo_id = d.id 
  JOIN auth_user AS a ON wow.details_id = a.id 
  WHERE wow.id > 
    (SELECT MIN(wow2.id) FROM wow_collaborator AS wow2
     WHERE wow2.demo_id = d.id  AND wow2.details_id = a.id  AND
           slug = 'nocomply' AND username = 'corbanbrook') AND 
           slug = 'nocomply' AND username = 'corbanbrook';

-- SELECT a.username, a.id, d.slug, d.creator_id FROM wow_collaborator AS wow   JOIN demos_submission AS d ON wow.demo_id = d.id    JOIN auth_user AS a ON wow.details_id = a.id WHERE a.id = d.creator_id ORDER BY d.slug ;

-- Author in demo creator AND wow_collaborator

INSERT INTO wow_cleanup (id)
  SELECT wow.id FROM wow_collaborator AS wow
  JOIN demos_submission AS d ON wow.demo_id = d.id 
  JOIN auth_user AS a ON wow.details_id = a.id 
  WHERE username = 'humphd' AND slug = 'nocomply';

INSERT INTO wow_cleanup (id)
  SELECT wow.id FROM wow_collaborator AS wow
  JOIN demos_submission AS d ON wow.demo_id = d.id 
  JOIN auth_user AS a ON wow.details_id = a.id 
  WHERE username = 'kig' AND slug = 'remixingreality';

DELETE FROM wow_collaborator WHERE id in (SELECT id FROM wow_cleanup);

DROP TABLE wow_cleanup;