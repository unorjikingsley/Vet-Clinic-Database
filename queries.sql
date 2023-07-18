/*Queries that provide answers to the questions from all projects.*/

SELECT name FROM animals
WHERE name LIKE '%mon';

SELECT name FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals
WHERE neutered=true AND escape_attempts<3;

SELECT date_of_birth FROM animals
WHERE name='Agumon' OR name='Pikachu';

SELECT name, escape_attempts FROM animals 
WHERE weight_kg>10.5;

SELECT * FROM animals 
WHERE neutered=true;

SELECT * FROM animals 
WHERE name <> 'Gabumon';

SELECT * FROM animals 
WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT species FROM animals;

COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
SAVEPOINT SP4;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP5;

UPDATE animals
SET weight_kg = weight_kg * (-1);

ROLLBACK TO SAVEPOINT SP5;

UPDATE animals
SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;

COMMIT;

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) AS escapes
FROM animals
GROUP BY neutered
ORDER BY escapes DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

/* JOIN */
/* Write queries (using JOIN) to answer the following questions: */

/* What animals belong to Melody Pond? */
SELECT name FROM animals
JOIN owners ON owner_id = owner.id
WHERE owners.id = 4;

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT animals.name FROM animals
JOIN species ON species_id = species.id
WHERE species.id = 1;

/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT name, full_name FROM owners
LEFT JOIN animals ON owners.id = owner_id;

/* How many animals are there per species? */
SELECT COUNT(animals.id), species.name FROM animals
JOIN species ON species_id = species.id
GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT animals.name FROM species
JOIN animals ON species.id = species_id
JOIN owners ON owner_id = owners.id
WHERE owners.name = 2 AND species.name = 'Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT name FROM animals
JOIN owners ON owner_id = owners.id
WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

/* Who owns the most animals? */
SELECT full_name FROM owners
JOIN animals ON owners.id = owner_id
GROUP BY full_name
ORDER BY COUNT(*)
DESC LIMIT 1;

/* DAY 4 */
/* Write queries to answer the following */

/* Who was the last animal seen by William Tatcher? */
SELECT vets.name AS "Vet Name", animals.name AS "Animal Name", visits.date_of_visit
  FROM vets
  INNER JOIN visits
    ON vets.id = visits.vet_id
  INNER JOIN animals
    ON visits.animal_id = animals.id
  WHERE vets.name = 'William Tatcher'
  ORDER by date_of_visit DESC LIMIT 1;

/* How many different animals did Stephanie Mendez see? */
SELECT vets.name AS "Vet Name", COUNT(DISTINCT animals.name)
   FROM vets
   INNER JOIN visits
     ON vets.id = visits.vet_id
   INNER JOIN animals
     ON visits.animal_id = animals.id
   WHERE vets.name = 'Stephanie Mendez'
   GROUP BY vets.name;


/* List all vets and their specialties, including vets with no specialties. */
SELECT vets.name AS "Vet Name", species.name AS "Species"
  FROM vets
  FULL OUTER JOIN specializations
    ON vets.id = specializations.vet_id
  FULL OUTER JOIN species
    ON species.id = specializations.species_id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT animals.name AS "Animal", visits.date_of_visit
  FROM animals
  JOIN visits
    ON animals.id = visits.animal_id
  WHERE visits.vet_id = (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez')
  AND
  visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

/* What animal has the most visits to vets? */
SELECT animals.name, COUNT(*)
  FROM animals
  JOIN visits
    ON animals.id = visits.animal_id
  GROUP BY animals.name
  ORDER BY count DESC LIMIT 1;

/*Who was Maisy Smith's first visit?*/
SELECT vets.name AS "Vet", animals.name AS "Animal", visits.date_of_visit
  FROM vets
  JOIN visits
    ON vets.id = visits.vet_id
  JOIN animals
    ON visits.animal_id = animals.id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY date_of_visit LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT
  vets.id AS "Vet id", vets.name AS "Vet", date_of_graduation,
  visits.date_of_visit,
  animals.id AS "Animal id", animals.name AS "Animal", date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id
  FROM vets
  JOIN visits
    ON vets.id = visits.vet_id
  JOIN animals
    ON visits.animal_id = animals.id
  ORDER BY date_of_visit DESC LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT vets.name AS "Vet", COUNT(*) FROM visits 
LEFT JOIN vets ON visits.vet_id = vets.id
LEFT JOIN specializations ON vets.id = specializations.vet_id 
LEFT JOIN species ON specializations.species_id = species.id 
WHERE specializations.species_id IS NULL OR specializations.species_id != species.id 
GROUP BY vets.name;

-- SELECT vets.name
--   FROM vets
--   JOIN visits
--     ON vets.id = visits.vet_id
--   LEFT JOIN specializations
--     ON vets.id = specializations.vet_id
--   WHERE specializations.vet_id IS NULL
--   GROUP BY vets.name;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT species.name AS "species", COUNT(animals.species_id)
  FROM vets
  JOIN visits
    ON vets.id = visits.vet_id
  JOIN animals
    ON animals.id = visits.animal_id
  JOIN species
    ON species.id = animals.species_id
  WHERE vets.name = 'Maisy Smith'
  GROUP BY species.name
ORDER BY count DESC LIMIT 1;
