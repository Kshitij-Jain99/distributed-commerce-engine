FROM postgres:15-alpine

# Default database configuration
ENV POSTGRES_DB=account
ENV POSTGRES_USER=account
ENV POSTGRES_PASSWORD=account

# Run schema on first startup
COPY up.sql /docker-entrypoint-initdb.d/01_up.sql
