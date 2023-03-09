-- 1. What is a nested table
/*
- Nested table - is a COLUMN TYPE that stores an unspecified number of rows in no particular order
- Use when we don't know the number of elements
*/


-- 2. Difference between NESTED TABLE and VARRAY
/*
- (!)Allocated memory for the nested table can increase or decrease DYNAMICALLY, as you add 
  or delete elements (can EXTEND location for the 5th element even if initialized 4 values)
- Unlike VARRAY, the nested table doesn't declare a number of elements
- (!)Nested table is dense initially (unlike varray) but can become sparse, as you delete elements from it
*/


-- 3. SYNTAX
DECLARE
    -- DEFINITION
    TYPE c_type IS TABLE OF VARCHAR2(30) ;
    -- DECLARATION + INITIALIZATION
    v_collection c_type := c_type(NULL, NULL, NULL, NULL) ;
BEGIN
    -- ASSIGNING
    v_collection(1) := 'MONDAY' ;
    v_collection(2) := 'TUESDAY' ;
    v_collection(3) := 'WEDNESDAY' ;
    v_collection(4) := 'THURSDAY' ;
    -- ACCESS
    DBMS_OUTPUT.PUT_LINE(v_collection(2)) ;
END ;


-- 4. Method EXISTS
/*
v_collection.EXISTS - check the value and returns boolean whether it exists
*/
