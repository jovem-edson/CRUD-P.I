create schema banco;
use banco;
create table animal(
registro int not null primary key,
nome varchar(35) not null,
especie varchar(35) not null,
raca varchar(35) not null,
idade int null,
peso float not null,
data_registro date not null,
status_animal varchar(50)

);

select * from animal;