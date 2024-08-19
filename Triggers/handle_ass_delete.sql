CREATE TRIGGER assignment_deletion_trigger BEFORE DELETE ON Assignment
FOR EACH ROW EXECUTE FUNCTION notify_assignment_deletion();