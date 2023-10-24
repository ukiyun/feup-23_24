import csv
filename = str(input("Filename:"))
id = str(input("Name id:"))

with open(filename,'r') as f1 :
    reader = csv.reader(f1)
    for row in reader:
        rowline = row[0].split(';')
        if rowline[0] == id:
            print(row[0])
            break;
        