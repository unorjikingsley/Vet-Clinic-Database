/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(10,2),
    -- species varchar(255) NOT NULL,
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

/*DAY 4*/
/* Create a table named vets with the following columns: */
CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name varchar(255),
  age INT,
  date_of_graduation DATE
);

/* There is a many-to-many relationship between the tables species and vets: a vet can specialize in 
multiple species, and a species can have multiple vets specialized in it. Create a "join table" 
called specializations to handle this relationship. */
CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    CONSTRAINT fk_vets
        FOREIGN KEY (vet_id)
            REFERENCES vets(id),
    CONSTRAINT fk_species
        FOREIGN KEY (species_id)
            REFERENCES species(id)
);

/* There is a many-to-many relationship between the tables animals and vets: an animal can visit 
multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits 
to handle this relationship, it should also keep track of the date of the visit. */
CREATE TABLE visits(
    vet_id INT,
    animal_id INT,
    date_of_visit DATE,
    PRIMARY KEY (vet_id, animal_id, date_of_visit),
    CONSTRAINT fk_vets
        FOREIGN KEY (vet_id)
            REFERENCES vets(id),
    CONSTRAINT fk_animals
        FOREIGN KEY (animal_id)
            REFERENCES animals(id)
);

-- for optimization purposes

CREATE INDEX idx_animal_id ON visits (animal_id);
CREATE INDEX idx_visits_vet_id ON visits (vet_id ASC);
CREATE INDEX idx ON owners (email ASC);