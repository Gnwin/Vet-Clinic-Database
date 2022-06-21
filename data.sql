/* Populate database with sample data. */

-- create animals table----------------------------------------------

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
('Gabumon', '2018-11-15', 2, true, 8.00),
('Pikachu', '2021-01-07', 1, default, 15.04),
('Devimon', '2017-05-12', 5, true, 11.00);

-- query and update animals table -------------------------------------

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, default, -11.00),
('Plantmon', '2021-11-15', 2, true, -5.70),
('Squirtle', '1993-04-02', 3, default, -12.13),
('Angemon', '2005-07-12', 1, true, -45.00),
('Boarmon', '2005-06-07', 7, true, 20.40),
('Blossom', '1998-10-13', 3, true, 17.00),
('Ditto', '2022-05-14', 4, true, 22.00);

-- query multiple tables -------------------------------------

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES ('Pokemon'),
('Digimon');

BEGIN;

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon%';

UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

COMMIT;

BEGIN;

UPDATE animals SET owner_id = 1 WHERE name in ('Agumon');

UPDATE animals SET owner_id = 2 WHERE name in ('Gabumon', 'Pikachu');

UPDATE animals SET owner_id = 3 WHERE name in ('Devimon', 'Plantmon');

UPDATE animals SET owner_id = 4 WHERE name in ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals SET owner_id = 5 WHERE name in ('Angemon', 'Boarmon');

COMMIT;

-- add "join table" for visits -------------------------------------

INSERT INTO vets(name, age, date_of_graduation)
VALUES('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations(vet_id, species_id)
VALUES(1, 1),
(3, 1),
(3, 2),
(4, 2);

INSERT INTO visits(animal_id, vet_id, visit_date)
VALUES(1, 1, '2020-05-24'),
(1, 3, '2020-07-22'),
(2, 4, '2021-02-02'),
(5, 2, '2020-01-05'),
(5, 2, '2020-03-08'),
(5, 2, '2020-05-14'),
(3, 3, '2021-05-04'),
(9, 4, '2021-02-24'),
(7, 2, '2019-12-21'),
(7, 1, '2020-08-10'),
(7, 2, '2021-04-07'),
(10, 3, '2019-09-29'),
(8, 4, '2020-10-03'),
(8, 4, '2020-05-04'),
(4, 2, '2019-01-24'),
(4, 2, '2019-05-15'),
(4, 2, '2020-02-27'),
(4, 2, '2020-08-03'),
(6, 3, '2020-05-24'),
(6, 1, '2021-01-11');

-- database performance audit -------------------------------------

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';