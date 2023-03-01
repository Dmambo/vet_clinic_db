/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT name FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT name FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;



BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name Like '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT here;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO here;
UPDATE animals
SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* Query to select animals table data with specific condition and also count them */

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT ROUND(AVG(weight_kg)::numeric, 2) FROM animals;
SELECT name FROM animals 
  WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
SELECT species, MIN(weight_kg), MAX(weight_kg) 
  FROM animals GROUP BY species;
SELECT species, ROUND(AVG(escape_attempts)::numeric, 0) FROM animals 
  WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;
=======

SELECT animals.name,owner.full_name FROM animals 
  JOIN owner ON animals.owner_id = owner.id 
  WHERE owner.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.full_name FROM animals
  JOIN species ON animals.species_id = species.id
  WHERE species.full_name = 'Pokemon';

-- List all owner and their animals, remember to include those that don't own any animal.
SELECT owner.full_name, animals.name FROM animals 
  RIGHT JOIN owner ON animals.owner_id = owner.id;

-- How many animals are there per species?
SELECT count(animals.name), species.full_name FROM animals 
  JOIN species ON animals.species_id = species.id 
  GROUP BY species.full_name;

-- List all Digimon owned by Jennifer Orwell.
SELECT owner.full_name, species.full_name FROM animals 
  JOIN owner ON animals.owner_id = owner.id 
  JOIN species ON animals.species_id = species.id
  WHERE species.full_name = 'Digimon'
  and owner.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, owner.full_name FROM animals
  JOIN owner ON animals.owner_id = owner.id
  WHERE animals.escape_attempts=0
  and owner.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT count(*), owner.full_name FROM animals 
  JOIN owner ON animals.owner_id = owner.id
  GROUP BY owner.full_name ORDER BY count desc;

