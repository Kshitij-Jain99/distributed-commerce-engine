CREATE TABLE IF NOT EXISTS accounts (
                                        id   TEXT PRIMARY KEY,
                                        name TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_accounts_name ON accounts(name);
