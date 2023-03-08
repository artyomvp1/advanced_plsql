/*Records can be defined in 2 ways: TYPE and %ROWTYPE*/

/*1. %ROWTYPE - all the fields of a base table will be inherited (table%ROWTYPE)*/
DECLARE
    v_rec customer%ROWTYPE ;
    
    
/*2. TYPE - defines CUSTOM type (only records that you need). Exapmle, if table has 100 columns, 
to not inherite 100 via %ROWTYPE we create a custom TYPE to get only 30.
(!) You create a custom type and safe in a package to use further whenever you need*/
-- 2.1 Using SELECT
DECLARE
    TYPE c_type IS RECORD (v_first VARCHAR2(100),   -- customer type
                           v_birth DATE) ;
    v_rec c_type ;    -- variable containing the record
BEGIN
    SELECT first_name, birth
    INTO v_rec
    FROM customer
    WHERE customer_id = 2 ;
    DBMS_OUTPUT.PUT_LINE(v_rec.v_first || ': ' || v_rec.v_birth) ;
END ;


-- 2.2 Using a constructor
DECLARE
    TYPE c_type IS RECORD (v_first VARCHAR2(100),
                           v_deposit NUMBER) ;
    v_rec c_type := c_type('ADA', 165000) ;    -- constructor
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_rec.v_first || ': ' || v_rec.v_deposit) ;
END ;


--2.3 Using a contraint when defining a record
DECLARE
    TYPE c_type IS RECORD (v_first VARCHAR2(100) NOT NULL := 'JASMINE',
                           v_deposit NUMBER) ;
    v_rec c_type ;
BEGIN
    v_rec.v_first := '' ;    -- Contraint violations!
    v_rec.v_deposit := 95000 ;
END ;


-- 3. %TYPE is used to not define a type of a column DIRECTLY (Inherits a datatype of a column of a base table)
DECLARE
    v_first customer.first_name%TYPE ;   -- instead of v_first VARCHAR2(100)
