## Knowing that a byte consists of 8 bits, a Kbyte of 1024 bytes and a Mbyte of 1024 Kbytes, create a program that, given a number of bits, compute the number of Mbytes, Kbytes, and corresponding bytes
## (Example: Nº bits: 67218888    A: 8 Mbytes, 13 Kbytes, 441 bytes)

nbits = int(input("nbits:"))
nmbytes = int(nbits/8388608)
nbits = nbits - (nmbytes*8388608)
nkbytes = int(nbits/8192)
nbits = nbits - (nkbytes * 8192)
nbytes = int(nbits/8)

print(str(nmbytes) + " Mbytes, "+str(nkbytes) + " Kbytes, "+str(nbytes) + " bytes")
