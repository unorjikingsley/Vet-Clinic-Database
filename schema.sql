/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(10,2),
    species varchar(255) NOT NULL,
    PRIMARY KEY(id)
);

-- how to add a new column to a table

-- ALTER TABLE animals
-- ADD species VARCHAR(255);
