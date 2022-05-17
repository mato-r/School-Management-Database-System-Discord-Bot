-- Script name: tests.sql
-- Author:      Mato Ramic
-- Purpose:     test the integrity of this database system
       
	-- the database used to test the integrity of.
	SET SQL_SAFE_UPDATES = 0; 
	USE SchoolManagementDB; 
       
		-- 1. Testing Address table
		DELETE FROM Address WHERE zip = "95116";
		UPDATE Address SET street = "111 Update Ave." WHERE address_id = 2;

		-- 2. Testing Book table
		DELETE FROM Book WHERE title = "Intro to Java";
		UPDATE Book SET author = "Matt Green" WHERE author = "Michael Green";

		-- 3. Testing Class table
		DELETE FROM Class WHERE waitlist_total = 5;
		UPDATE Class SET class_limit = 45 WHERE class_id = 3;

		-- 4. Testing Course table
		DELETE FROM Course WHERE name = "CSC 645";
		UPDATE Course SET name = "CSC 510" WHERE course_id = 1;

		-- 5. Testing Department table
		DELETE FROM Department WHERE phone_id = 4;
		UPDATE Department SET name = "Math/Science" WHERE name = "Math";

		-- 6. Testing Device table
		DELETE FROM Device WHERE name = "henry pc";
		UPDATE Device SET ip = "201.11.0.1" WHERE device_id = 3;

		-- 7. Testing Employee table
		DELETE FROM Employee WHERE employee_id = 3;
		UPDATE Employee SET name = "Will Smith Jr." WHERE name = "Will Smith";

		-- 8. Testing Enrollment table
		DELETE FROM Enrollment WHERE enrollment_id = 1;
		UPDATE Enrollment SET date = "2022-01-20 00:06:30" WHERE enrollment_id = 3;

		-- 9. Testing FinancialAid table
		DELETE FROM FinancialAid WHERE type = "Loan";
		UPDATE FinancialAid SET amount = 8000.00 WHERE amount = 4912.00;

		-- 10. Testing FoodStand table
		DELETE FROM FoodStand WHERE stand_name = "Starbucks";
		UPDATE FoodStand SET stand_name = "The Best Pizza" WHERE food_stand_id = 3;

		-- 11. Testing FoodStandItem table
		DELETE FROM FoodStandItem WHERE item_name = "Pizza";
		UPDATE FoodStandItem SET item_name = "Latte" WHERE item_cost like "3.7";

		-- 12. Testing HeadofDepartment table
		DELETE FROM HeadofDepartment WHERE head_of_department_id = 2;
		UPDATE HeadofDepartment SET name = "Barry Lou" WHERE name = "Barry Tart";

		-- 13. Testing Major table
		DELETE FROM Major WHERE major_id = 3;
		UPDATE Major SET name = "Math/Science" WHERE department_id = 2;

		-- 14. Testing Minor table
		DELETE FROM Minor WHERE minor_id = 1;
		UPDATE Minor SET name = "English/Literature" WHERE minor_id = 3;

		-- 15. Testing Order table
		DELETE FROM `Order` WHERE total like 14.23;
		UPDATE `Order` SET total = 10.15 WHERE date = "2022-04-14 00:01:00";

		-- 16. Testing OrderList table
		-- Error Code: 1054. Unknown column 'order_listid' in 'where clause'
		DELETE FROM OrderList WHERE item = "5 Burgers with fries";
		-- UPDATE OrderList SET item = "Small Latte, Water" WHERE order_listid = 3;

		-- 17. Testing Payment table
		-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails 
		-- (`schoolmanagementdb`.`receipt`, CONSTRAINT `fk_payment_id_receipt` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`) ON DELETE RESTRICT)
		-- DELETE FROM Payment WHERE amount like 24.14;
		UPDATE Payment SET date = "2022-07-01 00:01:00" WHERE payment_id = 3;

		-- 18. Testing PaymentType table
		-- Error Code: 1054. Unknown column 'payment_typeid' in 'where clause'
		DELETE FROM PaymentType WHERE payment_type_name = "crypto";
		-- UPDATE PaymentType SET payment_type_name = "Credit" WHERE payment_typeid = 1;

		-- 19. Testing Phone table
		DELETE FROM Phone WHERE area_code = 408;
		UPDATE Phone SET phone_number = 1000100 WHERE area_code = 411;

		-- 20. Testing Receipt table
		DELETE FROM Receipt WHERE amount like 25.86;
		UPDATE Receipt SET date_of_payment = "2022-01-01 00:01:01" WHERE amount like 95.3;

		-- 21. Testing School table
		DELETE FROM School WHERE phone_id = 3;
		UPDATE School SET name = "De Anza" WHERE school_id = 1;

		-- 22. Testing Semester table
		DELETE FROM Semester WHERE season_year = "Summer 2021";
		UPDATE Semester SET start_date = "2022-01-28" WHERE start_date = "2022-01-24";

		-- 23. Testing Student table
		DELETE FROM Student WHERE student_id = 3;
		UPDATE Student SET name = "Jeremy T. Ward" WHERE student_id = 2;

		-- 24. Testing StudyRoom table
		DELETE FROM StudyRoom WHERE room_number = "B15";
		UPDATE StudyRoom SET room_number = "B01" WHERE study_room_id = 2;

		-- 25. Testing Supplier table
		DELETE FROM Supplier WHERE supplier_id = 1;
		UPDATE Supplier SET supplier_id = 5 WHERE supplier_name = "Coca Cola co.";

		-- 26. Testing Tuition table
		DELETE FROM Tuition WHERE amount = 3403.00;
		UPDATE Tuition SET amount = 8000.00 WHERE tuition_id = 2;

		-- 27. Testing User table
		DELETE FROM User WHERE user_id = 3;
		UPDATE User SET email = "joe@mail.sfsu.edu" WHERE user_id = 1;

		-- 28. Testing WifiNetwork table
		DELETE FROM WifiNetwork WHERE password = "password";
		UPDATE WifiNetwork SET router_brand = "Infinity" WHERE SSID = "Free Guest";