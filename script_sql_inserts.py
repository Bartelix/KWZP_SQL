import random, time, fileinput

class SQLInsertsKWZP():
    __numberOfLaptops = 0
    __numberOfPCs = 0
    __numberOfPrinters = 0

    __laptopAndPCManufactures = ['Lenovo', 'Asus', 'DELL', 'HP', 'Acer', 'Apple', 'MSI', 'Razer', 'Samsung', 'Toshiba']
    __printerManufactures = ['HP', 'PrinterJet', 'Brother', 'Canon', '3Dconnexion', 'Canson', 'Dahle', 'Epson']

    __productsToInsert = []
    __laptopsToInsert = []
    __PCsToInsert = []
    __printersToInsert = []

    __modelNamesUsed = []

    def __init__(self, laptops, PCs, printers):
        self.__numberOfLaptops = laptops
        self.__numberOfPCs = PCs
        self.__numberOfPrinters = printers
        with open('model_names_used.txt', 'a+') as f:
            if f.read() != '':
                f.write('\n')
        self.generateSQLScriptFile(self.__numberOfLaptops, self.__numberOfPCs, self.__numberOfPrinters)
    
    def generateSQLScriptFile(self, laptops, PCs, printers):
        pos = 0
        while(laptops > 0):
            self.generateLaptopRecord()
            self.generateProductRecord(pos, 'laptop')
            pos += 1
            laptops -= 1
        pos = 0
        while(PCs > 0):
            self.generatePCRecord()
            self.generateProductRecord(pos, 'pc')
            pos += 1
            PCs -= 1
        pos = 0
        while(printers > 0):
            self.generatePrinterRecord()
            self.generateProductRecord(pos, 'drukarka')
            pos += 1
            printers -= 1
        file_name = f'script_inserts_KWZP_{self.generateTimeToFileName()}.sql'
        with open(file_name, 'a+', encoding = 'utf-8') as f:
            flag = 0
            while(flag < len(self.__productsToInsert)):
                f.write(f"insert into Produkty values('{self.__productsToInsert[flag][0]}', '{self.__productsToInsert[flag][1]}', '{self.__productsToInsert[flag][2]}');")
                f.write('\n')
                flag += 1
            flag = 0
            while(flag < len(self.__laptopsToInsert)):
                f.write(f"insert into Laptopy values('{self.__laptopsToInsert[flag][0]}', {self.__laptopsToInsert[flag][1]},{self.__laptopsToInsert[flag][2]}, {self.__laptopsToInsert[flag][3]}, {self.__laptopsToInsert[flag][4]}, {self.__laptopsToInsert[flag][5]});")
                f.write('\n')
                flag += 1
            flag = 0
            while(flag < len(self.__PCsToInsert)):
                f.write(f"insert into PCs values('{self.__PCsToInsert[flag][0]}', {self.__PCsToInsert[flag][1]},{self.__PCsToInsert[flag][2]}, {self.__PCsToInsert[flag][3]}, {self.__PCsToInsert[flag][4]}, {self.__PCsToInsert[flag][5]}, {self.__PCsToInsert[flag][6]});")
                f.write('\n')
                flag += 1
            flag = 0
            while(flag < len(self.__printersToInsert)):
                f.write(f"insert into Drukarki values('{self.__printersToInsert[flag][0]}', {self.__printersToInsert[flag][1]}, '{self.__printersToInsert[flag][2]}', {self.__printersToInsert[flag][3]});")
                if flag + 1 != len(self.__printersToInsert):
                    f.write('\n')
                flag += 1
        for line in fileinput.FileInput('SklepKomputerowy.sql', inplace=1):
            if'/*flag*/' in line:
                line = line.rstrip()
                line = line.replace(line, ':r C:/Users/Bartłomiej/Desktop/KWZP_SQL/KWZP_SQL/' + file_name + '\n/*flag*/')
            print(line.rstrip())
    
    def generateProductRecord(self, pos, type):
        if type is 'laptop':
            self.__productsToInsert.append([random.choice(self.__laptopAndPCManufactures), self.__laptopsToInsert[pos][0], type])
        elif type is 'pc':
            self.__productsToInsert.append([random.choice(self.__laptopAndPCManufactures), self.__PCsToInsert[pos][0], type])
        else:
            self.__productsToInsert.append([random.choice(self.__printerManufactures), self.__printersToInsert[pos][0], type])

    def generateLaptopRecord(self):
        model = self.generateModel()
        prop = self.generateLaptopsAndPCsProperties()
        self.__laptopsToInsert.append([model, prop[0], prop[1], prop[2], prop[3], prop[4]])

    def generatePCRecord(self):
        model = self.generateModel()
        prop = self.generateLaptopsAndPCsProperties()
        self.__PCsToInsert.append([model, prop[0], prop[1], prop[2], random.choice([2, 4, 8, 16]), prop[3], prop[4]])
    
    def generatePrinterRecord(self):
        model = self.generateModel()
        self.__printersToInsert.append([model, random.randint(0, 1), random.choice(['atramentowa', 'laserowa', 'igłowa']), random.randint(100, 1000)])
    
    def generateLaptopsAndPCsProperties(self):
        properties = []
        properties.append(random.randrange(1200, 3500, 100)) #processor
        properties.append(random.randrange(4, 32, 4) * 1024) #RAM
        properties.append(random.choice([256, 512, 1024, 2048])) #HDD
        properties.append(random.choice([15, 17])) #monitor
        properties.append(random.randint(1000, 10000)) #price
        return properties

    def randomManufacturer(self, type):
        if type is 'laptop' or type is 'pc':
            rnd = random.randint(0, len(self.__laptopAndPCManufactures))
            return self.__laptopAndPCManufactures[rnd]
        else:
            rnd = random.randint(0, len(self.__printerManufactures))
            return self.__printerManufactures[rnd]

    def readModelNamesUsed(self):
        with open('model_names_used.txt', 'r') as f:
            self.__modelNamesUsed = f.readlines()
            map(lambda str: str.strip('\n'), self.__modelNamesUsed)
    
    def generateModel(self):
        str = "01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ-"
        length = random.randint(15, 20)
        model = "".join(random.sample(str, length))
        if self.checkModelNameUniqueness(model):
            with open('model_names_used.txt', 'a+') as f:
                f.write(f'{model}\n')
                self.__modelNamesUsed.append(model)
            return model
        else:
            self.generateModel()
    
    def checkModelNameUniqueness(self, strModel):
        for str in self.__modelNamesUsed:
            if strModel is str:
                return False
        return True
    
    def generateTimeToFileName(self):
        t = time.localtime(time.time())
        return f'{t[0]}_{t[1]}_{t[2]}_{t[3]}_{t[4]}_{t[5]}'

obj = SQLInsertsKWZP(100, 100, 100)