/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT name FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT name FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;



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

   -- Who was the last animal seen by William Tatcher?
SELECT animals.name, vets.name, visits.visited_date FROM animals
  JOIN visits on animals.id = visits.animal_id
  JOIN vets on visits.vet_id = vets.id
  WHERE vets.name = 'William Tatcher'
  ORDER BY visits.visited_date DESC lIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name, count(animals.name) FROM animals 
  JOIN visits on visits.animal_id = animals.id
  JOIN vets on vets.id = visits.vet_id
  WHERE vets.name = 'Stephanie Mendez'
  GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets
  LEFT JOIN specializations on specializations.vet_id = vets.id
  LEFT JOIN species on specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, vets.name, visits.visited_date FROM animals 
  JOIN visits on visits.animal_id = animals.id
  JOIN vets on vets.id = visits.vet_id
  WHERE vets.name = 'Stephanie Mendez'
    AND visits.visited_date
    BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, count(*) FROM animals
  JOIN visits on visits.animal_id = animals.id
  GROUP BY animals.name
  ORDER BY count desc limit 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, vets.name, visits.visited_date FROM animals
  JOIN visits on animals.id = visits.animal_id
  JOIN vets on visits.vet_id = vets.id
  WHERE vets.name = 'Maisy SMith'
  ORDER BY visits.visited_date ASC lIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, vets.name, visits.visited_date FROM animals
  JOIN visits on animals.id = visits.animal_id
  JOIN vets on visits.vet_id = vets.id
  ORDER BY visits.visited_date DESC lIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM vets 
  JOIN visits ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
  JOIN specializations ON vets.id = specializations.vet_id
  WHERE NOT specializations.species_id = animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT vets.name, species.name, count(species.name) from vets 
  JOIN visits on visits.vet_id = vets.id 
  JOIN animals on visits.animal_id = animals.id 
  JOIN species on animals.species_id = species.id 
  WHERE vets.name = 'Maisy SMith' 
  GROUP BY species.name, vets.name 
  ORDER BY count DESC lIMIT 1;



SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owner where email = 'owner_18327@mail.com';