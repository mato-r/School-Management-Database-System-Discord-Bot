-- Changes needed to make to allow for givegrant functionality to allow insertion of a new grant or loan to given student
ALTER TABLE `FinancialAid` DROP FOREIGN KEY `fk_student_id_financial_aid`; 
ALTER TABLE `FinancialAid` ADD CONSTRAINT `fk_student_id_financial_aid` 
FOREIGN KEY (`student_id`) REFERENCES `Student`(`student_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `Enrollment` DROP FOREIGN KEY `fk_class_id_enrollment`; 
ALTER TABLE `Enrollment` ADD CONSTRAINT `fk_class_id_enrollment` 
FOREIGN KEY (`class_id`) REFERENCES `Class`(`class_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- Insertions of extra data I made to illustrate the commands properly
INSERT INTO `Enrollment`(`class_id`, `student_id`, `semester_id`, `date`) VALUES (1,2,2'2022-04-03 00:01:00');
INSERT INTO `Enrollment`(`class_id`, `student_id`, `semester_id`, `date`) VALUES (2, 2, 2, '2022-01-12 00:01:00');
INSERT INTO `Enrollment`(`class_id`, `student_id`, `semester_id`, `date`) VALUES (1,3,2,'2022-02-23 00:04:35');
UPDATE `Employee` SET `department_id` = '1' WHERE `Employee`.`employee_id` = 3;
INSERT INTO `FinancialAid`(`student_id`, `amount`, `type`) VALUES (3,4000,'GRANT');
UPDATE `Tuition` SET `student_id` = '3' WHERE `Tuition`.`tuition_id` = 2;
INSERT INTO `Student`(`name`) VALUES ('Mike Smith');
INSERT INTO `Student`(`name`) VALUES ('Jen Lee');
INSERT INTO `Student`(`name`) VALUES ('Will Doe');
INSERT INTO `Student`(`name`) VALUES ('Maya Jones');
INSERT INTO `Student`(`name`) VALUES ('Jonny Jo');
INSERT INTO `Student`(`name`) VALUES ('Mikey Wall');


