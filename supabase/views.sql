CREATE OR REPLACE VIEW transaction_flat_view AS
SELECT t.id, v.name AS vendor, v.code AS vendor_code, r.name AS region, c.name AS category,
t.amount, t.currency, t.transaction_date
FROM transaction t
JOIN vendor v ON v.id = t.vendor_id
JOIN region r ON r.id = t.region_id
JOIN category c ON c.id = t.category_id;