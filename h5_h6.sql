--H5 - ECOMMERCE DATABASE

-- design ecommerce database

-- tables:
-- table countries

create table countries(
  id_country serial primary key,
  name varchar(50) not null  
);

-- table roles

create table roles(
  id_role serial primary key,
  name varchar(40) not null  
);

-- table taxes

create table taxes(
  id_tax serial primary key,
  percentage numeric(5, 2)
);

-- table offers

create table offers(
	id_offer serial primary key,
	status text
);

-- table discounts

create table discounts(
	id_discount serial primary key,
	status text,
	percentage numeric(5, 2)
);

-- table payments

create table payments(
	id_payment serial primary key,
	type varchar(50)
);

-- table customers

create table customers (
    id_customer serial primary key,
    email varchar(80),
    id_country integer,
    id_role integer,
    foreign key (id_country) references countries (id_country) on delete cascade,
    foreign key (id_role) references roles (id_role) on delete cascade,	
    name varchar(50),
    age smallint,
    password varchar(50),
    physical_address text
);

-- table invoice_status

create table invoice_status (
	id_invoice_status serial primary key,
	status text
);

-- table products

create table products (
	id_product serial primary key,
    id_discount integer,
    id_offer integer,
	id_tax integer,
    foreign key (id_discount) references discounts (id_discount) on delete cascade,
    foreign key (id_offer) references offers (id_offer) on delete cascade,
    foreign key (id_tax) references taxes (id_tax) on delete cascade,		
	name varchar(100),
	details text,
	minimum_stock int,
	maximum_stock int,
	current_stock int,
	price numeric(10,2),
	price_with_tax numeric(10,2)
);

-- table products_customers

create table products_customers (
    id_product integer,
	id_customer integer,
    foreign key (id_product) references products (id_product) on delete cascade,
	foreign key (id_customer) references customers (id_customer) on delete cascade,
    PRIMARY KEY (id_product, id_customer)
);

-- table invoices

create table invoices (
	id_invoice serial primary key,
	id_customer integer,
    id_payment integer,
	id_invoice_status integer,
	foreign key (id_customer) references customers (id_customer) on delete cascade,
    foreign key (id_payment) references payments (id_payment) on delete cascade,
    foreign key (id_invoice_status) references invoice_status (id_invoice_status) on delete cascade,
	date date,
	total_to_pay numeric(10,2)
);

-- table orders

create table orders (
	id_order serial primary key,
	id_invoice integer,
	id_product integer,
	foreign key (id_invoice) references invoices (id_invoice) on delete cascade,  
	foreign key (id_product) references products (id_product) on delete cascade,
	detail text,
	amount int,
	price numeric(10,2)
);




-------------------------------------------

-- H6 - CRUD

/* crud ecommerce database

-- ✔insert:
-- insert 3 record in all tables
-- create 3 invoices

-- ✔delete:
-- delete last first user:

-- ✔update:
-- update last user:
-- update all taxes:
-- update all prices

-----------------
⚡ example script


✔ Many to Many: products table and customers table

create table products (
    id_product serial primary key,
    ...
);

create table customers (
    id_customer serial primary key,
    ...
);

create table products_customers (
    id_customer integer,
    id_product integer,
    foreign key (id_customer) references customers (id_customer),
    foreign key (id_product) references products (id_product),
    PRIMARY KEY (id_customer, id_product)
); */


-- ✔insert:

-- insert 3 record in all tables

INSERT INTO public.countries(
	name)
	VALUES ('Venezuela'), ('Canadá'), ('República Dominicana')
;

INSERT INTO public.roles(
	name)
	VALUES ('Registered User'), ('Buyer'), ('Loyalty Program Member')
;

INSERT INTO public.taxes(
	percentage)
	VALUES (2.5), (3), (3.5)
;

INSERT INTO public.offers(
	status)
	VALUES ('Current Offer'), ('Sold Out Offer'), ('New Offer Coming Soon');

INSERT INTO public.discounts(
	status, percentage)
	VALUES ('Active', 30), ('Active', 50), ('Inactive', 70);

INSERT INTO public.payments(
	type)
	VALUES ('Bank Transfer'), ('Debit Card'), ('Cash');

INSERT INTO public.customers(
	email, id_country, id_role, name, age, password, physical_address)
	VALUES ('fercontreras@gmail.com', 1, 1, 'Fernando Contreras', 36, 'FerCon5050', 'Centro Residencial Solano, Avenida Francisco Solano López, Sabana Grande, Caracas.'),
			('lcarter78@outlook.com', 2, 2, 'Lilian Carter', 26, 'Mu5H.r00Ms571*&@!', '3520 Bunbury Road, Mount Herbert, Prince Edward Island, Zip code:  C1B 3M8.'),
			('rioscarla89@gmail.com', 3, 3, 'Carla Ríos', 42, 'Gr@y&At0m', 'Avenida Rómulo Betancourt, No. 1604 Bella Vista, Santo Domingo.');

INSERT INTO public.invoice_status(
	status)
	VALUES ('Paid'), ('Pending'), ('Overdue');

INSERT INTO public.products(
	id_discount, id_offer, id_tax, name, details, minimum_stock, maximum_stock, current_stock, price, price_with_tax)
	VALUES (1, 1, 1, 'Aiwa TV', '50", 4k resolution, Smart TV, OS: Android TV, Wi-Fi, Bluetooth, Chromecast built-in.', 100, 500, 233, 330, 338.25),
			(2, 2, 2, 'LG Refrigerator', '27.12 Cu. Ft. Door-in-Door Side-by-Side Refrigerator with SpacePlus Ice System - Stainless Steel', 100, 300, 120, 700, 721.00),
			(3, 3, 3, 'Samsung Galaxy S23 Ultra', '5G Smartphone, Storage Capacity: 512 GB, RAM: 12GB, Color: Cream, Battery: 5000 mAH.', 50, 200, 98, 980, 1014.30);

INSERT INTO public.products_customers(
	id_product, id_customer)
	VALUES (1, 1),
			(2, 2),
			(3, 3);

-- create 3 invoices

INSERT INTO public.invoices(
	id_customer, id_payment, id_invoice_status, date, total_to_pay)
	VALUES (1, 1, 1, '08-07-2024', 236.78),
			(2, 2, 2, '08-08-2024', 360.50),
			(3, 3, 3, '08-09-2024', 1014.30);

INSERT INTO public.orders(
	id_invoice, id_product, detail, amount, price)
	VALUES (1, 1, 'TV Aiwa', 1, 236.78),
			(2, 2, 'LG Refrigerator', 1, 360.50),
			(3, 3, 'Samsung Galaxy S23 Ultra', 1, 1014.30);

-- ✔delete:

-- delete last first user:

DELETE FROM public.customers
	WHERE email='fercontreras@gmail.com';
/*Al eliminar este registro, también se elimina el primer registro de las tablas: "products_customers", "invoices", y "orders".
Esto se debe a que habilité la opción "on delete cascade" al crear la foreign key.
De no hacerlo asì, no podrìa eliminar el registro por haber una referencia de esta tabla que afecta directa o indirectamente las otras, en el campo "id_customer". */


-- ✔update:

-- update last user:

UPDATE public.customers
	SET name='Carla Ríos de García', age=43, password='C4RL4.Rios'
	WHERE id_customer=3;

-- update all taxes:

UPDATE public.taxes
	SET percentage=3.3;

-- update all prices

UPDATE public.orders
	SET price=800.00;

UPDATE public.products
	SET price=800.00;