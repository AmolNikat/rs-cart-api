create type statuses as enum ('OPEN', 'ORDERED');

create table users (
	id uuid not null default gen_random_uuid() primary key,
	name text,
	email text,
	password text
);

create table carts (
	id uuid not null default gen_random_uuid() primary key,
	user_id uuid references users(id),
	created_at date not null,
	updated_at date not null,
	status STATUSES
);

create table cart_items (
    cart_id uuid references carts(id),
	product_id uuid not null,
	count integer
);

create table orders (
    id uuid not null default gen_random_uuid() primary key,
    user_id uuid references users(id),
	cart_id uuid references carts(id),
	payment JSON,
	delivery JSON,
	comments text,
	status text,
	total integer
);

insert into users (id, name, email, password) values ('77276a4b-b692-4fa5-ac21-053a8c0e4e31', 'Matt', 'matt@companyname.com', '123');
insert into users (id, name, email, password) values ('ae72bdb2-7646-41c6-852c-22c57776918e', 'Chris', 'chris@companyname.com', '321');
insert into users (id, name, email, password) values ('54b120ae-24f9-41d8-ac43-0eedcf6dde73', 'Nick', 'nick@companyname.com', '111');

insert into carts (id, user_id, created_at, updated_at, status) values ('7d1d78bf-0b81-46f9-ad52-45cfa475ece6', '77276a4b-b692-4fa5-ac21-053a8c0e4e31', '2023-03-11', '2023-03-11', 'OPEN');
insert into carts (id, user_id, created_at, updated_at, status) values ('4938ffac-3507-4c7c-967a-097e7b68c9f4', '54b120ae-24f9-41d8-ac43-0eedcf6dde73', '2023-03-09', '2023-03-10', 'ORDERED');
insert into carts (id, user_id, created_at, updated_at, status) values ('6d798eb7-d3ab-4b4f-a2d9-9f7378136cdd', 'ae72bdb2-7646-41c6-852c-22c57776918e', '2023-03-12', '2023-03-12', 'OPEN');

insert into cart_items (cart_id, product_id, count) values ('7d1d78bf-0b81-46f9-ad52-45cfa475ece6', '7567ec4b-b10c-48c5-9345-fc73c48a80aa', 1);
insert into cart_items (cart_id, product_id, count) values ('7d1d78bf-0b81-46f9-ad52-45cfa475ece6', '66d981f3-a5cb-44fa-bd60-e1979f21edd2', 2);
insert into cart_items (cart_id, product_id, count) values ('4938ffac-3507-4c7c-967a-097e7b68c9f4', '49b4dc48-f324-4bbc-bd09-648a03346906', 1);
insert into cart_items (cart_id, product_id, count) values ('6d798eb7-d3ab-4b4f-a2d9-9f7378136cdd', 'a4bc29da-32e1-45f9-a96b-0729f960e9ea', 1);

insert into orders (id, user_id, cart_id, payment, delivery, comments, status, total) values ('1c1f133a-4ae8-42cb-ab26-090929531a54', '77276a4b-b692-4fa5-ac21-053a8c0e4e31', '7d1d78bf-0b81-46f9-ad52-45cfa475ece6', '{"type": "cash"}', '{"type": "post", "address": "Kraków"}', '', 'PREPARATION', 10);
insert into orders (id, user_id, cart_id, payment, delivery, comments, status, total) values ('ca8c6c10-41df-49f7-88e7-4493bf7ec6cb', '54b120ae-24f9-41d8-ac43-0eedcf6dde73', '4938ffac-3507-4c7c-967a-097e7b68c9f4', '{"type": "cash"}', '{"type": "post", "address": "Warszawa"}', '', 'DELIVERY', 5);
insert into orders (id, user_id, cart_id, payment, delivery, comments, status, total) values ('218a04e0-3d0f-4822-8b57-2435fda3cd47', 'ae72bdb2-7646-41c6-852c-22c57776918e', '6d798eb7-d3ab-4b4f-a2d9-9f7378136cdd', '{"type": "cash"}', '{"type": "post", "address": "Wrocław"}', '', 'PREPARATION', 7);