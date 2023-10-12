n = int(input("n:"))
values = []
for x in range(n):
   val = float(input("value(%d):"%x))
   values.append(val)

values.sort()

values_end = values[1:n-1]
sums = 0
divider = 0
for x in values_end:
    sums = sums + x
    divider = divider + 1

average = sums/divider

print("Average = %s" % "{:.2f}".format(average))
    

    