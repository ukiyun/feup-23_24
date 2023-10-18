import os

file1Name = str(input("Filename 1:"))
file2Name = str(input("Filename 2:"))

file1.open(file1Name, "r")
file2 = open(file2Name, "r")
count1 = 0
count2 = 0

for line in file1.readlines():
    count1 +=1
    
for line in file2.readlines():
    count2 +=1
    
if(count2>count1):
    while lin1
elif(count1>count2):
    file1numbers = [0]*count1
    file2numbers = [0]*count1
else:
    file1numbers = [0]*count1
    file2numbers = [0]*count2
lines1=[]
lines2=[]
    
with open(file1) as f:
    for line in f:
        lines1.append(line)

with open(file2) as f:
    for line in f:
        lines2.append(line)

file1.close()
file2.close()
