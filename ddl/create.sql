CREATE TABLE account (
    id UUID,
    name TEXT,
    amount BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE MATERIALIZED VIEW v_account_summary AS 
    SELECT name, SUM(amount) FROM account GROUP BY name;