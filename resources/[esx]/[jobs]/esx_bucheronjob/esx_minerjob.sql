INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_lumberjack','Bûcheron',1)
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_lumberjack','Bûcheron', 1)
;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_lumberjack', 'Bûcheron', 1)
;

INSERT INTO `jobs`(`name`, `label`, `whitelisted`) VALUES
	('lumberjack', 'Bûcheron', 1)
;

INSERT INTO `job_grades` (id, job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	(37,'lumberjack',0,'recrue','Intérimaire', 250, '{"tshirt_1":59,"tshirt_2":0,"torso_1":56,"torso_2":0,"shoes_1":7,"shoes_2":2,"pants_1":9, "pants_2":7, "arms":0, "helmet_1":0, "helmet_2":3,"bags_1":0,"bags_2":0,"ears_1":0,"glasses_1":0,"ears_2":0,"glasses_2":0}','{}'),
	(38,'lumberjack',1,'novice','Employer', 500, '{"tshirt_1":59,"tshirt_2":0,"torso_1":56,"torso_2":0,"shoes_1":7,"shoes_2":2,"pants_1":9, "pants_2":7, "arms":0, "helmet_1":0, "helmet_2":3,"bags_1":0,"bags_2":0,"ears_1":0,"glasses_1":0,"ears_2":0,"glasses_2":0}','{}'),
	(39,'lumberjack',2,'cdisenior','Adjoint', 750, '{"tshirt_1":59,"tshirt_2":0,"torso_1":56,"torso_2":0,"shoes_1":7,"shoes_2":2,"pants_1":9, "pants_2":7, "arms":0, "helmet_1":0, "helmet_2":3,"bags_1":0,"bags_2":0,"ears_1":0,"glasses_1":0,"ears_2":0,"glasses_2":0}','{}'),
	(40,'lumberjack',3,'boss','Patron', 1000,'{"tshirt_1":59,"tshirt_2":0,"torso_1":56,"torso_2":0,"shoes_1":7,"shoes_2":2,"pants_1":9, "pants_2":7, "arms":0, "helmet_1":0, "helmet_2":3,"bags_1":0,"bags_2":0,"ears_1":0,"glasses_1":0,"ears_2":0,"glasses_2":0}','{}')
;


INSERT INTO `items` (`name`, `label`) VALUES
	('wood', 'Bois'),
	('washed_wood', 'Bois Lavé'),
	('cutted_wood', 'Bois Coupé'),

;

