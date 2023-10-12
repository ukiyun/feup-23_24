s1 = str(input(""))

l1 = s1.split(" ")
length = len(l1)
l1.reverse()
s2 = l1[0]
for i in range (1, length):
    s2 = s2 + " " + l1[i]

print(s2)

