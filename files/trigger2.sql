-- Script name: trigger2.sql
-- Author:      Mato Ramic
-- Purpose:     2nd trigger to create device insert from every user insert into database

SET SQL_SAFE_UPDATES = 0; 
USE SchoolManagementDB; 

DELIMITER $$
DROP TRIGGER IF EXISTS create_device_from_user $$
CREATE TRIGGER create_device_from_user 
AFTER INSERT 
ON User FOR EACH ROW
BEGIN
	INSERT INTO `Device`(user_id, connected_date)
    	VALUES(new.user_id, NOW());	
END $$
DELIMITER ;