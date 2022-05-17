-- Script name: trigger.sql
-- Author:      Mato Ramic
-- Purpose:     1st trigger to create a receipt from every payment insert into database

SET SQL_SAFE_UPDATES = 0; 
USE SchoolManagementDB; 
   
DELIMITER $$
DROP TRIGGER IF EXISTS create_receipt_from_payment $$
CREATE TRIGGER create_receipt_from_payment 
AFTER INSERT 
ON Payment FOR EACH ROW
BEGIN
	INSERT INTO `Receipt`(payment_id, date_of_payment, amount)
    	VALUES(new.payment_id, new.date, new.amount);	
END $$
DELIMITER ;