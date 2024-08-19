CREATE TRIGGER discussion_post_trigger AFTER INSERT ON Discussions
FOR EACH ROW EXECUTE FUNCTION notify_discussion_post();