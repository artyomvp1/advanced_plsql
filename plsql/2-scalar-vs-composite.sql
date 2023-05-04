/*
If a table contains 100 columns, in order to fetch all the fields using scalar dtype we need 
to declare 100 variables, whereas using record we declare only 1 variable
*/

-- Scalar
DECLARE
    v_first VARCHAR2(10) ;  -- variable 1
    v_deposit NUMBER ;      -- variable 2
BEGIN
    SELECT first_name, deposit
    INTO v_first, v_deposit  -- 1 variable hold 1 value
    FROM customer
    WHERE customer_id = 4 ;
    DBMS_OUTPUT.PUT_LINE(v_first || ':' || v_deposit) ;
END ;


-- Composite
DECLARE
    v_rec customer%ROWTYPE ;  -- variable 1
BEGIN
    SELECT *
    INTO v_rec  -- record store a WHILE 1 row of a table
    FROM customer 
    WHERE customer_id = 3 ;
    DBMS_OUTPUT.PUT_LINE(v_rec.first_name) ;  -- access individual information using v_rec.XXX
    DBMS_OUTPUT.PUT_LINE(v_rec.last_name) ;
    DBMS_OUTPUT.PUT_LINE(v_rec.birth) ;
END ;
