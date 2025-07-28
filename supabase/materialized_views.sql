CREATE MATERIALIZED VIEW IF NOT EXISTS region_category_summary AS
SELECT r.name AS region, c.name AS category, COUNT(*) AS transaction_count,
SUM(t.amount) AS total_amount, AVG(t.amount) AS avg_amount
FROM transaction t
JOIN region r ON r.id = t.region_id
JOIN category c ON c.id = t.category_id
GROUP BY r.name, c.name;