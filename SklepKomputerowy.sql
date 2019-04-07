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
	producent varchar(50) not null,
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
/*Zmiana producent�w na losowych bo jedno z zada� tego wymaga*/
insert into Produkty values('DELL', 'Sensilo CX-610 [N001]', 'pc');
insert into Produkty values('DELL', 'Infinity S510 [E001]', 'pc');
insert into Produkty values('HP', 'Infinity S515 [F001]', 'pc');
insert into Produkty values('Komputronik', 'Pro 310 [C010]', 'pc');
insert into Produkty values('Komputronik', 'Pro 500 SFF [I003]', 'pc');
/*===5 drukarek===*/
insert into Produkty values('Canon', 'PIXMA MG2555S', 'drukarka');
insert into Produkty values('Brother', 'HL-1223WE', 'drukarka');
insert into Produkty values('OKI', 'B412dn', 'drukarka');
insert into Produkty values('EPSON', 'EcoTank ITS L3050', 'drukarka');
insert into Produkty values('EPSON', 'EcoTank L3070', 'drukarka');
insert into Produkty values('EPSON', 'EcoTank 070', 'drukarka');

/*===Dodanie rekord�w do tabeli Laptopy===*/
/*pierwsze 5 ze strony https://www.morele.net/laptopy/laptopy/notebooki-laptopy-ultrabooki-31/ */
insert into Laptopy(model, procesor, ram, hdd, ekran, cena) values('Matebook 13 (Wright-W19A)', 3000, 8192, null, 13, 3899);
insert into Laptopy values('Legion Y530-15ICH (81FV00WCPB)', 3500, 8192, 1024, 15, 3999);
insert into Laptopy values('RX2080-17PL18', 4000, 16384, 1024, 17, 12099);
insert into Laptopy values('V330-15IKB (81AX00H6US)', 2500, 8192, 500, 15, 2399);
insert into Laptopy values('IdeaPad 320 (80XR0083/UK)', 1700, 4096, 1024, 15, 1279);

/*===Dodanie rekord�w do tabeli PCs===*/
/*pierwsze 5 ze strony https://www.komputronik.pl/category/5801/komputery-pc.html */
/*Dodanie pr�dko�ci nap�du i rozmiaru ekranu bo zadania tego wymagaj�*/
insert into PCs(model, procesor, ram, hdd, cd, ekran, cena) values('Sensilo CX-610 [N001]', 2800, 8192, 240, 4, 17, 2449);
insert into PCs values('Infinity S510 [E001]', 2800, 8192, 240, 8, 15, 1799);
insert into PCs values('Infinity S515 [F001]', 3000, 8192, 240, 8, 15, 3799);
insert into PCs values('Pro 310 [C010]', 3600, 8192, 240, 16, 17, 1149);
insert into PCs values('Pro 500 SFF [I003]', 3000, 8192, 240, 4, 17, 2699);

/*===Dodanie rekord�w do tabeli Drukarki===*/
/*z tej strony https://www.komputronik.pl/informacje/dobra-drukarka-dla-ucznia-co-wybrac-top-5/ */
insert into Drukarki(model, kolor, typ, cena) values('PIXMA MG2555S', 1, 'atramentowa', 129.90);
insert into Drukarki values('HL-1223WE', 0, 'laserowa', 419);
insert into Drukarki values('B412dn', 0, 'laserowa', 529);
insert into Drukarki values('EcoTank ITS L3050', 1, 'atramentowa', 699);
insert into Drukarki values('EcoTank L3070', 1, 'atramentowa', 829);
insert into Drukarki values('EcoTank 070', 1, 'atramentowa', 829);


/*Dodanie innych rekord�w za pomoc� innych skrypt�w*/
/*:r pe�na �cie�ka do skryptu*/
:r C:/Users/Bart�omiej/Desktop/KWZP_SQL/KWZP_SQL/script_inserts_KWZP_2019_4_7_20_55_0.sql
/*flag*/

