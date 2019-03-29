use master;

drop database SklepKomputerowy;
create database SklepKomputerowy;

use SklepKomputerowy;

create table Produkty(producent text not null, model nvarchar(50) primary key not null, typ text not null);
create table PC(model nvarchar(50) primary key not null, procesor int not null, ram int not null, hdd int not null, cd int not null, ekran int not null, cena money not null);
create table Laptop(model nvarchar(50) primary key not null, procesor int not null, ram int not null, hdd int not null, ekran int not null, cena money not null);
create table Drukarki(model nvarchar(50) primary key not null, kolor bit not null, typ text not null, cena money not null);

alter table PC add constraint FK_ProduktyPC foreign key (model) references Produkty(model);
alter table Laptop add constraint FK_ProduktyLaptop foreign key (model) references Produkty(model);
alter table Drukarki add constraint FK_ProduktyDrukarka foreign key (model) references Produkty(model);