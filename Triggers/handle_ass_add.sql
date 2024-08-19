CREATE TRIGGER after_assignment_insert_trigger AFTER INSERT ON Assignment
FOR EACH ROW EXECUTE FUNCTION after_assignment_insert_trigger_function();
