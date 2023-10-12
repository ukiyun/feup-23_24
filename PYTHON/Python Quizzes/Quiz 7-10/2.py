n = int(input())
list1 = []
for i in range(n):
    l1 = int(input())
    list1.append(l1)

distinct = []
distinct.append(list1[0])

for x in list1:
    temp = list1[x]
    isin = False
    for y in distinct:
        if x==y:
            isin = True
    if isin == False:
        distinct.append(x)

count = len(distinct)

print("number of distinct values:", count)