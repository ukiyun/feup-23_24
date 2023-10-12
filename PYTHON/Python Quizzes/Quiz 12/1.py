n = int(input(""))


matrix = []
listtemp = []
for x in range(n*n):
    temp = str(input(""))
    listtemp.append(temp)
    
    if((x+1)%n==0):
        matrix.append(listtemp)
        listtemp = []

matrixend=[]

for y in range(n):
    matemp = matrix[y]
    matemp.sort()
    matrixend.append(matemp)
    

for f in range(n):
    print(matrixend[f])