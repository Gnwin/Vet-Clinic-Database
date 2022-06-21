/* Database schema to keep the structure of entire database. */

-- create animals table----------------------------------------------

createdb vet_clinic -- client applications(run directly from command prompt without psql console)

psql postgres

\c vet_clinic

CREATE TABLE animals (
id serial,
name varchar(25) NOT NULL,
date_of_birth date,
escape_attempts integer,
neutered boolean DEFAULT FALSE,
weight_kg decimal(4,2)
);

-- query and update animals table -------------------------------------

ALTER TABLE animals ADD COLUMN species varchar(50);

-- query multiple tables -------------------------------------

CREATE TABLE owners (
id serial PRIMARY KEY,
full_name varchar(25) NOT NULL,
age integer
);

CREATE TABLE species (
id serial,
name varchar(25) NOT NULL,
PRIMARY KEY(id)
);

ALTER TABLE animals ADD PRIMARY KEY(id);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id); -- used --
-- or ----
ALTER TABLE animals ADD COLUMN species_id INT NOT NULL; --step1 --
ALTER TABLE animals ADD FOREIGN KEY(species_id) REFERENCES species(id); -- step2 without constraint name
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id); -- step2 with constraint name
-- or ----
ALTER TABLE animals
ADD species_id INT,
ADD CONSTRAINT fk_species -- optional---
FOREIGN KEY(species_id) REFERENCES species(id);

ALTER TABLE animals
ADD owner_id INT,
ADD CONSTRAINT fk_owner -- optional---
FOREIGN KEY(owner_id) REFERENCES owners(id);

-- add "join table" for visits -------------------------------------

CREATE TABLE vets(
id SERIAL PRIMARY KEY,
name varchar(50),
age int,
date_of_graduation date
);

CREATE TABLE specializations (
  id SERIAL PRIMARY KEY,
  vet_id integer REFERENCES vets(id),
  species_id integer REFERENCES species(id)
);

CREATE TABLE visits (
  id SERIAL PRIMARY KEY,
  animal_id integer REFERENCES animals(id),
  vet_id integer REFERENCES vets(id),
  visit_date date
);

-- database performance audit -------------------------------------

ALTER TABLE owners ADD COLUMN email VARCHAR(120);