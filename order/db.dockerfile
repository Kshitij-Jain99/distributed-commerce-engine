FROM postgres:15-alpine

# Initialize schema on first startup
COPY up.sql /docker-entrypoint-initdb.d/01_up.sql
