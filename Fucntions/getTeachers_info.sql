CREATE OR REPLACE FUNCTION get_teachers_of_course(_course_id INT) 
    RETURNS JSON AS $$
BEGIN
    RETURN (
        SELECT json_agg(
            json_build_object(
                'teacher_id', T.Teacher_ID,
                'name', concat(U.First_Name, ' ', U.Last_Name),
                'email', U.Email,
                'phone_no', U.Phone_No
            )
        )
        FROM Teachers T
        INNER JOIN Teaches TE 
        ON T.Teacher_ID = TE.Teacher_ID
        INNER JOIN Users U 
        ON T.Teacher_ID = U.User_ID
        WHERE TE.Course_ID = _course_id
    );
END;
$$ LANGUAGE plpgsql;


