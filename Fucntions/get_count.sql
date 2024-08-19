CREATE OR REPLACE FUNCTION update_submission_count_and_notify() 
	RETURNS TRIGGER 
	AS $$
BEGIN
    UPDATE Assignment
    SET Submission_Count = COALESCE(Submission_Count, 0) + 1
    WHERE ID = NEW.Assignment_ID;

    PERFORM notify_user(NEW.Student_ID, 'Your submission was received.', NEW.Assignment_ID);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

