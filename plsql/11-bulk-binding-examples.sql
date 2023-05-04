/*1. DEFINE category transfers from SELECT result to collection

BULK COLLECT statement is used in
- SELECT
- FETCH
- RETURNING (INSERT, UPDATE, DELETE, EXECUTE IMMEDIATE)
*/

-- 1.1. Traditional way to load info into a collection
DECLARE
    TYPE c_type IS TABLE OF VARCHAR2(100) ;
    v_collection c_type := c_type() ;   -- initialize using empty constructiin
BEGIN  
    /*The number of context switches is equal to number of rows*/
    FOR i IN (SELECT * 
              FROM customer
              ) 
    LOOP
        v_collection.EXTEND ;    -- Reading one by one and extending collection
        v_collection(v_collection.LAST) := i.first_name ;   -- storing employee name into the collection in a single context switch
    END LOOP ;
    
    /*Print the collection*/
    FOR i IN v_collection.FIRST .. v_collection.LAST
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_collection(i)) ;
    END LOOP ;
END ;


-- 1.2. Bulk collect
DECLARE
    TYPE c_type IS TABLE OF customer%ROWTYPE ;
    v_collection c_type := c_type() ;
BEGIN
    SELECT *
    BULK COLLECT INTO v_collection   -- hold the result into the collection
    FROM customer ;
    
    FOR i IN v_collection.FIRST .. v_collection.LAST
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_collection(i).first_name) ;
    END LOOP ;
END ;


/*2.1. In-binding category - from collection variable into a table (reverse of DEFINE) using FORALL
FORALL executes one DML statement for each and every row without switching between between PL/SQL and SQL engines.
- Only 1 DML in 1 FORALL
- No conditional statement
- Working with a whole collection instead of row-by-row 
- More effective performance (less context switching)
*/

-- Traditional vs. FORALL
DECLARE
    TYPE c_type IS TABLE OF customer%ROWTYPE ;
    v_collection c_type := c_type() ;
BEGIN
    SELECT *
    BULK COLLECT INTO v_collection
    FROM customer 
    ORDER BY customer_id ;
    
    /*Traditional way*/
    FOR i IN v_collection.FIRST .. v_collection.LAST   -- number of context switching is equal of number of rows causing performance degradation
    LOOP
        INSERT INTO customer_bkp VALUES v_collection(i) ;
    END LOOP ;
    
    /*FORALL*/
    FORALL i IN v_collection.FIRST .. v_collection.LAST    -- out-binding using 1 context switch
        INSERT INTO customer_bkp VALUES v_collection(i) ;
        
END ;

-- 2.2. Rows affected by FORALL
/*The SQL%BULK_ROWCOUNT cursor attribute gives granular information about the rows affected by each iteration of 
the FORALL statement. Every row in the driving collection has a corresponding row in the SQL%BULK_ROWCOUNT cursor attribute.*/
FOR i IN v_collection.FIRST .. v_collection.LAST 
LOOP
    DBMS_OUTPUT.PUT_LINE(v_collection(i) || ' Rows affected: ' || SQL%BULK_ROWCOUNT(i));
END LOOP ;


/* 3. SAVE EXCEPTION - allows FORALL statements to continue even if some of DML statements fail.
The code executes till the end and raise ONE error in the end. 

To see the errors (exceptions) during execution use SQL%BULK_EXCEPTIONS.
SQL%BULK_EXCEPTIONS - associatinve array of information about DML that failed during the most recent FORALL

SQL%BULK_EXCEPTIONS.COUNT - number of DML statements failed.
SQL%BULK_EXCEPTIONS(i).ERROR_INDEX - index of DML statement failed
SQL%BULK_EXCEPTIONS(i).ERROR_CODE - oracle DB error code for the failure
*/
DECLARE
    TYPE c_type IS TABLE OF VARCHAR2(10) ;
    v_collection c_type := c_type() ;
BEGIN
    v_collection.EXTEND(3) ;
    v_collection(1) := 'SAM' ;
    v_collection(2) := 'OLIVIA' ;    -- causes error due to 6 letters, whereas the field is VARCHAR2(5)
    v_collection(3) := 'ANNA' ;
    
    FORALL i IN v_collection.FIRST .. v_collection.LAST SAVE EXCEPTIONS    -- exception handler (try without)
        INSERT INTO tmp_customer(first_name)
        VALUES (v_collection(i)) ;

EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Number of errors: ' || SQL%BULK_EXCEPTIONS.COUNT) ;  -- number of errors occured
        
        FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
        LOOP
            DBMS_OUTPUT.PUT_LINE(SQL%BULK_EXCEPTIONS(i).ERROR_INDEX) ;  -- shows index of error in the BULK_EXCEPTION array
            DBMS_OUTPUT.PUT_LINE(SQL%BULK_EXCEPTIONS(i).ERROR_CODE) ;  -- shows code of the error
            DBMS_OUTPUT.PUT_LINE(SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE)) ;  -- shows description of the error
        END LOOP ;
        
END ;
