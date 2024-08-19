CREATE OR REPLACE FUNCTION add_course(
    _course_name VARCHAR,
    _session VARCHAR,
    _type VARCHAR,
    _start DATE,
    _end DATE,
    _course_description TEXT,
    _department_id INT
) 
	RETURNS JSON
	LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Department WHERE ID = _department_id) THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Department ID does not exist.'
        );
    END IF;
    INSERT INTO Course (Course_Name, Session, Type, Start, Endi, Course_Description, Department_ID) 
	VALUES (_course_name, _session, _type, _start, _end, _course_description, _department_id);

    RETURN json_build_object(
        'status', 'success',
        'message', 'Course added successfully.'
    );
END;
$$;
