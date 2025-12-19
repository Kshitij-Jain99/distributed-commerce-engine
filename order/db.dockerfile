FROM postgres:10.3

# Set default database credentials (used by your Order service)
ENV POSTGRES_DB=orders
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres

# Copy schema initialization script
COPY up.sql /docker-entrypoint-initdb.d/01_init.sql

# Expose PostgreSQL port
EXPOSE 5432

CMD ["postgres"]
