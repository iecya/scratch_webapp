-- :name install-uuid-module :!
-- :result :raw
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- :name create-endpoint-table :! :raw
-- :doc Create endpoint table
CREATE TABLE IF NOT EXISTS endpoints (
    id UUID PRIMARY KEY,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
)

-- :name create-upload-table :! :raw
-- :doc Create upload table
CREATE TABLE IF NOT EXISTS uploads(
    id UUID PRIMARY KEY,
    endpoint_id UUID NOT NULL REFERENCES endpoints (id),
    uploaded_at  TIMESTAMPTZ NOT NULL DEFAULT now()
)

-- :name create-row-table :! :raw
-- :doc Create rows table
CREATE TABLE IF NOT EXISTS rows(
    id UUID PRIMARY KEY,
    upload_id UUID NOT NULL REFERENCES uploads (id)
)

-- :name create-cell-table :! :raw
-- :doc Create cell table
CREATE TABLE IF NOT EXISTS cells(
    id UUID PRIMARY KEY,
    row_id UUID NOT NULL REFERENCES rows (id),
    key TEXT NOT NULL,
    value TEXT NOT NULL
)

-- :name all-endpoints
SELECT * FROM endpoints;

-- :name create-endpoint :! :1
-- :command execute
INSERT INTO endpoints (id) VALUES (uuid_generate_v4()) RETURNING id;

-- :name clear-table :! :n
-- :doc Remove all the content from a table
DELETE FROM :table;

-- :name get-all-table-names :?
-- :doc Get the names of all the publis tables in the db
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema='public';
