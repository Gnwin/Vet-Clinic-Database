/* Database schema to keep the structure of entire database. */

createdb vet_clinic

psql vet_clinic

CREATE TABLE animals (
id serial,
name varchar(25) NOT NULL,
date_of_birth date,
escape_attempts integer,
neutered boolean DEFAULT FALSE,
weight_kg decimal(4,2)
);
