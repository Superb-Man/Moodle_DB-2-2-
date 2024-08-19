CREATE OR REPLACE FUNCTION notify_user(
	_user_id INT, 
	_message TEXT, 
	_related_record_id INT) 
    RETURNS VOID 
    AS $$
BEGIN
    INSERT INTO Notifications (User_ID, Message, Related_Record_ID)
    VALUES (_user_id, _message, _related_record_id);
END;
$$ LANGUAGE plpgsql;