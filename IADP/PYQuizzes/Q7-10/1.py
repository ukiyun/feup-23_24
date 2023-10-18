n1 = int(input("Number of elements in first list = "))
list1 = []
for i in range(0, n1):
    l1 = int(input("l1[%d]=" % i))
    list1.append(l1)
    
notinlist2 = []
list2 = []
n2 = int(input("Number of elements in second list = "))
for i in range(0, n2):
    l2 = int(input("l2[%d]=" % i))
    list2.append(l2)
        
        
isvaluein = False
for x in range(0, n1):
    for y in  range(0,n2):
        if (list1[x]==list2[y]):
            isvaluein = True
    if isvaluein== False:
        notinlist2.append(list1[x])
        
        
        
print(notinlist2)
        

    
    
