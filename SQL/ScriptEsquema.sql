-- la tabla product la modifique de tal forma que el campo de stock fuera un entero, 
-- el campo available_for_selling un booleano y el id lo puse como llave primaria y autoicrementable
-- para al momento de hacer el insert no fuera necesario ponerlo.
create table product (
	id SERIAL,
	product VARCHAR(50),
	stock INT,
	available_for_selling BOOLEAN,
	CONSTRAINT pk_product PRIMARY KEY (id)
); 

-- la tabla user la modifique. El nombre lo tuve que cambiar ya que el nombre 'user' es un nombre reservado
-- y el campo del id lo puse como llave primaria y autoicrementable
-- para al momento de hacer el insert no fuera necesario ponerlo.
create table users (
	id SERIAL,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	address VARCHAR(50),
	CONSTRAINT pk_users PRIMARY KEY (id)
);

-- la tabla sales la cree para ahi guardar la cantidad de producto de una venta, el id del producto
-- y el id del usuario y que a su vez tengan una relación. El campo del id lo puse como llave primaria y autoicrementable
-- para al momento de hacer el insert no fuera necesario ponerlo. Ademas de poner como llaves foranes los campos
-- de id_product y id_users. 
create table sales(
	id SERIAL, 
	amount INT,
	id_product INT,
	id_users INT, 
	CONSTRAINT pk_sales PRIMARY KEY (id),
	CONSTRAINT fk_sales_id_product FOREIGN KEY (id_product) REFERENCES product (id),
    CONSTRAINT fk_sales_id_users FOREIGN KEY (id_users) REFERENCES users (id)
);

-- Agregué solo algunos insert a la tabla de product y a la tabla de users de los que nos habian dado de ejemplo 
-- para ir realizando los pasos y las prubeas correspondientes. De igual manera modifique la estructura de los insert 
-- deacuerdo a la estructura nueva de cada tabla.

insert into product (product, stock, available_for_selling) values ('Scallops - In Shell', 4716, false);
insert into product (product, stock, available_for_selling) values ('Beef Wellington', 20681, false);
insert into product (product, stock, available_for_selling) values ('Syrup - Golden, Lyles', 76800, false);
insert into product (product, stock, available_for_selling) values ('Juice - V8, Tomato', 55, false);
insert into product (product, stock, available_for_selling) values ('Muffin Mix - Morning Glory', 2009, true);
insert into product (product, stock, available_for_selling) values ('Brownies - Two Bite, Chocolate', 2, false);

insert into users (first_name, last_name, email, address) values ('Juan', 'Jewsbury', 'jjewsbury0@ucla.edu', '61390 Northwestern Avenue');
insert into users (first_name, last_name, email, address) values ('Nichol', 'Piers', 'npiers1@adobe.com', '149 Jana Parkway');
insert into users (first_name, last_name, email, address) values ('Maryjo', 'Braunfeld', 'mbraunfeld2@ca.gov', '00651 Walton Center');
insert into users (first_name, last_name, email, address) values ('Gussi', 'Abbatt', 'gabbatt3@wordpress.com', '6492 Sunbrook Park');
insert into users (first_name, last_name, email, address) values ('Julian', 'Corps', 'jcorps4@wisc.edu', '3649 Buena Vista Street');
insert into users (first_name, last_name, email, address) values ('Linet', 'Garken', 'lgarken5@comsenz.com', '36589 Westridge Street');
