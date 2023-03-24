/*
Dynamic PLSQL (BEGIN in BEGIN)
*/
DECLARE
    v_plsql VARCHAR2(200) ;
BEGIN
    v_plsql := 'DECLARE
                    v_user VARCHAR2(10) ;
                BEGIN
                    SELECT user 
                    INTO v_user 
                    FROM DUAL ;
                    
                    DBMS_OUTPUT.PUT_LINE(v_user) ;
                END ;' ;
    
    EXECUTE IMMEDIATE v_plsql ;
END ;
