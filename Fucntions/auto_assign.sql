CREATE OR REPLACE FUNCTION assign_teacher_to_course(
    _teacher_id INT, 
    _course_id INT
) 
	RETURNS JSON 
	AS $$
BEGIN
    INSERT INTO Teaches (Teacher_ID, Course_ID) VALUES (_teacher_id, _course_id);
    
    UPDATE Assignment
    SET Evaluation_Teacher_ID = _teacher_id
    WHERE Course_ID = _course_id 
    AND Evaluation_Teacher_ID IS NULL;
    
    INSERT INTO Notifications (User_ID, Message, Related_Record_ID)
    
    VALUES (_teacher_id, 'You have been assigned to a new course.', _course_id);

    RETURN json_build_object(
        'status', 'success',
        'message', 'Teacher assigned and evaluations updated.'
    );
END;
$$ LANGUAGE plpgsql;