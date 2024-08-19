CREATE TRIGGER before_course_delete_trigger BEFORE DELETE ON Course
FOR EACH ROW EXECUTE FUNCTION before_course_delete_trigger_function();