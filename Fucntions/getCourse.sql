CREATE OR REPLACE FUNCTION get_course_by_name(_course_name TEXT) 
	RETURNS JSON
	AS $$
BEGIN
    RETURN (
        SELECT json_agg(json_build_object(
            'course_id', C.ID, 
            'course_name', C.Course_Name
        ))
        FROM Course C
        WHERE C.Course_Name ILIKE '%' || _course_name || '%'
    );
END;
$$ LANGUAGE plpgsql;
