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

/* Add column to animals */

ALTER TABLE animals
ADD species VARCHAR(255);

/* day 3 - Create another tables */

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name varchar(255),
    age integer
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name varchar(255)
);

/* Make sure that id is set as autoincaletrremented PRIMARY KEY */
ALTER TABLE animals
ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;

/* Remove the species column */
ALTER TABLE animals
DROP COLUMN species;

/* Add column species_id which is a foreign key referencing species table */
ALTER TABLE animals
ADD COLUMN species_id INT,

ALTER TABLE animals
ADD FOREIGN KEY (species_id),
REFERENCES species(id);

/* Add column owner_id which is a foreign key referencing the owners table */
ALTER TABLE animals
ADD COLUMN owner_id INT,

ALTER TABLE animals
ADD FOREIGN KEY (owner_id),
  REFERENCES owners(id);


-- cr
--   -- Modify animals table
-- alter table animals add primary key(id); -- Set Id column as primary key in animals table
-- -- Remove column species
-- alter table animals
-- drop column species;
-- -- Add species_id column to animals table an set it as foreign key referencing species table
-- alter table animals add column species_id int;
-- alter table animals add foreign key (species_id) references species(id);
-- -- Add owners_id column to animals table an set it as foreign key referencing owners table
-- alter table animals add column owner_id int;
-- alter table animals add foreign key (owner_id) references owners(id);
