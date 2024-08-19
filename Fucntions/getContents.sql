CREATE OR REPLACE FUNCTION get_assignments_with_content(_course_id INT) 
    RETURNS JSON 
    AS $$
BEGIN
    RETURN (
        SELECT json_agg(
            json_build_object(
                'assignment_id', A.ID,
                'assignment_name', A.Assignment_Name,
                'content', (
                    SELECT json_agg(Name)
                    FROM Assignment_Content AC
                    WHERE AC.Assignment_ID = A.ID
                )
            )
        )
        FROM Assignment A
        WHERE A.Course_ID = _course_id
    );
END;
$$ LANGUAGE plpgsql;
