-- 1. DEFINITION
/*
ASSOCIATIVE ARRAY - Set of a key-value pair.
Index in VARRAY and NESTED tables is predefined by oracle (NUMBER) whereas in ASSOCIATIVE arrays both index and 
value parts are user-defined (user decides what to store). Index is not sequencial number but user-defined.
Index can be VARCHAR2, VARCHAR, STRING, LONG or PLS_INTEGER.
*/


-- 2. SYNTAX
DECLARE
    -- Define
    TYPE c_type IS TABLE OF VARCHAR2(10) INDEX BY VARCHAR2(10) ; -- types of value and index
    v_collection c_type ;  -- Declare
BEGIN
    -- Assign
    v_collection('day_1') := 'MONDAY' ;
    v_collection('day_2') := 'TUESDAY' ;
    v_collection('day_3') := 'WEDNESDAY' ;
    -- Access
    DBMS_OUTPUT.PUT_LINE(v_collection('day_1')) ;
END ;

-- PLS-00657
Oracle does not support BULK COLLECT for associative array indexed by VARCHAR2 column. Its an implementation restriction.
