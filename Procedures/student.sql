CREATE OR REPLACE PROCEDURE add_students_to_course(
    _student_ids INT[], 
    _course_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    student INT;  -- Rename the variable to avoid ambiguity
    course_end DATE;
    existing_enrollments INT;
BEGIN
    SELECT Endi INTO course_end FROM Course WHERE ID = _course_id;
    
    IF CURRENT_DATE > course_end THEN
        RAISE EXCEPTION 'Enrollment failed: The course has already ended.';
    END IF;
    
    FOREACH student IN ARRAY _student_ids
    LOOP
        -- Use an alias 'e' for the Enrolls table and explicitly reference the table column
        SELECT COUNT(*) INTO existing_enrollments
        FROM Enrolls e
        WHERE e.Student_ID = student AND e.Course_ID = _course_id;

        IF existing_enrollments > 0 THEN
            RAISE NOTICE 'Student ID % is already enrolled in course ID %.', student, _course_id;
        ELSE
            INSERT INTO Enrolls (Student_ID, Course_ID) VALUES (student, _course_id);

            PERFORM notify_user(student, 'You have been enrolled in a new course.', _course_id);
        END IF;
    END LOOP;
END;
$$;