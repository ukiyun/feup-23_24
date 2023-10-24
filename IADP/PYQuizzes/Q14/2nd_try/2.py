import csv
from email import header
filename = str(input("Filename:"))
estado = str(input("'estado' column value:"))
estadocut = estado[:-1]
with open(filename, 'r') as f1:
     with open("output.csv", 'w') as f2:
         writer =csv.writer(f2)
         for row in csv.reader(f1):
             rowline = row[0][:-1]
             rowline = rowline.split(';')
             print(rowline)
             if rowline[0] == 'id':
                rowline = rowline.append('sexo')
                print(rowline)
                writer.writerow(row[0]+'sexo;')
             else:
                 rowline = row[0].split(';')
                 if (rowline[6][:-1] == estadocut):
                     if rowline[6][-1] == 'a':
                         row = row + 'F;'
                     else:
                         row = row + 'M;'