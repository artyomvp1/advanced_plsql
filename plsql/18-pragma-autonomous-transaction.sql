/*Tells the PL/SQL runtime engine to commit or roll back any changes made to the database inside the current block 
without affecting the main or outer transaction*/

-- Create table
CREATE TABLE test_table (c_id NUMBER, c_month VARCHAR2(10)) ;


-- Insert 2 initial rows
INSERT ALL
    INTO test_table VALUES(1, 'JAN')
    INTO test_table VALUES(2, 'FEB')
SELECT *
FROM DUAL ;


-- Insert 2 additional rows
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION ;
    
BEGIN
    INSERT INTO test_table VALUES(3, 'MARCH') ;
    INSERT INTO test_table VALUES(4, 'APRIL') ;
    
    COMMIT ; -- commit works autonomously, only for the changes within a current block!
END ;
/


-- Rollback works only over the first 2 rows
ROLLBACK ;


-- TEST
SELECT *
FROM test_table ;
