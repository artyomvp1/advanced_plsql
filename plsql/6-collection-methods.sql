-- Collection methods

DECLARE
    TYPE c_type IS VARRAY(10) OF VARCHAR2(10) ;
    v_collection c_type := c_type('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY') ;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_collection.LIMIT) ; -- max capacity of a collection
    DBMS_OUTPUT.PUT_LINE(v_collection.COUNT) ; -- number of ACTUAL INITIALIZED elements
    DBMS_OUTPUT.PUT_LINE(v_collection.FIRST) ; -- same for LAST
    v_collection.TRIM(2) ; -- deletes the N LAST element
    v_collection.DELETE ; -- deletes ALL the elements 
    v_collection.EXTEND(3) ; -- Extends number of INITIALIZED elements to 3
    DBMS_OUTPUT.PUT_LINE(v_collection.PRIOR(3)) ; -- element before '3';
    DBMS_OUTPUT.PUT_LINE(v_collection.NEXT(2)) ; -- element after 3
END ;

/*Not mandatory to emphisize N in PRIOR, NEXT, EXTEND*/
