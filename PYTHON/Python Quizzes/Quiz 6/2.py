n = int(input("n:"))
maxim = 0
maxim2 = 0
for i in range(1,n+1):
    value=int(input("value %d:" % i))
    if i==1:
        maxim = value
    elif i==2:
        if value>maxim:
            maxim2 = maxim
            maxim = value
        else:
            maxim2= value
    else:
        if(value>maxim):
            maxim2 = maxim
            maxim = value
        elif(value<maxim and value>maxim2):
            maxim = maxim
            maxim2 = value
        else:
            maxim = maxim
            maxim2 = maxim2

print("Highest value =", maxim, "2nd. Highest value =", maxim2)
        
        
