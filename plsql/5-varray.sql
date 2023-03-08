/*VARRAY (Similar to array in other languages). user defined datatype
Elements of same datatype
Has maximum limit (define during creating) 
Every element index. Access by index.
During initializing Oracle allocates memory. No initializing = cannot assign.*/

-- 1. Create VARRAY
DECLARE
    TYPE c_type IS VARRAY(4) OF VARCHAR2(10) ; -- Defining varray. Max limit 7
    v_collection c_type := c_type(NULL, 'FRIDAY', NULL, NULL); -- declaring variable for varray + (!)initializing using constructor. Or just c_type()
BEGIN
    -- Assigning values
    v_collection(1) := 'MONDAY' ;
    v_collection(2) := 'TUESDAY' ;
    v_collection(3) := 'WEDNESDAY' ;
    v_collection(4) := 'THURSDAY' ;
    -- Accessing
    DBMS_OUTPUT.PUT_LINE(v_collection(3)) ;
END ;


-- 2. Initializing using Extend method (allocates 1 memory location)
-- Advantage - we allocate memory only of we need it during execution
DECLARE
    TYPE c_type IS VARRAY(3) OF VARCHAR2(10) ;
    v_collection c_type := c_type('Florida') ;
BEGIN
    v_collection.EXTEND(2) ;    -- Without initializing you cannot assign Tenessee. EXTEND(number of memory locations)
    v_collection(2) := 'Tennessee' ;
    v_collection(3) := 'New York' ;
END ;


-- 3. Exception errors
-- Subscript beyond count - assigning to not initialized locations 
-- Subscript outside of limit - extending (initializeing) more that VARRAY length
