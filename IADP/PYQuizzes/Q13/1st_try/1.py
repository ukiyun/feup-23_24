import math

def senx(n, x):
    taylor = [None]*(n)
    alpha = (x * 180)/ math.pi
    print(alpha)
    for k in range(1, n+1):
        tempI = math.pow(-1,k+1)
        tempN = math.pow(alpha, (2 * k) - 1)
        tempD = math.factorial((2*k)-1)
        temp = tempI*tempN
        temp2 = temp/tempD
        taylor[k-1] = temp2
    
    sums  = 0
    print (taylor)
    for elements in taylor:
        sums = sums + elements
            
    return (sums)

print(senx(2, 5))
        
        