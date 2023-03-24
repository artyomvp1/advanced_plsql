/*
BIND VARIABLES IN EXECUTE IMMEDIATE
- 'USING' clasue in correct order

Why to use bind variables
+ Security against SQL injections
+ Performance enhancement by reducing hard parcing
- Binding variable applies only for values not schema names (you cannot bind table name etc)
*/

-- INSERT with miltiple bind variables
DECLARE
    v_sql VARCHAR2(100) ;
BEGIN
    v_sql := 'INSERT INTO test_table VALUES (:value1, :value2)' ;
    EXECUTE IMMEDIATE v_sql USING 1, 'SAM' ;
    COMMIT ;
END ;


-- UPDATE with miltiplebind variables
DECLARE
    v_sql VARCHAR2(100) ;
BEGIN
    v_sql := 'UPDATE test_table 
              SET c_name = :value1
              WHERE c_name = :value2' ;
    EXECUTE IMMEDIATE v_sql USING 'ANNA', 'SAM' ;
    COMMIT ;
END ;
