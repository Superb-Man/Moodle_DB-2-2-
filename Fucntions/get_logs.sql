CREATE OR REPLACE FUNCTION get_assignment_history(_assignment_id INT) 
    RETURNS JSON 
    AS $$
BEGIN
    RETURN (
        SELECT json_agg(
            json_build_object(
                'log_id', L.ID,
                'log_type', L.Log_Type,
                'description', L.Description,
                'timestamp', L.Timestamp,
                'assignment_id', L.Assignment_ID,
                'content_id', L.Content_ID,
                'teacher_id', L.Teacher_ID
            )
        )
        FROM Assignment_Log L
        WHERE L.Assignment_ID = _assignment_id
        ORDER BY L.Timestamp DESC
    );
END;
$$ LANGUAGE plpgsql;
