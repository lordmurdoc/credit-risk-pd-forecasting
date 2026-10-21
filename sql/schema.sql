-- PostgreSQL schema for the supplied synthetic CSV files.
-- Raw CSV headers are in Portuguese but their column ORDER matches these tables.
CREATE SCHEMA IF NOT EXISTS raw;

CREATE TABLE IF NOT EXISTS raw.contracts (
    loan_id INTEGER PRIMARY KEY,
    segment VARCHAR(12) NOT NULL,
    rating VARCHAR(1) NOT NULL,
    origination_date DATE NOT NULL,
    original_value NUMERIC(14,2) NOT NULL,
    annual_int_rate NUMERIC(6,4),
    months_term INTEGER,
    lgd_est NUMERIC(6,4)
);

CREATE TABLE IF NOT EXISTS raw.monthly_performance (
    loan_id INTEGER NOT NULL REFERENCES raw.contracts(loan_id),
    reference_month DATE NOT NULL,
    outstanding_balance NUMERIC(14,2),
    days_past_due INTEGER,
    new_default INTEGER,
    PRIMARY KEY (loan_id, reference_month)
);
