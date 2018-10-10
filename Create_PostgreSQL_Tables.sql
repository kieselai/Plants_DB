
CREATE TABLE common_name (
	id int8 NOT NULL GENERATED ALWAYS AS IDENTITY,
	common_name varchar NOT NULL,
	CONSTRAINT common_name_pk PRIMARY KEY (id)
);

CREATE TABLE genus (
	id int8 NOT NULL GENERATED ALWAYS AS IDENTITY,
	genus varchar NOT NULL,
	CONSTRAINT genus_pk PRIMARY KEY (id)
);

CREATE TABLE species (
	id int8 NOT NULL GENERATED ALWAYS AS IDENTITY,
	species varchar NOT NULL,
	genus_id int8 NOT NULL,
	CONSTRAINT species_pk PRIMARY KEY (id),
	CONSTRAINT species_genus_fk FOREIGN KEY (genus_id) REFERENCES genus(id) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE variety (
	id int8 NOT NULL GENERATED ALWAYS AS IDENTITY,
	variety varchar NOT NULL,
	species_id int8 NOT NULL,
	CONSTRAINT variety_pk PRIMARY KEY (id)
);

CREATE TABLE plant (
	id int8 NOT NULL GENERATED ALWAYS AS IDENTITY,
	most_common_name_id int8 NOT NULL,
	genus_id int8 NOT NULL,
	species_id int8 NULL,
	variety_id int8 NULL,
	CONSTRAINT plant_pk PRIMARY KEY (id),
	CONSTRAINT plant_common_name_fk FOREIGN KEY (most_common_name_id) REFERENCES common_name(id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT plant_genus_fk FOREIGN KEY (genus_id) REFERENCES genus(id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT plant_species_fk FOREIGN KEY (species_id) REFERENCES species(id) ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT plant_variety_fk FOREIGN KEY (variety_id) REFERENCES variety(id) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE VIEW plant_info
AS SELECT plant.id,
    plant.most_common_name_id,
    plant.genus_id,
    plant.species_id,
    plant.variety_id,
    common.id AS most_common_name,
    genus.genus,
    species.species,
    variety.variety
   FROM plant plant
     JOIN common_name common ON plant.most_common_name_id = common.id
     JOIN genus genus ON plant.genus_id = genus.id
     LEFT JOIN species species ON plant.species_id = species.id
     LEFT JOIN variety variety ON plant.variety_id = variety.id;
