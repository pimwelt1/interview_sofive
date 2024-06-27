# Use the official PostgreSQL image as the base image
FROM postgres:16.1

# Set environment variables
ENV MYSQL_DATABASE=sofive_interview
ENV POSTGRES_USER=postgres

# Copy the .sql file to the container
COPY database_file.sql /docker-entrypoint-initdb.d/

# Expose the PSQL port
EXPOSE 5432