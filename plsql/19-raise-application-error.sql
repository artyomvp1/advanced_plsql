-- RAISE_APPLICATION ERROR - creates customer exceptions with customer message

DECLARE
    v_number NUMBER := 9; 
BEGIN
    IF v_number < 10 THEN
        RAISE_APPLICATION_ERROR(-20999, 'You are wrong') ; -- error range between -20000 and -20999
    END IF ;
        
END ;
/
