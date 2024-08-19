CREATE OR REPLACE FUNCTION register_user(
    _first_name VARCHAR,
    _last_name VARCHAR,
    _user_type VARCHAR, 
    _email VARCHAR,
    _phone_no VARCHAR,
    _level VARCHAR DEFAULT NULL,  
    _term VARCHAR DEFAULT NULL,   
    _department_id INT DEFAULT NULL, 
    _designation VARCHAR DEFAULT NULL 
) 
	RETURNS JSON
	LANGUAGE plpgsql 
	AS $$
	DECLARE
    new_user_id INT;
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE Email = _email) THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Email already registered.'
        );
    END IF;

    INSERT INTO Users (First_Name, Last_Name, UserType, Email, Phone_No)
    VALUES (_first_name, _last_name, _user_type, _email, _phone_no)
    RETURNING User_ID INTO new_user_id;

    IF _user_type = 'Student' THEN
        INSERT INTO Students (Student_ID, Level, Term, Department_ID)
        VALUES (new_user_id, _level, _term, NULL);
    ELSIF _user_type = 'Teacher' THEN
        IF _department_id IS NULL THEN
            RETURN json_build_object(
                'status', 'error',
                'message', 'Department ID must be provided for teachers.'
            );
        END IF;

        INSERT INTO Teachers (Teacher_ID, Department_ID, Designation)
        VALUES (new_user_id, _department_id, _designation);
    ELSE
        RETURN json_build_object(
            'status', 'error',
            'message', 'Invalid user type.'
        );
    END IF;

    RETURN json_build_object(
        'status', 'success',
        'message', 'User registered successfully.',
        'user_id', new_user_id
    );
END;
$$;