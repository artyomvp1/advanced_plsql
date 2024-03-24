/*
DESCRIPTION: the approach allows to bulk collect combined queries (JOIN, WITH, etc..).
First create a custom record with all the fields.
Secondly, create a collection as a table of your custom record.
*/

-- CUSTOM COLLECTION OR RECORDS
DECLARE
    TYPE v_rec IS RECORD (v_tc_order_id NUMBER, v_description VARCHAR2(100)) ; -- declare a custom record
    TYPE c_type IS TABLE OF v_rec ; -- declare a collection of a custom record
    v_collection c_type := c_type() ;
    
BEGIN
    -- combined table
    SELECT tc_order_id, ds.description
    BULK COLLECT INTO v_collection
    FROM orders o
    LEFT JOIN do_status ds ON ds.order_status = o.do_status
    WHERE tc_order_id IN ('1221274430','1218847184','7708540847','1221053127','1219673738','1221519821','1221591402','1076955933') ;
    
    FOR i IN v_collection.FIRST .. v_collection.LAST
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_collection(i).v_tc_order_id || ' ' || v_collection(i).v_description) ;
    END LOOP ;

END ;
/
