CREATE OR REPLACE FUNCTION notify_assignment_deletion() 
	RETURNS TRIGGER 
	AS $$
DECLARE
    student_id_var INT;
BEGIN
    FOR student_id_var IN
        SELECT Student_ID 
        FROM Submits 
        WHERE Assignment_ID = OLD.ID
    LOOP
        PERFORM notify_user(student_id_var, 'An assignment you submitted has been deleted.', OLD.ID);
    END LOOP;

    FOR student_id_var IN
        SELECT Student_ID 
        FROM Enrolls 
        WHERE Course_ID = OLD.Course_ID 
        AND Student_ID NOT IN (
            SELECT Student_ID FROM Submits WHERE Assignment_ID = OLD.ID
        )
    LOOP
        PERFORM notify_user(student_id_var, 'An assignment has been deleted.', OLD.ID);
    END LOOP;

    DELETE FROM Submits 
	WHERE Assignment_ID = OLD.ID;

    DELETE FROM Course_Content 
	WHERE Assignment_ID = OLD.ID;
    
	DELETE FROM Assignment_Log 
	WHERE Assignment_ID = OLD.ID;
    
	DELETE FROM Discussions 
	WHERE Assignment_ID = OLD.ID;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

