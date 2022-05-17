-- MySQL Workbench Forward Engineering
SET SQL_SAFE_UPDATES = 0;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SchoolManagementDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SchoolManagementDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SchoolManagementDB` DEFAULT CHARACTER SET utf8 ;
USE `SchoolManagementDB` ;

-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Phone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Phone` (
  `phone_id` INT NOT NULL AUTO_INCREMENT,
  `country_code` TINYINT NOT NULL,
  `area_code` MEDIUMINT NOT NULL,
  `phone_number` INT NOT NULL,
  PRIMARY KEY (`phone_id`),
  UNIQUE INDEX `idPhone_UNIQUE` (`phone_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone_id` INT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE INDEX `idDepartment_UNIQUE` (`department_id` ASC) VISIBLE,
  INDEX `idPhone_idx` (`phone_id` ASC) VISIBLE,
  CONSTRAINT `fk_phone_id_department`
    FOREIGN KEY (`phone_id`)
    REFERENCES `SchoolManagementDB`.`Phone` (`phone_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`User` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `idProfile_UNIQUE` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `department_id` INT NULL,
  `user_id` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `ssn` INT(9) NULL,
  `dob` DATETIME NULL,
  `date_of_hire` DATETIME NOT NULL,
  `phone_id` INT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE INDEX `idEmployee_UNIQUE` (`employee_id` ASC) VISIBLE,
  INDEX `department_id_idx` (`department_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `phone_id_idx` (`phone_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_id_employee`
    FOREIGN KEY (`department_id`)
    REFERENCES `SchoolManagementDB`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_id_employee`
    FOREIGN KEY (`user_id`)
    REFERENCES `SchoolManagementDB`.`User` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_phone_id_employee`
    FOREIGN KEY (`phone_id`)
    REFERENCES `SchoolManagementDB`.`Phone` (`phone_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `total` FLOAT NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `idOrder_UNIQUE` (`order_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `dob` DATETIME NULL,
  `phone_id` INT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `idInpatientRoster_UNIQUE` (`student_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `phone_idx` (`phone_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_id_student`
    FOREIGN KEY (`user_id`)
    REFERENCES `SchoolManagementDB`.`User` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_phone_id_student`
    FOREIGN KEY (`phone_id`)
    REFERENCES `SchoolManagementDB`.`Phone` (`phone_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NULL,
  `receipt_id` INT NULL,
  `student_id` INT NULL,
  `employee_id` INT NULL,
  `date` DATETIME NOT NULL,
  `amount` FLOAT NOT NULL,
  `balance` FLOAT NULL,
  UNIQUE INDEX `idPatient_UNIQUE` (`payment_id` ASC) VISIBLE,
  PRIMARY KEY (`payment_id`),
  INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_id_payment`
    FOREIGN KEY (`order_id`)
    REFERENCES `SchoolManagementDB`.`Order` (`order_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_id_payment`
    FOREIGN KEY (`student_id`)
    REFERENCES `SchoolManagementDB`.`Student` (`student_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_id_payment`
    FOREIGN KEY (`employee_id`)
    REFERENCES `SchoolManagementDB`.`Employee` (`employee_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Semester`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Semester` (
  `semester_id` INT NOT NULL AUTO_INCREMENT,
  `season_year` VARCHAR(45) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`semester_id`),
  UNIQUE INDEX `idSchedule_UNIQUE` (`semester_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE INDEX `idAddress_UNIQUE` (`address_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`School`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`School` (
  `school_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` INT NULL,
  `phone_id` INT NULL,
  PRIMARY KEY (`school_id`),
  UNIQUE INDEX `school_id_UNIQUE` (`school_id` ASC) VISIBLE,
  INDEX `phone_idx` (`phone_id` ASC) VISIBLE,
  INDEX `address_idx` (`address` ASC) VISIBLE,
  CONSTRAINT `fk_address_school`
    FOREIGN KEY (`address`)
    REFERENCES `SchoolManagementDB`.`Address` (`address_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_phone_id_school`
    FOREIGN KEY (`phone_id`)
    REFERENCES `SchoolManagementDB`.`Phone` (`phone_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `school_id` INT NOT NULL,
  `department_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `course_number` INT NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE INDEX `idPrescription_UNIQUE` (`course_id` ASC) VISIBLE,
  INDEX `school_id_idx` (`school_id` ASC) VISIBLE,
  INDEX `department_id_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_school_id_course`
    FOREIGN KEY (`school_id`)
    REFERENCES `SchoolManagementDB`.`School` (`school_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_department_id_course`
    FOREIGN KEY (`department_id`)
    REFERENCES `SchoolManagementDB`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Class` (
  `class_id` INT NOT NULL AUTO_INCREMENT,
  `course_id` INT NOT NULL,
  `employee_id` INT NULL,
  `class_limit` INT NOT NULL,
  `waitlist_limit` INT NOT NULL,
  `class_total` INT NOT NULL,
  `waitlist_total` INT NOT NULL,
  PRIMARY KEY (`class_id`),
  UNIQUE INDEX `idBedRoster_UNIQUE` (`class_id` ASC) VISIBLE,
  INDEX `course_id_idx` (`course_id` ASC) VISIBLE,
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_id_class`
    FOREIGN KEY (`course_id`)
    REFERENCES `SchoolManagementDB`.`Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_id_class`
    FOREIGN KEY (`employee_id`)
    REFERENCES `SchoolManagementDB`.`Employee` (`employee_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Enrollment` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `class_id` INT NULL,
  `student_id` INT NULL,
  `semester_id` INT NULL,
  `receipt_id` INT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  UNIQUE INDEX `idAppointment_UNIQUE` (`enrollment_id` ASC) VISIBLE,
  INDEX `class_id_idx` (`class_id` ASC) VISIBLE,
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `semester_id_idx` (`semester_id` ASC) VISIBLE,
  CONSTRAINT `fk_class_id_enrollment`
    FOREIGN KEY (`class_id`)
    REFERENCES `SchoolManagementDB`.`Class` (`class_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_id_enrollment`
    FOREIGN KEY (`student_id`)
    REFERENCES `SchoolManagementDB`.`Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_semester_id_enrollment`
    FOREIGN KEY (`semester_id`)
    REFERENCES `SchoolManagementDB`.`Semester` (`semester_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`HeadofDepartment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`HeadofDepartment` (
  `head_of_department_id` INT NOT NULL AUTO_INCREMENT,
  `department_id` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone_id` INT NULL,
  PRIMARY KEY (`head_of_department_id`),
  UNIQUE INDEX `idInsuranceProvider_UNIQUE` (`head_of_department_id` ASC) VISIBLE,
  INDEX `idPhoen_idx` (`phone_id` ASC) VISIBLE,
  INDEX `department_id_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_id_head_of_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `SchoolManagementDB`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_phone_id_head_of_department`
    FOREIGN KEY (`phone_id`)
    REFERENCES `SchoolManagementDB`.`Phone` (`phone_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Tuition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Tuition` (
  `tuition_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL,
  `enrollment_id` INT NULL,
  `date` DATETIME NOT NULL,
  `amount` FLOAT NOT NULL,
  PRIMARY KEY (`tuition_id`),
  UNIQUE INDEX `idIllness_UNIQUE` (`tuition_id` ASC) VISIBLE,
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `enrollment_id_idx` (`enrollment_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_id_tuition`
    FOREIGN KEY (`student_id`)
    REFERENCES `SchoolManagementDB`.`Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_id_tuition`
    FOREIGN KEY (`enrollment_id`)
    REFERENCES `SchoolManagementDB`.`Enrollment` (`enrollment_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Major`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Major` (
  `major_id` INT NOT NULL AUTO_INCREMENT,
  `department_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`major_id`),
  UNIQUE INDEX `idMedication_UNIQUE` (`major_id` ASC) VISIBLE,
  INDEX `department_id_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_id_major`
    FOREIGN KEY (`department_id`)
    REFERENCES `SchoolManagementDB`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`FoodStand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`FoodStand` (
  `food_stand_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NULL,
  `stand_name` VARCHAR(45) NOT NULL,
  `phone_id` INT NULL,
  PRIMARY KEY (`food_stand_id`),
  UNIQUE INDEX `idOutpatientProvider_UNIQUE` (`food_stand_id` ASC) VISIBLE,
  INDEX `emloyee_id_idx` (`employee_id` ASC) VISIBLE,
  INDEX `phone_idx` (`phone_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_id_food_stand`
    FOREIGN KEY (`employee_id`)
    REFERENCES `SchoolManagementDB`.`Employee` (`employee_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_phone_id_food_stand`
    FOREIGN KEY (`phone_id`)
    REFERENCES `SchoolManagementDB`.`Phone` (`phone_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Supplier` (
  `supplier_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_name` VARCHAR(45) NOT NULL,
  `phone_id` INT NULL,
  PRIMARY KEY (`supplier_id`),
  UNIQUE INDEX `idVendor_UNIQUE` (`supplier_id` ASC) VISIBLE,
  INDEX `phone_idx` (`phone_id` ASC) VISIBLE,
  CONSTRAINT `fk_phone_id_supplier`
    FOREIGN KEY (`phone_id`)
    REFERENCES `SchoolManagementDB`.`Phone` (`phone_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`FoodStandItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`FoodStandItem` (
  `food_stand_item_id` INT NOT NULL AUTO_INCREMENT,
  `food_stand_id` INT NOT NULL,
  `item_name` VARCHAR(45) NOT NULL,
  `item_cost` FLOAT NOT NULL,
  PRIMARY KEY (`food_stand_item_id`),
  UNIQUE INDEX `idMedicalRecord_UNIQUE` (`food_stand_item_id` ASC) VISIBLE,
  INDEX `food_stand_id_idx` (`food_stand_id` ASC) VISIBLE,
  CONSTRAINT `fk_food_stand_id_food_stand_item`
    FOREIGN KEY (`food_stand_id`)
    REFERENCES `SchoolManagementDB`.`FoodStand` (`food_stand_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`FinancialAid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`FinancialAid` (
  `financial_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL,
  `date` DATETIME NULL,
  `amount` FLOAT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`financial_id`),
  UNIQUE INDEX `idPatientVisit_UNIQUE` (`financial_id` ASC) VISIBLE,
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_id_financial_aid`
    FOREIGN KEY (`student_id`)
    REFERENCES `SchoolManagementDB`.`Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`StudyRoom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`StudyRoom` (
  `study_room_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL,
  `employee_id` INT NULL,
  `room_number` VARCHAR(20) NOT NULL,
  `booked_room_date` DATETIME NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  PRIMARY KEY (`study_room_id`),
  UNIQUE INDEX `idRoomRoster_UNIQUE` (`study_room_id` ASC) VISIBLE,
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_id_study_room`
    FOREIGN KEY (`student_id`)
    REFERENCES `SchoolManagementDB`.`Student` (`student_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_id_study_room`
    FOREIGN KEY (`employee_id`)
    REFERENCES `SchoolManagementDB`.`Employee` (`employee_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`OrderList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`OrderList` (
  `order_list_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `item` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`order_list_id`),
  UNIQUE INDEX `idOrderList_UNIQUE` (`order_list_id` ASC) VISIBLE,
  INDEX `idOrder_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_id_order_list`
    FOREIGN KEY (`order_id`)
    REFERENCES `SchoolManagementDB`.`Order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`PaymentType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`PaymentType` (
  `payment_type_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL,
  `employee_id` INT NULL,
  `payment_type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`payment_type_id`),
  UNIQUE INDEX `idPaymentType_UNIQUE` (`payment_type_id` ASC) VISIBLE,
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_id_payment_type`
    FOREIGN KEY (`student_id`)
    REFERENCES `SchoolManagementDB`.`Student` (`student_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_id_payment_type`
    FOREIGN KEY (`employee_id`)
    REFERENCES `SchoolManagementDB`.`Employee` (`employee_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Book` (
  `ISBM` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL,
  `employee_id` INT NULL,
  `order_id` INT NULL,
  `payment_id` INT NULL,
  `receipt_id` INT NULL,
  `title` VARCHAR(45) NOT NULL,
  `author` VARCHAR(45) NOT NULL,
  `bought_date` DATETIME NULL,
  `rent_date` DATETIME NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  PRIMARY KEY (`ISBM`),
  UNIQUE INDEX `idCreditCard_UNIQUE` (`ISBM` ASC) VISIBLE,
  INDEX `payment_id_idx` (`payment_id` ASC) VISIBLE,
  INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_id_book`
    FOREIGN KEY (`student_id`)
    REFERENCES `SchoolManagementDB`.`Student` (`student_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_id_book`
    FOREIGN KEY (`employee_id`)
    REFERENCES `SchoolManagementDB`.`Employee` (`employee_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_id_book`
    FOREIGN KEY (`order_id`)
    REFERENCES `SchoolManagementDB`.`Order` (`order_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_id_book`
    FOREIGN KEY (`payment_id`)
    REFERENCES `SchoolManagementDB`.`Payment` (`payment_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Receipt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Receipt` (
  `receipt_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NULL,
  `payment_id` INT NULL,
  `student_id` INT NULL,
  `employee_id` INT NULL,
  `date_of_payment` TIMESTAMP NOT NULL,
  `amount` FLOAT NOT NULL,
  PRIMARY KEY (`receipt_id`),
  UNIQUE INDEX `idReceipt_UNIQUE` (`receipt_id` ASC) VISIBLE,
  INDEX `idOrder_idx` (`order_id` ASC) VISIBLE,
  INDEX `payment_id_idx` (`payment_id` ASC) VISIBLE,
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_id_receipt`
    FOREIGN KEY (`order_id`)
    REFERENCES `SchoolManagementDB`.`Order` (`order_id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_id_receipt`
    FOREIGN KEY (`payment_id`)
    REFERENCES `SchoolManagementDB`.`Payment` (`payment_id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_id_receipt`
    FOREIGN KEY (`student_id`)
    REFERENCES `SchoolManagementDB`.`Student` (`student_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_id_receipt`
    FOREIGN KEY (`employee_id`)
    REFERENCES `SchoolManagementDB`.`Employee` (`employee_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Minor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Minor` (
  `minor_id` INT NOT NULL AUTO_INCREMENT,
  `department_id` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`minor_id`),
  UNIQUE INDEX `idMedication_UNIQUE` (`minor_id` ASC) VISIBLE,
  INDEX `department_id_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_id_minor`
    FOREIGN KEY (`department_id`)
    REFERENCES `SchoolManagementDB`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`Device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`Device` (
  `device_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `name` VARCHAR(45) NULL,
  `ip` VARCHAR(45) NULL,
  `connected_date` DATETIME NOT NULL,
  PRIMARY KEY (`device_id`),
  UNIQUE INDEX `device_id_UNIQUE` (`device_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_id_device`
    FOREIGN KEY (`user_id`)
    REFERENCES `SchoolManagementDB`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SchoolManagementDB`.`WifiNetwork`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SchoolManagementDB`.`WifiNetwork` (
  `network_id` INT NOT NULL AUTO_INCREMENT,
  `SSID` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `router_brand` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`network_id`),
  UNIQUE INDEX `network_id_UNIQUE` (`network_id` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
