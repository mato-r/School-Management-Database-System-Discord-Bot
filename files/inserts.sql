   -- Script name: inserts.sql
   -- Author:      Mato Ramic
   -- Purpose:     insert sample data to test the integrity of this database system
   
   -- the database used to insert the data into.
   SET SQL_SAFE_UPDATES = 0; 
   USE SchoolManagementDB; 
   
      -- Address table inserts
      INSERT INTO Address (address_id, street, city, state, zip, country) VALUES 
      (1, "123 Nice St.", "San Jose", "CA", "95116", "United States"), 
      (2, "456 Street Ave.", "San Francisco", "CA", "94117", "United States"), 
      (3, "789 Milky Way", "San Diego", "CA", "92800", "United States");      

        -- Phone table inserts
      INSERT INTO Phone(phone_id, country_code, area_code, phone_number) VALUES 
      (1, 1, 408, 5828458), 
      (2, 1, 473, 3959395), 
      (3, 1, 384, 3632943),
      (4, 1, 834, 6464335),
      (5, 1, 363, 3958295),
      (6, 1, 411, 9483928);  
      
      -- School table inserts
      INSERT INTO School(school_id, name, address, phone_id) VALUES 
      (1, "SJSU", 1, 1), 
      (2, "SFSU", 2, 2), 
      (3, "SDSU", 3, 3);  

       -- Department table inserts
      INSERT INTO Department(department_id, name, phone_id) VALUES 
      (1, "Computer Science", 4), 
      (2, "Math", 5), 
      (3, "English", 6); 

      -- Book table inserts
      INSERT INTO Book(ISBM, title, author) VALUES 
      (1, "Harry Potter", "J.K Rowling"), 
      (2, "Math 101", "Michael Green"), 
      (3, "Intro to Java", "Stanley Yelnats"); 

      -- Course table inserts
      INSERT INTO Course(course_id, school_id, department_id, name, course_number) VALUES 
      (1, 1, 1, "CSC 675", 8132832), 
      (2, 1, 1, "CSC 645", 7823282), 
      (3, 1, 2, "MATH 228", 8283288);    
      
      -- Class table inserts
      INSERT INTO Class(class_id, course_id, class_limit, waitlist_limit, class_total, waitlist_total) VALUES 
      (1, 1, 40, 10, 40, 5), 
      (2, 1, 35, 10, 35, 8), 
      (3, 2, 30, 10, 25, 0);     

        -- User table inserts
      INSERT INTO User(user_id, email, password) VALUES 
      (1, "test@gmail.com", "12345678"), 
      (2, "mydb@gmail.com", "password"), 
      (3, "te@mail.sfsu.edu", "12345"); 

      -- Device table inserts
      INSERT INTO Device(device_id, name, ip, connected_date) VALUES 
      (4, "henry pc", "121.0.10.1", "2022-01-15 00:01:00"), 
      (5, "mike iphone", "153.5.32.2", "2022-02-13 00:01:00"), 
      (6, "mary ipad", "245.35.35.2", "2022-04-13 00:01:00");    

      -- Employee table inserts
      INSERT INTO Employee(employee_id, name, date_of_hire) VALUES 
      (1, "Jimmy Yao", "2022-07-15 00:01:00"), 
      (2, "Will Smith", "2022-09-15 00:01:00"), 
      (3, "Mia Wallace", "2022-01-15 00:01:00");   

      -- Enrollment table inserts
      INSERT INTO Enrollment(enrollment_id, date) VALUES 
      (1, "2022-04-03 00:01:00"), 
      (2, "2022-04-01 00:01:00"), 
      (3, "2022-04-04 00:01:00");   

	  -- FinancialAid table inserts
      INSERT INTO FinancialAid(financial_id, amount, type) VALUES 
      (1, 3000.00, "Grant"), 
      (2, 1500.00, "Loan"), 
      (3, 4912.00, "Grant");    

      -- FoodStand table inserts
      INSERT INTO FoodStand(food_stand_id, stand_name) VALUES 
      (1, "Mike's Burgers"), 
      (2, "Starbucks"), 
      (3, "The Pizzeria");   

      -- FoodStandItem table inserts
      INSERT INTO FoodStandItem(food_stand_item_id, food_stand_id, item_name, item_cost) VALUES 
      (1, 3, "Pizza", 10.50), 
      (2, 2, "Mocha", 5.50), 
      (3, 1, "Cheeseburger", 3.70);  

      -- HeadofDepartment table inserts
      INSERT INTO HeadofDepartment(head_of_department_id, name) VALUES 
      (1, "Mary Smith"), 
      (2, "Jerry Joe"), 
      (3, "Barry Tart");    

      -- Major table inserts
      INSERT INTO Major(major_id, department_id, name) VALUES 
      (1, 1, "Computer Science"), 
      (2, 2, "Math"), 
      (3, 3, "English");  

      -- Minor table inserts
      INSERT INTO Minor(minor_id, department_id, name) VALUES 
      (1, 1, "Computer Science"), 
      (2, 2, "Math"), 
      (3, 3, "English");  

      -- Order table inserts
      INSERT INTO `Order`(order_id, total, date) VALUES 
      (1, 14.23, "2022-04-15 00:01:00"), 
      (2, 20.25, "2022-04-12 00:01:00"), 
      (3, 25.10, "2022-04-14 00:01:00"); 

      -- OrderList table inserts
      INSERT INTO OrderList(order_list_id, order_id, item) VALUES 
      (1, 1, "Large Pizza with drink"), 
      (2, 2, "5 Burgers with fries"), 
      (3, 3, "Large Latte, Medium Mocha");  

      -- Payment table inserts
      INSERT INTO Payment(payment_id, date, amount) VALUES 
      (1, "2022-06-12 00:01:00", 24.14), 
      (2, "2022-03-12 00:01:00", 25.25), 
      (3, "2022-01-19 00:01:00", 64.34);   

      -- PaymentType table inserts
      INSERT INTO PaymentType(payment_type_id, payment_type_name) VALUES 
      (1, "Visa"), 
      (2, "Debit"), 
      (3, "Crypto"); 

      -- Receipt table inserts
      INSERT INTO Receipt(receipt_id, date_of_payment, amount) VALUES 
      (4, "2022-03-18 00:01:00", 14.52), 
      (5, "2022-02-15 00:01:00", 95.30), 
      (6, "2022-01-04 00:01:00", 25.86);  

      -- Semester table inserts
      INSERT INTO Semester(semester_id, season_year, start_date, end_date) VALUES 
      (1, "Fall 2021", "2021-08-15", "2021-12-15"), 
      (2, "Summer 2021", "2021-06-03", "2021-08-13"), 
      (3, "Spring 2022", "2022-01-24", "2022-05-27");   

      -- Student table inserts
      INSERT INTO Student(student_id, name) VALUES 
      (1, "Mikey Smith"), 
      (2, "Jeremy Ward"), 
      (3, "Elizabeth Taylor"); 

      -- StudyRoom table inserts
      INSERT INTO StudyRoom(study_room_id, room_number) VALUES 
      (1, "G467"), 
      (2, "B12"), 
      (3, "B15");  

      -- Supplier table inserts
      INSERT INTO Supplier(supplier_id, supplier_name) VALUES 
      (1, "Pizza co."), 
      (2, "Meat Delivery co."), 
      (3, "Coca Cola co.");  

      -- Tuition table inserts
      INSERT INTO Tuition(tuition_id, date, amount) VALUES 
      (1, "2022-03-18 00:01:00", 3403.00), 
      (2, "2022-01-18 00:01:00", 5040.00), 
      (3, "2021-05-18 00:01:00", 3819.00);  

      -- WifiNetwork table inserts
      INSERT INTO WifiNetwork(network_id, SSID, password, router_brand, name) VALUES 
      (1, "SFSU Guest", "password", "AT&T", "Guest"), 
      (2, "SJSU Home", "12345", "Comcast", "Wifi"), 
      (3, "Free Guest", "1245322", "Google Fiber", "Wi-fi");    