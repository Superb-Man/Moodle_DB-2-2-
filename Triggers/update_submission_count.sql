CREATE TRIGGER submission_trigger AFTER INSERT ON Submits
FOR EACH ROW EXECUTE FUNCTION update_submission_count_and_notify();