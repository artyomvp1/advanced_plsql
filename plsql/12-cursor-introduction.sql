/* 1. CURSOR INTRO
CURSOR - pointer to a memory area called context area. 
Context area is a part of memory inside the process global area (PGA).
Context area holds important information about DML statements such as.
The information contains:
- Rows returned by a query
- Number of rows processed by a query
- A pointer to the parse area in the share pool


Types of cursors:
1) Immlicit - automatically created by Oracle server everytime SQL statement is executed
    - User cannot control the behavior
2) Explicit - user defined 
    - Full control of the behavior
    - Steps to create explicit cursor: DECLARE, OPEN, FETCH, CLOSE (in implicit Oracle creates automatically)
    
DECLARE - initializing a cursor into memory
Syntax: CURSOR cursor_name IS sql_statment

OPEN - in order to put the cursor to work OPEN allocates memory
Syntax: OPEN cursor_name

FETCH - the process of retrieving the data from cursor
Syntax: FETCH cursor_name INTO variable/record

CLOSE - to release all the resorces associated with the cursor
Syntax: CURSOR cursor_name
*/


/* 2. CURSOR PARAMETERS */
SET SERVEROUTPUT ON ;
DECLARE
    v_rec sales%ROWTYPE ;
    CURSOR v_cur(c_id NUMBER, -- declaring parameter 1
                 t_amount NUMBER := 1000) IS -- declaring parameter 2 + by default
        SELECT *
        FROM sales
        WHERE customer_id = c_id  -- parameter 1
        AND total_amount > t_amount  -- parameter 2
        ;
BEGIN
    OPEN v_cur(4) ; -- arguments
    LOOP
        FETCH v_cur INTO v_rec ; -- retrieving from cursor to the record
        EXIT WHEN v_cur%NOTFOUND ; -- termination condition (when there is no data)
        DBMS_OUTPUT.PUT_LINE(v_rec.total_amount) ;
    END LOOP ;
    CLOSE v_cur ;
END ;


/*3. CURSOR FOR LOOP (no open, fetch or close)
Executes for each row until the is no data
*/
DECLARE
    -- Declaring just a cursor no variables or records needed
    CURSOR v_cur(t_amount NUMBER) IS -- parameterized cursor
        SELECT *
        FROM sales
        WHERE total_amount > t_amount ;
BEGIN
    FOR i IN v_cur(1000) -- argument for the cursor
    LOOP
        DBMS_OUTPUT.PUT_LINE(i.sale_id || ': ' || i.sales_date) ;
    END LOOP ;
END ;


-- Fast FOR loop
BEGIN
    FOR i IN (SELECT *
              FROM sales
              WHERE customer_id = 3
              )
    LOOP
        DBMS_OUTPUT.PUT_LINE(i.sales_Date) ;
    END LOOP ;
END ;
