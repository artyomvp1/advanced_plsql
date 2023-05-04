/* 1. STATIC vs. DYNAMIC SQL
Static SQL - any SQL statement which doesn't change during the runtime and remains fixed
+ We know whether all the object over which we are writing the statement are present or not
+ The statements are hardcoded so we can tune them for optimal performance
- Lets execute only DML inside PL/SQL block, but NOT DDL

Native Dynamic SQL - any statement which is constructed at the runtime. They are built on the fly so then cannot be hardcoded
+ Flexibility 
+ Unlike static, dynamic SQL allows to execute DDL in PL/SQL (create, drop, truncate, etc.)

How to use dynamic SQL
1) EXECUTE IMMEDIATE statement
2) OPEN FOR + FETCH + CLOSE block

How to use dynamic PL/SQL
1) BULK FETCH
2) BULK EXECUTE IMMEDIATE
3) BULK FORALL
4) BULK COLLECT INTO


2. EXECUTE IMMEDIATE
Using EXECUTE IMMEDIATE we can parse and execute any SQL statement or a PL/SQL block dynamically or in Oracle DB.
The statement is the best suited for those SQL statements which return a single row of a result.

Syntax:
EXECUTE IMMEDIATE dynamic_sql_statemnt 
[INTO user_variable]    -- to hold the result
[USING binded_variables]    -- values for the dynamic query
[RETURNING|RETURN INTO]
*/
DECLARE
    v_sql VARCHAR2(100) ;
    v_emp NUMBER ;
    
BEGIN
    v_sql := 'SELECT COUNT(*) FROM customer' ;    -- query in a variable. NO SEMI COLONS inside!!!!!
    EXECUTE IMMEDIATE v_sql INTO v_emp ;    -- executing sql and hold the result in the variable
    DBMS_OUTPUT.PUT_LINE('Total is :' || v_emp) ;
    
END ;


/*
Note: EXECUTE IMMEDIATE takes only VARCHAR2 as an argument.
';' are NOT required in dynamic SQL but REQUIRED in dynamic PLSQL
*/