/*
/*===Zadanie 1===*/
/*Podaj numer modelu, procesor oraz wielko�� dysku twardego ka�dego PC, kt�ry kosztuje poni�ej 2000z�*/
select 'Zadanie 1' as 'Numer zad', model, procesor, hdd
from PCs
where cena < 2000;

/*===Zadanie 2===*/
/*Podaj producent�w drukarek*/
select distinct 'Zadanie 2' [Numer zad], producent
from Produkty
where typ = 'Drukarka';

/*===Zadanie 3===*/
/*Podaj numer modelu, RAM i wielko�� ekranu dla wszystkich laptop�w z cen� powy�ej 2000z�*/
select 'Zadanie 3' [Numer zad], model, ram, ekran
from Laptopy
where cena > 2000;

/*===Zadanie 4===*/
/*Podaj wszystkie dane kolorowych drukarek*/
select 'Zadanie 4' [Numer zad], *
from Drukarki
where kolor = 1;

/*===Zadanie 5===*/
/*Podaj numer modelu, procesor i wielkos� dysku twardego wszystkich PC, kt�re maj� pr�dko�� cd 8x i cen� mniejsz� od 2500z� lub cd 16x i cen� wi�ksz� od 2500z�*/
select 'Zadanie 5' [Numer zad], model, procesor, hdd
from PCs
where (cd = 8 and cena < 2500) or (cd = 16 and cena > 2500);

/*===Zadanie 6===*/
/*Wska� producenta i pr�dko�� procesora laptop�w, kt�re maj� dyski twarde wi�ksze b�d� r�wne 500Gb===*/
select 'Zadanie 6' [Numer zad], Prod.producent, Lap.procesor
from Produkty as Prod
join Laptopy as Lap
on Prod.model = Lap.model
where Lap.hdd >= 500;

/*===Zadanie 7===*/
/*Podaj producent�w PC, kt�re maj� pr�dko�� procesor�w nie mniejsz� ni� 3500MHz*/
select 'Zadanie 7' [Numer zad], Prod.producent
from Produkty as Prod
join PCs
on Prod.model = PCs.model
where PCs.procesor >= 3500;


/*===Zadanie 8===*/
/*Podaj modele drukarek z najwy�sz� cen�. (tylko jedna warto�� ceny)*/
select 'Zadanie 8' [Numer zad], model
from Drukarki
where cena = (select max(cena) from Drukarki);

/*===Zadanie 9===*/
/*Podaj �redni� pr�dko�� procesor�w PC*/
select 'Zadanie 9' [Numer zad], avg(procesor) as [�rednia pr�dko�� procesora]
from PCs;

/*===Zadanie 10===*/
/*Podaj �redni� pr�dko�� procesor�w PC, kt�re kosztuj� powy�ej 3500z�*/
select 'Zadanie 10' [Numer zad], avg(procesor) as [�rednia pr�dko�� procesora]
from PCs
where cena > 3500;

/*===Zadanie 11===*/
/*Podaj �redni� pr�dko�� procesor�w PC wyprodukowanych przez firm� "DELL"*/
select 'Zadanie 11' [Numer zad], avg(PCs.procesor) as [�rednia pr�dko�� procesora]
from Produkty as Prod
join PCs
on Prod.model = PCs.model
where Prod.producent like('DELL');

/*===Zadanie 12===*/
/*Dla ka�dej z warto�ci pr�dko�ci procesora podaj �redni� cen� PC*/
select 'Zadanie 12' [Numer zad], round(avg(cena),2) as [�rednia cena PC]
from PCs
group by procesor;

/*===Zadanie 13===*/
/*Dla ka�dego z producent�w podaj �redni rozmiar ekranu w laptopie produkowanym przez niego*/
select 'Zadanie 13' [Numer zad], Prod.producent, avg(Lap.ekran) as [�rednia wielko�� ekranu]
from Produkty as Prod
join Laptopy as Lap
on Prod.model = Lap.model
group by Prod.producent
order by Prod.producent;
*/

