CREATE OR REPLACE FUNCTION get_student_info(_student_id INT) 
	RETURNS JSON AS $$
BEGIN
    RETURN (
        SELECT json_build_object(
            'student_id', S.Student_ID,
            'name', concat(U.First_Name, ' ', U.Last_Name),
            'email', U.Email,
            'phone_no', U.Phone_No,
            'courses', (
                SELECT json_agg(json_build_object('course_id', C.ID, 'course_name', C.Course_Name))
                FROM Course C
                INNER JOIN Enrolls E 
                ON C.ID = E.Course_ID
                WHERE E.Student_ID = S.Student_ID
            )
        )
        FROM Students S
        INNER JOIN Users U 
        ON S.Student_ID = U.User_ID
        WHERE S.Student_ID = _student_id
    );
END;
$$ LANGUAGE plpgsql;
