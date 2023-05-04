-- 1. INSERT (вставляем все колонки строки в новую таблицу)
DECLARE
    v_rec customer%ROWTYPE;
BEGIN
    SELECT *
    INTO v_rec
    FROM customer
    WHERE customer_id = 6 ;
    
    v_rec.customer_id := 999 ;    -- changing CUSTOMER_ID in the record
    
    INSERT INTO customer
    VALUES v_rec ;    -- RECORD containing a whole row is being used as value
END ;


-- 2. UPDATE (копируем все колонки строки, меняем значение записи, заменяем всю строку)
DECLARE
    v_rec customer%ROWTYPE ;
BEGIN
    SELECT *
    INTO v_rec
    FROM customer
    WHERE customer_id = 1 ;
    
    v_rec.deposit := 777 ;
    
    UPDATE customer
    SET ROW = v_rec  -- Record as new values
    WHERE customer_id = 1 ;
    
END ;
