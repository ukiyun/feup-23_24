a = float(input("a:"))
b = float(input("b:"))
c = float(input("c:"))

if(a<(b+c)):
    if(b<a+c):
        if(c<a+b):
            print("EXISTS")
        else:
            print("NOT EXISTS")
    else:
        print("NOT EXISTS")
else:
    print("NOT EXISTS")
    
