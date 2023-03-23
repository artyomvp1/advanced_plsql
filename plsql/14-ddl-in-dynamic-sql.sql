/* 
PLSQL block doesn't support DDL.
To execute DDL (create, alter, drop) you need to use EXECUTE IMMEDIATE or DBMS_SQL package
*/

-- CREATE
DECLARE
    v_sql VARCHAR2(100) ;
BEGIN   
    v_sql := 'CREATE TABLE test_table (c_id NUMBER, c_name VARCHAR2(10))' ;
    EXECUTE IMMEDIATE v_sql ;
END ;


-- ALTER
DECLARE
    v_sql VARCHAR2(100) ;
BEGIN
    v_sql := 'ALTER TABLE test_table ADD c_age NUMBER' ;
    EXECUTE IMMEDIATE v_sql ;
END ;

-- DROP
DECLARE
    v_sql VARCHAR2(100) ;
BEGIN
    v_sql := 'DROP TABLE test_table' ;
    EXECUTE IMMEDIATE v_sql ;
END ;
