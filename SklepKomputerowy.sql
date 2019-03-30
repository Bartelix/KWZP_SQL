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

create table PCs(
	model nvarchar(50) primary key not null /*constraint FK_ProduktyPC references Produkty(model)*/, 
	procesor int not null, 
	ram int not null, 
	hdd int, 
	cd int, 
	ekran int, 
	cena money not null
	);

create table Laptopy(
	model nvarchar(50) primary key not null /*constraint FK_ProduktyLaptop references Produkty(model)*/, 
	procesor int not null, 
	ram int not null, 
	hdd int, 
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
alter table PCs add constraint FK_ProduktyPC foreign key (model) references Produkty(model);
alter table Laptopy add constraint FK_ProduktyLaptop foreign key (model) references Produkty(model);
alter table Drukarki add constraint FK_ProduktyDrukarka foreign key (model) references Produkty(model);

/*===Dodanie rekord�w do tabeli Produkty===*/
/*===5 laptop�w===*/
insert into Produkty(producent, model, typ) values('Huawey', 'Matebook 13 (Wright-W19A)', 'laptop');
insert into Produkty values('Lenovo', 'Legion Y530-15ICH (81FV00WCPB)', 'laptop');
insert into Produkty values('Dream Machines', 'RX2080-17PL18', 'laptop');
insert into Produkty values('Lenovo', 'V330-15IKB (81AX00H6US)', 'laptop');
insert into Produkty values('Lenovo', 'IdeaPad 320 (80XR0083/UK)', 'laptop');
/*===5 PCs===*/
insert into Produkty values('Komputronik', 'Sensilo CX-610 [N001]', 'pc');
insert into Produkty values('Komputronik', 'Infinity S510 [E001]', 'pc');
insert into Produkty values('Komputronik', 'Infinity S515 [F001]', 'pc');
insert into Produkty values('Komputronik', 'Pro 310 [C010]', 'pc');
insert into Produkty values('Komputronik', 'Pro 500 SFF [I003]', 'pc');
/*===5 drukarek===*/
insert into Produkty values('Canon', 'PIXMA MG2555S', 'drukarka');
insert into Produkty values('Brother', 'HL-1223WE', 'drukarka');
insert into Produkty values('OKI', 'B412dn', 'drukarka');
insert into Produkty values('EPSON', 'EcoTank ITS L3050', 'drukarka');
insert into Produkty values('EPSON', 'EcoTank L3070', 'drukarka');

/*===Dodanie rekord�w do tabeli Laptopy===*/
/*pierwsze 5 ze strony https://www.morele.net/laptopy/laptopy/notebooki-laptopy-ultrabooki-31/ */
insert into Laptopy(model, procesor, ram, hdd, ekran, cena) values('Matebook 13 (Wright-W19A)', 3000, 8192, null, 13, 3899);
insert into Laptopy values('Legion Y530-15ICH (81FV00WCPB)', 3500, 8192, 1024, 15, 3999);
insert into Laptopy values('RX2080-17PL18', 4000, 16384, 1024, 17, 12099);
insert into Laptopy values('V330-15IKB (81AX00H6US)', 2500, 8192, 500, 15, 2399);
insert into Laptopy values('IdeaPad 320 (80XR0083/UK)', 1700, 1024, 4096, 15, 1279);

/*===Dodanie rekord�w do tabeli PCs===*/
/*pierwsze 5 ze strony https://www.komputronik.pl/category/5801/komputery-pc.html */
insert into PCs(model, procesor, ram, hdd, cd, ekran, cena) values('Sensilo CX-610 [N001]', 2800, 8192, 240, null, null, 2449);
insert into PCs values('Infinity S510 [E001]', 2800, 8192, 240, null, null, 3799);
insert into PCs values('Infinity S515 [F001]', 3000, 8192, 240, null, null, 3799);
insert into PCs values('Pro 310 [C010]', 3600, 8192, 240, null, null, 2149);
insert into PCs values('Pro 500 SFF [I003]', 3000, 8192, 240, null, null, 2499);

/*===Dodanie rekord�w do tabeli Drukarki===*/
/*z tej strony https://www.komputronik.pl/informacje/dobra-drukarka-dla-ucznia-co-wybrac-top-5/ */
insert into Drukarki(model, kolor, typ, cena) values('PIXMA MG2555S', 1, 'atramentowa', 129.90);
insert into Drukarki values('HL-1223WE', 0, 'laserowa', 419);
insert into Drukarki values('B412dn', 0, 'laserowa', 529);
insert into Drukarki values('EcoTank ITS L3050', 1, 'atramentowa', 699);
insert into Drukarki values('EcoTank L3070', 1, 'atramentowa', 829);