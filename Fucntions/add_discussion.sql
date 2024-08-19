CREATE OR REPLACE FUNCTION notify_discussion_post() 
    RETURNS TRIGGER 
    AS $$
DECLARE
    user_id_var INT;
BEGIN
    FOR user_id_var IN
        SELECT Student_ID 
        FROM Enrolls 
        WHERE Course_ID = (SELECT Course_ID 
                           FROM Assignment 
                           WHERE ID = NEW.Assignment_ID)
    LOOP
        PERFORM notify_user(user_id_var, 'A new discussion has been posted.', NEW.ID);
    END LOOP;

    FOR user_id_var IN
        SELECT Teacher_ID 
        FROM Teaches 
        WHERE Course_ID = (SELECT Course_ID 
                           FROM Assignment 
                           WHERE ID = NEW.Assignment_ID)
    
    LOOP
        PERFORM notify_user(user_id_var, 'A new discussion has been posted in your course.', NEW.ID);
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
