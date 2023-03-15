/*
-- 1. How Oracle executes PL/SQL code

Two engines that executes code:
1 - PL/SQL engine - all the procedural code (Loops, if-else, etc...)
2 - SQL engine - all the SQL statements

Binding - when variable is assigned in SQL statement and sends back to PL/SQL engine (Example: assigned in SQL INTO statement and sends back to IF)

Context switching - changing between PL/SQL and SQL engine. Impacts performance. (SQL in FOR LOOP statement 1000 times)

Bulk binding - concept to fewer context switching during execution

Types of binding:
1) In-bind - when INSERT, UPDATE or MERGE statements stores a PL/SQL or host variable in the DB
2) Out-bind - when the RETURNING INTO clause of an INSERT, UPDATE, or DELETE statements assigns a DB value to PL/SQL host variable
3) DEFINE - when SELECT or FETCH statements assign a DB value to a PL/SQL or host variable

To implement BULK BINDING we use:
1) In-binding - transfering information from a collection into a table using FORALL
2) Out-binding - After DML operation saving modified data into a collection (Result of a DML statement into a collection) with minimal context switches. RETURNING BULK COLLECT INTO
3) DEFINE - When we want to hold the result of SQL statement in collection variable using single context switch (SELECT BULK COLLECT INTO)
*/

--2. FETCH Using bulk collect
DECLARE
    TYPE c_type IS TABLE OF NUMBER INDEX BY PLS_INTEGER ;
    v_collection c_type ;
    CURSOR v_cur IS
        SELECT customer_id
        FROM customer ;
BEGIN
    OPEN v_cur ;
    FETCH v_cur BULK COLLECT INTO v_collection ; -- BULK COLLECT FETCHING
    CLOSE v_cur ;
    
    FOR i IN v_collection.FIRST .. v_collection.LAST 
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_collection(i)) ;
    END LOOP ;
END ;
