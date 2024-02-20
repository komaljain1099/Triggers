USE test;
DROP TABLE IF EXISTS employee;

CREATE TABLE employee(
id INT PRIMARY KEY,
name VARCHAR(50),
working_hours INT
);

#INSERT-------------------------------------------------------------------------------
DELIMITER //
CREATE TRIGGER before_insert_working_hours
BEFORE INSERT ON employee FOR EACH ROW
BEGIN
IF NEW.working_hours<0 THEN set NEW.working_hours=0;
END IF;
END//

INSERT INTO employee VALUES (1,"Arun",6);
INSERT INTO employee VALUES (2,"Arjun",-8);

SELECT * FROM employee;

SHOW triggers;


CREATE TABLE employee_records(
message VARCHAR(50)
);
DROP TRIGGER after_insert;
DELIMITER //
CREATE TRIGGER after_insert
AFTER INSERT ON employee FOR EACH ROW
BEGIN
	INSERT INTO employee_records VALUES (concat("A new row has been inserted with name ",new.name));
END //

INSERT INTO employee VALUES (3,"Vaishali",5);
INSERT INTO employee VALUES (4,"Vishal",10);

SELECT * FROM employee_records;
SELECT * FROM employee;

#UPDATE--------------------------------------------------------------------
DELIMITER //
CREATE TRIGGER before_update
BEFORE UPDATE ON employee FOR EACH ROW
BEGIN
IF NEW.working_hours>3*OLD.working_hours
	THEN SIGNAL SQLSTATE '45000'
	SET message_text = "Error - New Working hours cannot be more than 3 times old working hours";
	END IF;
END //

update employee 
SET working_hours = 40 WHERE id=3;

SELECT * FROM employee;
    




