filename1 = str(input("Filename 1:"))
filename2 = str(input("Filename 2:"))

with open(filename1, 'r') as f1, open(filename2, 'r') as f2:
    unique_names = set()
    for line in f1:
        name = line.strip()
        unique_names.add(name)
        
    for line in f2:
        name = line.strip()
        unique_names.add(name)
        

sorted_names = sorted(unique_names)
for name in sorted_names:
    print(name)