CREATE TABLE IF NOT EXISTS orders (
    id VARCHAR(27) PRIMARY KEY,
    created_at TIMESTAMPTZ NOT NULL,
    account_id VARCHAR(27) NOT NULL,
    total_price NUMERIC(10,2) NOT NULL
    );

CREATE TABLE IF NOT EXISTS order_products (
    order_id VARCHAR(27) NOT NULL,
    product_id VARCHAR(27) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_order
    FOREIGN KEY (order_id)
    REFERENCES orders(id)
    ON DELETE CASCADE
    );
