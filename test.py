import random

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

for i in range(20):
    daty = dwieLosoweDaty()
    j=1
    for i in daty:
        print(f"{j}, {i}")
        j += 1