/* Populate database with sample data. */

-- create animals table----------------------------------------------

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
('Gabumon', '2018-11-15', 2, true, 8.00),
('Pikachu', '2021-01-07', 1, default, 15.04),
('Devimon', '2017-05-12', 5, true, 11.00);

-- query and update animals table -------------------------------------
