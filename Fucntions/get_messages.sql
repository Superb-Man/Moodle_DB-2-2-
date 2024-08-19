CREATE OR REPLACE FUNCTION get_all_messages(_user_id INT) 
	RETURNS JSON
	AS $$
BEGIN
    RETURN (
        SELECT json_agg(
            json_build_object(
                'message_id', N.ID,
                'message', N.Message,
                'related_record_id', N.Related_Record_ID,
                'created_at', N.Created_At
            )
        )
        FROM Notifications N
        WHERE N.User_ID = _user_id
        ORDER BY N.Created_At 
        DESC
    );
END;
$$ LANGUAGE plpgsql;
