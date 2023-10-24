filename = str(input("Filename:"))
               
names = []

file1 = open(filename, "r")

for line in file1: 
    names.append(line)
    

file1.close()


namescount = len(names)
alpha = sorted(names)

for element in alpha:
    print (element)
    
print("Count of names:", namescount)