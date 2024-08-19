CREATE OR REPLACE FUNCTION before_course_delete_trigger_function()
	RETURNS TRIGGER 
	AS $$
DECLARE
    student_id_var INT;
    teacher_id_var INT;
BEGIN
    FOR student_id_var IN
        SELECT Student_ID FROM Enrolls WHERE Course_ID = OLD.ID
    LOOP
        PERFORM notify_user(student_id_var, 'Your course has been dropped.', OLD.ID);
    END LOOP;

    FOR teacher_id_var IN
        SELECT Teacher_ID FROM Teaches WHERE Course_ID = OLD.ID
    LOOP
        PERFORM notify_user(teacher_id_var, 'The course you were teaching has been dropped.', OLD.ID);
    END LOOP;

    DELETE FROM Submits 
	WHERE Assignment_ID IN (
		SELECT ID FROM Assignment WHERE Course_ID = OLD.ID
	);
    
	DELETE FROM Assignment 
	WHERE Course_ID = OLD.ID;
    
	DELETE FROM Teaches 
    WHERE Course_ID = OLD.ID;
    
    DELETE FROM Enrolls 
    WHERE Course_ID = OLD.ID;
    
    DELETE FROM Discussions 
    WHERE Assignment_ID 
    IN (SELECT ID 
        FROM Assignment 
        WHERE Course_ID = OLD.ID);

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;