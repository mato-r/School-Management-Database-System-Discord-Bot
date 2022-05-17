# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

import os
import pymysql.cursors
from tabulate import tabulate
from prettytable import PrettyTable
from prettytable import DOUBLE_BORDER


db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']


def connect():
    try:
        conn = pymysql.connect(host=db_host,
                               port=3306,
                               user=db_username,
                               password=db_password,
                               db=db_name,
                               charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)
        print("Bot connected to database {}".format(db_name))
        return conn
    except:
        print("Bot failed to create a connection with your database because your secret environment variables " +
              "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(db_name))
        print("\n")

# your code here

# 1. Business Rule: Enroll a student in a class only if the student is a student at the school.
async def enrollStudent(student_id, class_id):
  db_conn = connect()
  with db_conn:
    with db_conn.cursor() as cursor:
        # Read a single record
        sql = """INSERT INTO `Enrollment`(`student_id`, `class_id`, `date`) SELECT %s,%s, NOW()
        WHERE (SELECT count(*) FROM `Student` WHERE `Student`.`student_id` = %s) > 0;"""
        cursor.execute(sql, (student_id, class_id, student_id))
        db_conn.commit()
        result =  await select("""SELECT `Enrollment`.`enrollment_id`, `Enrollment`.`student_id`, `Enrollment`.`class_id`, `Student`.`name` 
        FROM `Enrollment`
        INNER JOIN `Student` ON `Enrollment`.`student_id`=`Student`.`student_id` 
        WHERE `Enrollment`.`enrollment_id`=%s""", cursor.lastrowid)
        table = PrettyTable(['Enrollment', 'Student', 'Class', 'Name'])
        table.set_style(DOUBLE_BORDER)
        for row in result:
          table.add_row((row['enrollment_id'], row['student_id'], row['class_id'], row['name']))
        return ("```" + table.get_string() + "```")
        db_conn.close()

# 2. Business Rule: Add device of the user only if that is their 5th or less active device.
async def addDevice(user_id, name):
    db_conn = connect()
    # client = discord.Client()
    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                # Read a single record
                sql = """INSERT INTO `Device`(`user_id`, `name`, `connected_date`) SELECT %s,%s, NOW() 
                WHERE (SELECT count(*) FROM `Device` WHERE `Device`.`user_id` = %s) < 5;"""
                cursor.execute(sql, (user_id, name, user_id))
                db_conn.commit()
                table_title = ("The matching User Id's connected devices")
                result =  await select("""SELECT `Device`.`device_id`, `Device`.`user_id`, `Device`.`name` 
                FROM `Device` 
                WHERE `Device`.`user_id`=%s""", user_id)
                table = PrettyTable(['Device id', 'User id', 'name'])
                table.set_style(DOUBLE_BORDER)
                for row in result:
                  table.add_row((row['device_id'], row['user_id'], row['name']))
                return (table_title + "```" + table.get_string() + "```")
                # db_conn.close()
    except Exception as deviceError:
      print(deviceError)
      return "Error"

# 3. Business Rule: For each class, list the students currently enrolled in that class.
async def classRoster(class_id):
    db_conn = connect()
    # client = discord.Client()
    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                # Read a single record
                sql = """SELECT Enrollment.student_id, Class.course_id, Class.class_id, Course.name 
                FROM `Enrollment` 
                INNER JOIN `Class` 
                INNER JOIN `Course` ON Enrollment.class_id=Class.class_id AND Course.course_id=Class.course_id WHERE Enrollment.class_id = %s;"""
                cursor.execute(sql, (class_id))
                result = cursor.fetchall()
                table = PrettyTable(['Student id', 'Course id', 'Class id', 'Course Name'])
                table.set_style(DOUBLE_BORDER)
                for row in result:
                  table.add_row((row['student_id'], row['course_id'], row['class_id'], row['name']))
                return ("```" + table.get_string() + "```")
                db_conn.close()
    except Exception as classError:
      print(classError)
      return "Error"

# 4. Business Rule: For each department, list the courses that are offered within the department.
async def getDepartmentCourses(department_id):
    db_conn = connect()
    # client = discord.Client()
    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                # Read a single record
                sql = """SELECT Course.name, Course.course_number FROM `Course` WHERE `department_id`= %s"""
                cursor.execute(sql, (department_id))
                result = cursor.fetchall()
                return ("```" + "\n\n" + tabulate(result, headers="keys", tablefmt="fancy_grid", colalign=("center", "center")) + "```")
                db_conn.close()
    except Exception as departmentError:
      print(departmentError)
      return "Error"

# 5. Business Rule: List the majors that are offered by the school which are under a department.
async def getDepartmentMajors(department_id):
    db_conn = connect()
    # client = discord.Client()
    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                # Read a single record
                sql = """SELECT Major.major_id, Major.name FROM `Major` WHERE `department_id`= %s"""
                cursor.execute(sql, (department_id))
                result = cursor.fetchall()
                print(result)
                return ("```" + "\n\n" + tabulate(result, headers="keys", tablefmt="fancy_grid", colalign=("center", "center")) + "```")
                # return result
                db_conn.close()
    except Exception as departmentError:
      print(departmentError)
      return "Error: No department with that id"

# 6. Business Rule: List the minors that are offered by the school which are under a department.
async def getDepartmentMinors(department_id):
    db_conn = connect()
    # client = discord.Client()
    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                # Read a single record
                sql = """SELECT Minor.minor_id, Minor.name FROM `Minor` WHERE `department_id`= %s"""
                cursor.execute(sql, (department_id))
                result = cursor.fetchall()
                return ("```" + "\n\n" + tabulate(result, headers="keys", tablefmt="fancy_grid", colalign=("center", "center")) + "```")
                db_conn.close()
    except Exception as departmentError:
      print(departmentError)
      return "Error: No department with that id"

# 7. Business Rule: Find all the currently unoccupied study rooms and list them.
async def getVacantStudyRooms():
  db_conn = connect()
  with db_conn:
    with db_conn.cursor() as cursor:
        # Read a single record
        sql = """SELECT StudyRoom.study_room_id, StudyRoom.room_number FROM `StudyRoom` WHERE `booked_room_date` IS NULL;"""
        cursor.execute(sql)
        result = cursor.fetchall()
        return ("```" + "\n\n" + tabulate(result, headers="keys", tablefmt="fancy_grid", colalign=("center", "center")) + "```")
        db_conn.close()

# 8. Business Rule: For each department, find all the employees currently registered at that department.
async def getDepartmentEmployees(department_id):
    db_conn = connect()
    # client = discord.Client()
    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                # Read a single record
                sql = """SELECT Employee.name, Employee.date_of_hire FROM `Employee` WHERE `department_id`= %s"""
                cursor.execute(sql, (department_id))
                result = cursor.fetchall()
                return ("```" + "\n\n" + tabulate(result, headers="keys", tablefmt="fancy_grid", colalign=("center", "center")) + "```")
                db_conn.close()
    except Exception as departmentError:
      print(departmentError)
      return "Error"

# 9. Business Rule: For each food stand, find all the employees currently working at that food stand.
async def getFoodStandEmployees(food_stand_id):
    db_conn = connect()
    # client = discord.Client()
    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                # Read a single record
                sql = """SELECT FoodStand.food_stand_id, FoodStand.stand_name, FoodStand.employee_id, Employee.name FROM `FoodStand` INNER JOIN `Employee` ON FoodStand.employee_id=Employee.employee_id WHERE FoodStand.food_stand_id = %s;"""
                cursor.execute(sql, (food_stand_id))
                result = cursor.fetchall()
                table = PrettyTable(['Stand id', 'Stand Name', 'Employee id', 'Employee Name'])
                table.set_style(DOUBLE_BORDER)
                for row in result:
                  table.add_row((row['food_stand_id'], row['stand_name'], row['employee_id'], row['name']))
                return ("```" + table.get_string() + "```")
                db_conn.close()
    except Exception as foodstandError:
      print(foodstandError)
      return "Error"

# 10. Business Rule: Find all the food stand items that are offered at a given food stand.
async def getFoodStandItems(food_stand_id):
    db_conn = connect()
    # client = discord.Client()
    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                # Read a single record
                sql = """SELECT FoodStand.food_stand_id, FoodStand.stand_name, FoodStandItem.item_name, FoodStandItem.item_cost FROM `FoodStand` INNER JOIN `FoodStandItem` ON FoodStand.food_stand_id=FoodStandItem.food_stand_id WHERE FoodStand.food_stand_id = %s;"""
                cursor.execute(sql, (food_stand_id))
                result = cursor.fetchall()
                table = PrettyTable(['Stand id', 'Stand Name', 'Item Name', 'Item Cost'])
                table.set_style(DOUBLE_BORDER)
                for row in result:
                  table.add_row((row['food_stand_id'], row['stand_name'], row['item_name'], row['item_cost']))
                return ("```" + table.get_string() + "```")
                db_conn.close()
    except Exception as foodstandError:
      print(foodstandError)
      return "Error"

# 11. Business Rule: For each class, find what employee is teaching the class.
async def getClassEmployee(class_id):
    db_conn = connect()
    # client = discord.Client()
    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                # Read a single record
                sql = """SELECT Class.class_id, Class.class_limit, Class.waitlist_limit, Class.class_total, Class.waitlist_total, Employee.name FROM `Class` INNER JOIN `Employee` ON Class.employee_id=Employee.employee_id WHERE Class.class_id = %s;"""
                cursor.execute(sql, (class_id))
                result = cursor.fetchall()
                table = PrettyTable(['id', 'Class', 'CMax', 'Waitlist', 'WMax', 'Employee'])
                table.set_style(DOUBLE_BORDER)
                for row in result:
                  table.add_row((row['class_id'], row['class_total'], row['class_limit'], row['waitlist_total'], row['waitlist_limit'], row['name']))
                return ("```" + table.get_string() + "```")
                db_conn.close()
    except Exception as classError:
      print(classError)
      return "Error"

# 12. Business Rule: Delete a student from the class roster if they have dropped a class
async def removeStudent(class_id, student_id):
    db_conn = connect()
    # client = discord.Client()
    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                # Read a single record
                sql = """DELETE FROM Enrollment WHERE `Enrollment`.`class_id` = %s AND `Enrollment`.`student_id` = %s;"""
                cursor.execute(sql, (class_id, student_id))
                db_conn.commit()
                result =  await select("""SELECT `Enrollment`.`enrollment_id`, `Enrollment`.`student_id`, `Enrollment`.`class_id`, `Student`.`name` 
                FROM `Enrollment`
                INNER JOIN `Student` ON `Enrollment`.`student_id`=`Student`.`student_id` 
                WHERE `Enrollment`.`student_id`=%s""", student_id)
                table = PrettyTable(['Enrollment', 'Student', 'Class', 'Name'])
                table.set_style(DOUBLE_BORDER)
                for row in result:
                  table.add_row((row['enrollment_id'], row['student_id'], row['class_id'], row['name']))
                return ("```" + table.get_string() + "```")
                db_conn.close()
    except Exception as classError:
      print(classError)
      return "Error"

# 13. Business Rule: Update a semester’s start and end date.
async def updateSemester(start_date, end_date, semester_id):
    db_conn = connect()
    # client = discord.Client()
    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                # Read a single record
                sql = """UPDATE `Semester` SET `start_date`=%s,`end_date`=%s WHERE `semester_id`=%s;"""
                cursor.execute(sql, (start_date, end_date, semester_id))
                db_conn.commit()
                table_title = ("Updated Semester with the provided id")
                result =  await select("""SELECT `Semester`.`semester_id`, `Semester`.`season_year`, `Semester`.`start_date`, `Semester`.`end_date` 
                FROM `Semester` 
                WHERE `Semester`.`semester_id`=%s""", semester_id)
                table = PrettyTable(['Semester id', 'Season', 'Start', 'End'])
                table.set_style(DOUBLE_BORDER)
                for row in result:
                  table.add_row((row['semester_id'], row['season_year'], row['start_date'], row['end_date']))
                return (table_title + "```" + table.get_string() + "```")
                db_conn.close()
    except Exception as classError:
      print(classError)
      return "Error"

# 14. Business Rule: Get all of the classes that a student has taken.
async def classesTaken(student_id):
    db_conn = connect()
    # client = discord.Client()
    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                # Read a single record
                sql = """SELECT Enrollment.enrollment_id, Enrollment.student_id, Enrollment.semester_id, Class.class_id, Course.name 
                FROM `Enrollment` 
                INNER JOIN `Class` 
                INNER JOIN `Course` ON Enrollment.class_id=Class.class_id AND Course.course_id=Class.course_id WHERE Enrollment.student_id = %s;"""
                cursor.execute(sql, (student_id))
                result = cursor.fetchall()
                table = PrettyTable(['Enrollment', 'StudentId', 'Semester', 'Class', 'Name'])
                table.set_style(DOUBLE_BORDER)
                for row in result:
                  table.add_row((row['enrollment_id'], row['student_id'], row['semester_id'], row['class_id'], row['name']))
                return ("```" + table.get_string() + "```")
                db_conn.close()
    except Exception as classError:
      print(classError)
      return "Error"

# 15. Business Rule: Create a function that gets a list of employees that aren’t assigned for a department at the moment.
async def getNonAssignedEmployees():
  db_conn = connect()
  with db_conn:
    with db_conn.cursor() as cursor:
        # Read a single record
        sql = """SELECT Employee.name, Employee.date_of_hire FROM `Employee` WHERE `department_id` IS NULL;"""
        cursor.execute(sql)
        result = cursor.fetchall()
        return ("```" + "\n\n" + tabulate(result, headers="keys", tablefmt="fancy_grid", colalign=("center", "center")) + "```")
        db_conn.close()

# 16. Business Rule: Create a procedure that calculates the student’s tuition balance minus financial aid.
async def getTuitionBalance(student_id):
  db_conn = connect()
  with db_conn:
    with db_conn.cursor() as cursor:
        # Read a single record
        sql = """SELECT Tuition.amount - FinancialAid.amount AS Balance FROM `Tuition` INNER JOIN `FinancialAid` ON Tuition.student_id = FinancialAid.student_id WHERE Tuition.student_id = %s;"""
        cursor.execute(sql, (student_id))
        result = cursor.fetchall()
        table_title = ("Student's Tuition amount with provided student id")
        table = PrettyTable(['Tuition Amount'])
        table.set_style(DOUBLE_BORDER)
        balance = result[0]['Balance']
        table.add_row(([(balance)]))
        return (table_title + "```" + table.get_string() + "```")
        db_conn.close()

# 17. Business Rule: Allocate a financial aid grant or loan to a given student.
async def giveGrant(student_id, type, amount):
  db_conn = connect()
  with db_conn:
    with db_conn.cursor() as cursor:
        # Read a single record
        sql = """INSERT INTO `FinancialAid`(`student_id`, `amount`, `type`) VALUES (%s,%s,%s);"""
        cursor.execute(sql, (student_id, type, amount))
        result = cursor.fetchall()
        return result
        db_conn.close()
      
# 18. Business Rule: Delete a user device.
async def deleteDevice(user_id, name):
  db_conn = connect()
  with db_conn:
    with db_conn.cursor() as cursor:
        # Read a single record
        sql = """DELETE FROM Device WHERE `Device`.`user_id` = %s AND `Device`.`name` = %s;"""
        cursor.execute(sql, (user_id, name))
        db_conn.commit()
        table_title = ("The matching User Id's connected devices")
        result =  await select("""SELECT `Device`.`device_id`, `Device`.`user_id`, `Device`.`name` FROM `Device` 
                WHERE `Device`.`user_id`=%s""", user_id)
        table = PrettyTable(['Device id', 'User id', 'name'])
        table.set_style(DOUBLE_BORDER)
        for row in result:
          table.add_row((row['device_id'], row['user_id'], row['name']))
        return (table_title + "```" + table.get_string() + "```")
        db_conn.close()
      
# 19. Business Rule: Create a procedure to check available books which include those that have no bought or current rent date in the database system.
async def getAvailableBooks():
  db_conn = connect()
  with db_conn:
    with db_conn.cursor() as cursor:
        # Read a single record
        sql = """SELECT Book.title, Book.author FROM `Book` WHERE `bought_date` OR `rent_date` IS NULL;"""
        cursor.execute(sql)
        result = cursor.fetchall()
        return ("```" + "\n\n" + tabulate(result, headers="keys", tablefmt="fancy_grid", colalign=("center", "center")) + "```")
        db_conn.close()

async def select(sql, value_id):
    db_conn = connect()

    try:
        with db_conn:
            with db_conn.cursor() as cursor:
                cursor.execute(sql, value_id)
                result = cursor.fetchall()
                return result
                db_conn.close()
    except Exception as Error:
        print(Error)
        return "Error"

async def response(msg):
  if "$" not in msg:
      return

  command_parts = msg.split()
  bot_command = ''
  if command_parts[0]:
      bot_command = command_parts[0]
  if "$enroll_student" in bot_command:
    if len(command_parts) > 2:
      student_id = command_parts[1]
      class_id = command_parts[2]
      return await enrollStudent(student_id, class_id)
    else:
      return "Please enter a student_id and class_id number with the command"
  elif "$add_device" in bot_command:
    if len(command_parts) > 2:
        user_id = command_parts[1]
        name = command_parts[2]
        name = ''
        for i in command_parts[2:]:
                name += i + ' '
        return await addDevice(user_id, name) 
    else:
        return "Please enter a user_id number and name with the command"
  elif "$class_roster" in bot_command:
    if len(command_parts) > 1:
      class_id = command_parts[1]
      return await classRoster(class_id)
    else:
      return "Please enter a class_id number with the command"
  if "$department_courses" in bot_command:
    if len(command_parts) > 1:
        department_id = command_parts[1]
        return await getDepartmentCourses(department_id)
    else:
        return "Please enter a department_id number with the command"
  elif "$department_majors" in bot_command:
    if len(command_parts) > 1:
        department_id = command_parts[1]
        return await getDepartmentMajors(department_id)
    else:
        return "Please enter a department_id number with the command"
  elif "$department_minors" in bot_command:
    if len(command_parts) > 1:
        department_id = command_parts[1]
        return await getDepartmentMinors(department_id)
    else:
        return "Please enter a department_id number with the command"
  elif "$available_rooms" in bot_command:
    return await getVacantStudyRooms() 
  elif "$department_employees" in bot_command:
      if len(command_parts) > 1:
        department_id = command_parts[1]
        return await getDepartmentEmployees(department_id)
      else:
          return "Please enter a department_id number with the command"
  elif "$food_stand_employees" in bot_command:
      if len(command_parts) > 1:
        food_stand_id = command_parts[1]
        return await getFoodStandEmployees(food_stand_id)
      else:
          return "Please enter a food_stand_id number with the command"
  elif "$food_stand_items" in bot_command:
      if len(command_parts) > 1:
        food_stand_id = command_parts[1]
        return await getFoodStandItems(food_stand_id)
      else:
          return "Please enter a food_stand_id number with the command"
  elif "$class_professor" in bot_command:
      if len(command_parts) > 1:
        class_id = command_parts[1]
        return await getClassEmployee(class_id)
      else:
          return "Please enter a class_id number with the command"
  elif "$remove_student" in bot_command:
      if len(command_parts) > 2:
        class_id = command_parts[1]
        student_id = command_parts[2]
        return await removeStudent(class_id, student_id)
      else:
          return "Please enter a class_id and student_id number with the command"
  elif "$update_semester" in bot_command:
      if len(command_parts) > 3:
        semester_id = command_parts[1]
        start_date = command_parts[2]
        end_date = command_parts[3] 
        return await updateSemester(start_date, end_date, semester_id)
      else:
          return "Please enter a semester_id number, start_date, and end_date with the command"
  elif "$classes_taken" in bot_command:
    if len(command_parts) > 1:
      student_id = command_parts[1]
      return await classesTaken(student_id)
    else:
      return "Please enter a student_id number with the command"
  elif "$non_assigned_employees" in bot_command:
    return await getNonAssignedEmployees()
  elif "$get_tuition_balance" in bot_command:
    if len(command_parts) > 1:
      student_id = command_parts[1]
      return await getTuitionBalance(student_id)
    else:
      return "Please enter a student_id number with the command"
  elif "$give_grant" in bot_command:
    if len(command_parts) > 3:
      student_id = command_parts[1]
      type = command_parts[2]
      amount = command_parts[3]
    else:
      return "Please enter a student_id number, type of grant, and amount with the command"
    return await giveGrant(student_id, type, amount)
  elif "$delete_device" in bot_command:
    if len(command_parts) > 2:
      user_id = command_parts[1]
      name = command_parts[2]
      name = ''
      for i in command_parts[2:]:
              name += i + ' '
      return await deleteDevice(user_id, name)
    else:
      return "Please provide a matching user_id number with the device name"
  elif "$available_books" in bot_command:
    return await getAvailableBooks()
  
#   elif "/course_average" in bot_command:
#     course = command_parts[1]
#     db_response = course_avg(course)

# def student_grades(sid, course):
#   result = None
#   try: 
#       connection = connect()
#       if connection: 
#         cursor = connection.cursor()
#         query = """SELECT grades.grade as "Grades" FROM Grades
#         grades JOIN Course course on course.course_id = 
#         grades.course JOIN Student student on student.student_id =
#         grades.student WHERE student.student_id = %s AND
#         course.course_id =%s"""

#         variables = (sid, course)
#         cursor.execute(query, variables)
#         cursor.commit()
#         results = cursor.fetchall()
#         if results:
#             for student in results:
#               studen
#             return results[0]["Grades"]

#   except Exception as error:
#         result = -1
#   return result
 
