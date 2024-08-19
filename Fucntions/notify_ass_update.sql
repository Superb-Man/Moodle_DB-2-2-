CREATE OR REPLACE FUNCTION notify_assignment_update() 
    RETURNS TRIGGER AS $$
    DECLARE
        enrolled_student_id INT;
BEGIN
    FOR enrolled_student_id IN
        SELECT e.Student_ID 
        FROM Enrolls e
        WHERE e.Course_ID = NEW.Course_ID
    LOOP
        PERFORM notify_user(enrolled_student_id, 'An assignment has been updated', NEW.ID);
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
