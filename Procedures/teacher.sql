CREATE OR REPLACE PROCEDURE add_teacher_to_course(
    _teacher_id INT, 
    _course_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    course_end DATE;
    existing_assignment INT;

BEGIN
    SELECT Endi INTO course_end FROM Course WHERE ID = _course_id;
    
    IF course_end IS NULL THEN
        RAISE EXCEPTION 'Course ID % does not exist.', _course_id;
    END IF;

    IF CURRENT_DATE > course_end THEN
        RAISE EXCEPTION 'Assignment failed: The course has already ended.';
    END IF;

    SELECT COUNT(*) INTO existing_assignment
    FROM Teaches
    WHERE Teacher_ID = _teacher_id AND Course_ID = _course_id;

    IF existing_assignment > 0 THEN
        RAISE NOTICE 'Teacher ID % is already assigned to course ID %.', _teacher_id, _course_id;
    ELSE
        INSERT INTO Teaches (Teacher_ID, Course_ID) VALUES (_teacher_id, _course_id);

        PERFORM notify_user(_teacher_id, 'You have been added to a course.', _course_id);
    END IF;
END;
$$;
