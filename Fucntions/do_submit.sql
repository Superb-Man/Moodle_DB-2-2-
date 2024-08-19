CREATE OR REPLACE FUNCTION submit_assignment(
    _student_id INT,
    _assignment_id INT,
    _content_id INT
) 
	RETURNS JSON 
	AS $$
BEGIN
    INSERT INTO Submits (
        Student_ID, Assignment_ID, Submission_Date, Submission_Time, Content_ID
    ) VALUES (
        _student_id, _assignment_id, CURRENT_DATE, CURRENT_TIME, _content_id
    );
    INSERT INTO Assignment_Log (Log_Type, Description, Timestamp, Assignment_ID, Teacher_ID) 
	VALUES ('SUBMIT', 'Assignment submitted by student', CURRENT_TIMESTAMP, _assignment_id, NULL);

    INSERT INTO Notifications (User_ID, Message, Related_Record_ID)
    VALUES (_student_id, 'Your assignment has been submitted.', _assignment_id);

    RETURN json_build_object(
        'status', 'success',
        'message', 'Assignment submitted successfully.'
    );
END;
$$ LANGUAGE plpgsql;
