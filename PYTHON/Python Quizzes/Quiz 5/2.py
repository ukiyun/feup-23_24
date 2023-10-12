n = int(input("n:"))
value1 = int(input("value 1:"))
position = 1
maximum = value1
i = 0
while i<n-1:
    k = i+2
    value = int(input("value %d:" % k))
    if(value>maximum):
        maximum = value
        position = k
    i+=1
    
print ("Maximum =", maximum, "position =", position)