FROM postgres:15-alpine

# Copy schema initialization script
COPY up.sql /docker-entrypoint-initdb.d/01_up.sql
