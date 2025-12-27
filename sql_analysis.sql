-- Create table
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    vendor_name VARCHAR(50),
    amount NUMERIC,
    cost NUMERIC,
    transaction_date DATE
);




-- Insert sample data
INSERT INTO transactions (vendor_name, amount, cost, transaction_date)
VALUES
('Vendor A', 100000, 85000, '2024-01-10'),
('Vendor B', 120000, 110000, '2024-01-12'),
('Vendor A', 90000, 95000, '2024-02-05'),
('Vendor C', 150000, 100000, '2024-02-20'),
('Vendor B', 80000, 90000, '2024-03-01');




-- Profit calculation
SELECT
    vendor_name,
    amount,
    cost,
    (amount - cost) AS profit
FROM transactions;




-- Loss detection
SELECT
    vendor_name,
    SUM(cost - amount) AS total_loss
FROM transactions
WHERE cost > amount
GROUP BY vendor_name
ORDER BY total_loss DESC;




-- Monthly summary
-- Monthly Profit Summary
SELECT
    DATE_TRUNC('month', transaction_date) AS month,
    SUM(amount) AS total_revenue,
    SUM(cost) AS total_cost,
    SUM(amount - cost) AS total_profit
FROM transactions
GROUP BY DATE_TRUNC('month', transaction_date)
ORDER BY month;




-- Vendor performance
SELECT
    vendor_name,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_revenue,
    SUM(cost) AS total_cost,
    SUM(amount - cost) AS total_profit
FROM transactions
GROUP BY vendor_name
ORDER BY total_profit DESC;




-- High profit transactions
SELECT
    vendor_name,
    amount,
    cost,
    (amount - cost) AS profit
FROM transactions
WHERE (amount - cost) > 20000
ORDER BY profit DESC;




-- Average profit per vendor
SELECT
    vendor_name,
    AVG(amount - cost) AS average_profit
FROM transactions
GROUP BY vendor_name
HAVING AVG(amount - cost) > 0
ORDER BY average_profit DESC;




-- Vendor-wise Profit Ranking Using Window Function
SELECT
    vendor_name,
    transaction_date,
    amount - cost AS profit,
    RANK() OVER (PARTITION BY vendor_name ORDER BY amount - cost DESC) AS profit_rank
FROM transactions;