/* nazwa firmy ktora kupila, ila ma zaplacic w sumie, data zamowienia, data realizacji inna,
 */

 create table Firma(
	nazwaFirmy nvarchar(50) primary key not null
	);

create table Zamowienia(
	idZamowienia int identity(1,1) not null primary key,
	nazwaFirmy nvarchar(50) constraint FK_FirmaZamowienia references Firma(nazwaFirmy) not null,
	model nvarchar(50) constraint FK_ProduktyZamowienia references Produkty(model) not null,
	ilosc int not null,
	dataZamowienia date not null,
	dataRealizacji date not null
	);

insert into Firma values ('KomPol');
insert into Firma values ('LapPol');
insert into Firma values ('DrukPol');
insert into Firma values ('JanPol');
insert into Firma values ('PolPol');
insert into Firma values ('PoleOle');
insert into Firma values ('StyropJan');

:r C:/Users/Bart�omiej/Desktop/KWZP_SQL/KWZP_SQL/insert_zamowienia.sql

select * from Zamowienia;

/*odp na pytania
1 firma ktora zlozyla najwiecej zamowien
2 firma ktora zlozyla zamowienie na najwieksza kwote
3 ile trwa sredni czas realizacji zamowienai
4 o ile dluzszy jest najdluzszy czas realizacji od sredniego czasu realizacji
5 jaki model pc laptopa drukarki jest najczesciej zamawiany w historii
6 jaki model pc laptopa druakrki jest zamawiany w danym miesiacu
*/

/*1 firma ktora zlozyla najwiecej zamowien*/
select top (1) nazwaFirmy, count(nazwaFirmy) as [Najwi�cej zam�wie�]
from Zamowienia
group by nazwaFirmy
order by [Najwi�cej zam�wie�] desc;

/*2 firma ktora zlozyla zamowienie na najwieksza kwote*/
select Zam.nazwaFirmy, Lap.cena as [cena detal.], (Zam.ilosc * Lap.cena) as [cena zam.], 'Laptop' as [Przedmiot zam�wienia]
from Zamowienia as Zam
join Laptopy as Lap
on Zam.model = Lap.model
union
select Zam.nazwaFirmy, PCs.cena as [cena detal.], (Zam.ilosc * PCs.cena) as [cena zam.], 'Pc' as [Przedmiot zam�wienia]
from Zamowienia as Zam
join PCs
on Zam.model = PCs.model
union
select Zam.nazwaFirmy, Druk.cena as [cena detal.], (Zam.ilosc * Druk.cena) as [cena zam.], 'Drukarka' as [Przedmiot zam�wienia]
from Zamowienia as Zam
join Drukarki as Druk
on Zam.model = Druk.model
order by [Przedmiot zam�wienia], [cena zam.] desc;

/*3 ile trwa sredni czas realizacji zamowienia*/
select avg(datediff(day, dataZamowienia, dataRealizacji)) as [�redni czas realizacji zam�wienia]
from Zamowienia;

/*4 o ile dluzszy jest najdluzszy czas realizacji od sredniego czasu realizacji*/
select max(datediff(day, dataZamowienia, dataRealizacji)) - avg(datediff(day, dataZamowienia, dataRealizacji)) as [R�nica mi�dzy najd�u�szym i �rednim czasem realizacji]
from Zamowienia

/*5 jaki model pc laptopa drukarki jest najczesciej zamawiany w historii*/
select count(*) as [Ilo�� zam�wie�], Zam.model, Prod.typ as [Przedmiot zam�wienia]
from Zamowienia as Zam
join Produkty as Prod
on Zam.model = Prod.model
group by Prod.typ, Zam.model
order by [Ilo�� zam�wie�] desc;

/*6 jaki model pc laptopa druakrki jest zamawiany w danym miesiacu*/
select Zam.model, Prod.typ
from Zamowienia as Zam
join Produkty as Prod
on Zam.model = Prod.model
where datepart(month, Zam.dataZamowienia) = 10
order by Prod.typ;
