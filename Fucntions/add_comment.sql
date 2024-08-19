CREATE OR REPLACE FUNCTION notify_comment_post() 
    RETURNS TRIGGER 
    AS $$
DECLARE
    parent_commenter_var INT;
    discussion_participants INT;
BEGIN
    IF NEW.Parent_Comment_ID IS NOT NULL THEN
        SELECT User_ID 
        INTO parent_commenter_var 
        FROM Comments 
        WHERE ID = NEW.Parent_Comment_ID;
        PERFORM notify_user(parent_commenter_var, 'Your comment has a new reply.', NEW.Discussion_ID);
    END IF;

    FOR discussion_participants IN
        SELECT DISTINCT User_ID 
        FROM Comments 
        WHERE Discussion_ID = NEW.Discussion_ID
    
    LOOP
        PERFORM notify_user(discussion_participants, 'A new comment has been added to a discussion you are participating in.', NEW.Discussion_ID);
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;