-- H3 - CONTACT DATABASE

-- design contact database


-- tables:

-- table countries

create table countries(
  id_country serial primary key,
  name varchar(50) not null  
);

-- table priorities

create table priorities(
  id_priority serial primary key,
  type_name varchar(50) not null  
);

-- table contact_request

create table contact_request (
	id_email varchar(60) primary key,
	id_country int unique references countries(id_country),
	id_priority int unique references priorities(id_priority),
	name varchar(50) not null,
	detail text,
	physical_address varchar(255)
);

---------------------------------------------------------------------

-- H4 - CRUD - CONTACT DATABASE

-- crud contact database

-- ✔insert:
-- insert 5 record in countries

INSERT INTO public.countries(
	name)
	VALUES ('Venezuela'), ('Argentina'), ('Estados Unidos'), ('Canadá'), ('Brasil');

-- insert 3 record in priorities

INSERT INTO public.priorities(type_name)
	VALUES ('High'), ('Medium'), ('Low');

-- insert 3 record in contact_request

INSERT INTO public.contact_request(
	id_email, id_country, id_priority, name, detail, physical_address)
	VALUES ('mariop@gmail.com', 1, 1, 'Mario Pérez', 'Director ejecutivo de MercadoLibre', 'Torre EXA, Avenida Libertador con Avenida Alameda, Urbanización El Rosal'),
			('kperkins@outlook.com', 3, 2, 'Katie Perkins', 'CEO de Amazon', 'Amazon Web Services, Inc. 410 Terry Ave. N., Seattle, WA 98109-5210'),
			('gribeiro46@gmail.com', 5, 3, 'Gabriel Ribeiro', 'Presidente de GrupoData', 'Al. Vicente Pinzon, 54 - Vila Olímpia São Paulo');

-- ✔delete;

-- delete last user:

DELETE FROM public.contact_request
	WHERE id_email='gribeiro46@gmail.com';

-- ✔update:

-- update first user:

UPDATE public.contact_request
	SET detail='Ingeniero Jefe de Ciudad Banesco', physical_address='Calle Lincoln, entre Av. Principal y Av. Leonardo Da Vinci, Edif. Ciudad Banesco, Bello Monte, Caracas'
	WHERE id_email='mariop@gmail.com';