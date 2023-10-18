import math

x = float(input("x:"))
y = float(input("y:"))

fbottom = 4 * x + y
fsquare = math.sqrt(2*x*(y+10))
ftop = 3*y + fsquare
f = ftop/fbottom
print("f(" + "{:.2f}".format(x) + "," + "{:.2f}".format(y) + ") = " + str(round(f,2)))