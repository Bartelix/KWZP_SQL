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

def generujInsert(firma, model):
    return f"insert into Zamowienia(nazwaFirmy, model, ilosc) values('{firma}', '{model}', {random.randint(1,50)});"


with open('insert_zamowienia.sql', 'w+',  encoding = 'utf-8') as f:
    for i in range(100):
        firma = losowaFirma()
        model = readModelNamesUsed()
        f.write(generujInsert(firma, model) + '\n')