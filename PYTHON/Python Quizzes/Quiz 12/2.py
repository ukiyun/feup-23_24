n = int(input(""))
temp2 = int(input(""))
maxdiff = 0
for x in range((n*n)-1):
    temp1 = int(input(""))
    if (temp2>temp1):
        diff = temp2-temp1
    else:
        diff = temp1-temp2
    
    if(diff>maxdiff):
        maxdiff = diff

    temp2 = temp1

print(maxdiff)
