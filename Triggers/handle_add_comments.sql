CREATE TRIGGER comment_post_trigger AFTER INSERT ON Comments
FOR EACH ROW EXECUTE FUNCTION notify_comment_post();