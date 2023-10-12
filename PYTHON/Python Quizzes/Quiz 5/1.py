n = float(input("n:"))
i = 0
numerator = 0
denominator = 0
while i < n:
    x = float(input("X%d:" %i))
    p = float(input("P%d:" %i))
    denominator = denominator + p
    numTemp = x*p
    numerator = numerator + numTemp
    i +=1
    
average = numerator/denominator
print("Weighted average =", "{:.2f}".format(round(average,2)))