/*Queries that provide answers to the questions from all projects.*/

-- create animals table----------------------------------------------

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-30';

SELECT name FROM animals WHERE neutered IS true AND escape_attempts < 3;
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;


SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pickachu';
SELECT date_of_birth FROM animals WHERE name LIKE 'Agumon' OR name LIKE 'Pickachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;

SELECT * FROM animals WHERE neutered IS true;

SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- query and update animals table -------------------------------------

BEGIN; -- starts transaction

UPDATE animals SET species = 'unspecified';

ROLLBACK; -- ends transaction

BEGIN; -- starts transaction

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species = '';

COMMIT; -- ends transaction(permanent change to table)

BEGIN; -- starts transaction

DELETE FROM animals;

ROLLBACK; -- ends transaction

SELECT * FROM animals; -- verification

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP1;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO SP1; -- does not end transaction

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT; -- ends transaction(permanent change to table)

SELECT count(id) FROM animals;

SELECT count(id) FROM animals WHERE escape_attempts > 0;

SELECT avg(weight_kg) FROM animals;

SELECT name FROM animals where escape_attempts = (SELECT max(escape_attempts) FROM animals WHERE neutered IS TRUE OR neutered IS FALSE);

SELECT species, min(weight_kg), max(weight_kg) FROM animals GROUP BY species;

SELECT species, avg(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-30' AND '2000-12-30' GROUP BY species;

-- query multiple tables -------------------------------------

SELECT name FROM animals
JOIN owners
ON owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals
JOIN species
ON species_id = species.id
WHERE species.id = 1;

SELECT animals.name, owners.full_name FROM animals
FULL JOIN owners
ON owner_id = owners.id;

SELECT species.name, COUNT(*) FROM animals
JOIN species
ON species_id = species.id
GROUP BY species.id;

SELECT animals.name FROM animals
JOIN owners
ON owner_id = owners.id
JOIN species
ON species_id = species.id
WHERE species.id = '2' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name FROM animals
JOIN owners
ON owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT * FROM animals;
SELECT owners.full_name FROM animals
JOIN owners
ON owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(owner_id) DESC
LIMIT 1;

-- add "join table" for visits -------------------------------------

SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visit_date DESC;

SELECT COUNT(animals.name) FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visit_date >= '2020-04-01' AND visit_date <= '2020-08-30';

SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY COUNT(visits.animal_id) DESC
LIMIT 1;

SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visit_date ASC
LIMIT 1;

SELECT animals.*, vets.*, visit_date FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visit_date DESC
LIMIT 1;

SELECT COUNT(*) FROM visits 
JOIN vets ON visits.vet_id = vets.id 
JOIN animals ON visits.animal_id = animals.id 
WHERE vets.id NOT IN (SELECT vets.id FROM vets 
JOIN specializations ON vets.id = specializations.vet_id 
WHERE specializations.species_id = animals.species_id);

SELECT species.name, COUNT(species.name) FROM vets
JOIN visits ON vets.id = visits.vet_id
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name;
