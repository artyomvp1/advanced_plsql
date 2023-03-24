/*
Bulk collection in dynamic SQL
BULK COLLECT INTO works as an attribute to EXECUTE IMMEDIATE
*/
DECLARE
    TYPE c_type IS TABLE OF VARCHAR2(10) ;
    v_collection c_type := c_type() ;
    v_sql VARCHAR2(200) ;
BEGIN
    v_sql := 'SELECT last_name FROM customer' ; -- regular query for the collection
    EXECUTE IMMEDIATE v_sql BULK COLLECT INTO v_collection ; -- Bulk collect as a method to EXECUTE IMMEDIATE
    
    FOR i IN v_collection.FIRST .. v_collection.LAST
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_collection(i)) ;
    END LOOP ;
END ;
