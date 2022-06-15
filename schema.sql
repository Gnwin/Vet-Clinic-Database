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
