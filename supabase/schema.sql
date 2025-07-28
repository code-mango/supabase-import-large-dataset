CREATE TABLE IF NOT EXISTS vendor (id SERIAL PRIMARY KEY, code TEXT UNIQUE, name TEXT);
CREATE TABLE IF NOT EXISTS region (id SERIAL PRIMARY KEY, name TEXT UNIQUE);
CREATE TABLE IF NOT EXISTS category (id SERIAL PRIMARY KEY, name TEXT UNIQUE);
CREATE TABLE IF NOT EXISTS transaction (
    id TEXT PRIMARY KEY,
    vendor_id INT REFERENCES vendor(id),
    region_id INT REFERENCES region(id),
    category_id INT REFERENCES category(id),
    amount NUMERIC,
    currency TEXT,
    transaction_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);