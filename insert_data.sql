DELIMITER $$

CREATE PROCEDURE GenerateOrders()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 100 DO

        INSERT INTO Orders(customer_id, product_id, quantity, order_date)
        VALUES
        (
            FLOOR(1 + RAND()*20),
            FLOOR(1 + RAND()*15),
            FLOOR(1 + RAND()*5),
            DATE_ADD('2025-01-01', INTERVAL FLOOR(RAND()*365) DAY)
        );

        SET i = i + 1;

    END WHILE;
END$$

DELIMITER ;

CALL GenerateOrders();

DROP PROCEDURE GenerateOrders();