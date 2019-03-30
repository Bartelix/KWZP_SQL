use master; /*Prze��czenie na baz� o nazwie master*/

drop database SklepKomputerowy; /*Usuni�cie bazy danych SklepKomputerowy*/
create database SklepKomputerowy; /*Stworzenie bazy danych SklepKomputerowy*/
/*Taki zabieg powoduje, �e za ka�dym uruchomieniem skryptu baza jest usuwana i tracimy ca�� jej zawarto��,
nast�pnie na nowo tworzymy tak� sam� baz� danych i wszystkie polecenia w skrypcie wykonuj� si� na czystej (pustej bazie).
Dzi�ki temu nie wyskocz� komunikaty b��du, �e np. "taka tabela ju� istnieje w bazie.*/

/*Do tej linijki wszystkie komendy zostan� wykonane na rzecz bazy MASTER!!!*/
use SklepKomputerowy; /*Prze��czenie na �wie�o stworzon� baz� danych*/

/*===Tworzenie tabel===*/
create table Produkty(
	producent text not null, 
	model nvarchar(50) primary key not null, 
	typ nvarchar(50) not null check(typ in ('pc', 'laptop', 'drukarka'))
	/*constraint check pozwala na wpisanie do kolumny tylko warto�ci spe�niaj�cych warunek podany w nawiasach*/
	);

create table PC(
	model nvarchar(50) primary key not null /*constraint FK_ProduktyPC references Produkty(model)*/, 
	procesor int not null, ram int not null, 
	hdd int not null, cd int not null, 
	ekran int not null, 
	cena money not null
	);

create table Laptop(
	model nvarchar(50) primary key not null /*constraint FK_ProduktyLaptop references Produkty(model)*/, 
	procesor int not null, 
	ram int not null, 
	hdd int not null, 
	ekran int not null, 
	cena money not null
	);

create table Drukarki(
	model nvarchar(50) primary key not null /*constraint FK_ProduktyDrukarka references Produkty(model)*/, 
	kolor bit not null, 
	typ nvarchar(50) check(typ in ('laserowa', 'atramentowa', 'ig�owa')) not null, 
	cena money not null
	);

/*===Dodawanie kluczy obcych do tabel===*/
/*Te polecenia dodaj� klucze obce do tabel, s� one r�wnoznaczne z zakomentowanymi cz�ciami kodu w poleceniach powy�ej*/
alter table PC add constraint FK_ProduktyPC foreign key (model) references Produkty(model);
alter table Laptop add constraint FK_ProduktyLaptop foreign key (model) references Produkty(model);
alter table Drukarki add constraint FK_ProduktyDrukarka foreign key (model) references Produkty(model);