
CREATE TRIGGER assignment_update_trigger AFTER UPDATE ON Assignment
FOR EACH ROW EXECUTE FUNCTION notify_assignment_update();