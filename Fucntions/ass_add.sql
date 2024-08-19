CREATE OR REPLACE FUNCTION after_assignment_insert_trigger_function()
    RETURNS TRIGGER 
    AS $$
DECLARE
    student_id_var INT;
BEGIN

    UPDATE Course
    SET Endi = GREATEST(Endi, NEW.End_Time)
    WHERE ID = NEW.Course_ID;

    FOR student_id IN
        SELECT Student_ID FROM Enrolls WHERE Course_ID = NEW.Course_ID
    LOOP
        PERFORM notify_user(student_id_var, 'A new assignment has been added to your course.', NEW.ID);
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
