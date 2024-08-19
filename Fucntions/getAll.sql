CREATE OR REPLACE FUNCTION get_student_submissions(_course_id INT, _student_id INT) 
    RETURNS JSON
     AS $$
BEGIN
    RETURN (
        SELECT json_agg(
            json_build_object(
                'assignment_id', S.Assignment_ID,
                'submission_date', S.Submission_Date,
                'submission_time', S.Submission_Time
            )
        )
        FROM Submits S
        INNER JOIN Assignment A 
        ON S.Assignment_ID = A.ID
        WHERE A.Course_ID = _course_id 
        AND S.Student_ID = _student_id
    );
END;
$$ LANGUAGE plpgsql;

