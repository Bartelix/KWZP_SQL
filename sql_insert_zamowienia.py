import random




def readModelNamesUsed():
    with open('model_names_used.txt', 'r') as f:
        tablica = f.readlines()
        tab = list(map(lambda str: str.strip('\n'), tablica))
        print(tab)
        return random.choice(tab)

def losowaFirma():
    listafirm = ['KomPol', 'LapPol', 'DrukPol', 'JanPol', 'PolPol', 'PoleOle', 'StyropJan']
    firma = random.choice(listafirm)
    return firma

def generujInsert(firma, model, daty):
    return "insert into Zamowienia(nazwaFirmy, model, ilosc, dataZamowienia, dataRealizacji) values('{}', '{}', {}, '{:02d}-{:02d}-{:02d}', '{:02d}-{:02d}-{:02d}');".format(firma, model, random.randint(1, 50), daty[0][0], daty[0][1], daty[0][2], daty[1][0], daty[1][1], daty[1][2])

def dwieLosoweDaty():
    daty = []
    #rok-miesiac-dzien
    rok = 2019
    miesiac1 = random.randint(1,10)
    miesiac2 = miesiac1 + random.randint(1, 12 - miesiac1)
    dzien1 = 0
    if miesiac1 == 2:
        dzien1 = random.randint(1,28) 
    elif miesiac1 in (1, 3, 5, 7, 8, 10, 12):
        dzien1 = random.randint(1,31) 
    else:
        dzien1 = random.randint(1, 30)
    dzien2 = 0
    if miesiac2 == 2:
        dzien2 = random.randint(1,28) 
    elif miesiac2 in (1, 3, 5, 7, 8, 10, 12):
        dzien2 = random.randint(1,31) 
    else:
        dzien2 = random.randint(1, 30)
    data1 = [rok, miesiac1, dzien1]
    data2 = [rok, miesiac2, dzien2]
    daty.append(data1)
    daty.append(data2)
    return daty


with open('insert_zamowienia.sql', 'w+',  encoding = 'utf-8') as f:
    for i in range(100):
        firma = losowaFirma()
        model = readModelNamesUsed()
        daty = dwieLosoweDaty()
        f.write(generujInsert(firma, model, daty) + '\n')