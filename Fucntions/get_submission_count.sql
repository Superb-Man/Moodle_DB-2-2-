CREATE OR REPLACE FUNCTION get_assignment_submissions(_assignment_id INT) 
    RETURNS JSON
    AS $$
BEGIN
    RETURN (
        SELECT json_build_object(
            'assignment_id', _assignment_id,
            'total_submissions', COUNT(S.*),
            'submissions', json_agg(
                json_build_object(
                    'student_id', S.Student_ID,
                    'submission_date', S.Submission_Date,
                    'submission_time', S.Submission_Time
                )
            )
        )
        FROM Submits S
        WHERE S.Assignment_ID =_assignment_id
        GROUP BY _assignment_id
    );
END;
$$ LANGUAGE plpgsql;

