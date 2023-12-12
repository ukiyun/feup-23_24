# CTF - Week 10

## Weak Encryption

> We were given *cipherspec.py*, a file that contains the algorithm of key gens, encrypting and decrypting.

```python
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
import os

KEYLEN = 16

def gen(): 
	offset = 3 # Hotfix to make Crypto blazing fast!!
	key = bytearray(b'\x00'*(KEYLEN-offset)) 
	key.extend(os.urandom(offset))
	return bytes(key)

def enc(k, m, nonce):
	cipher = Cipher(algorithms.AES(k), modes.CTR(nonce))
	encryptor = cipher.encryptor()
	cph = b""
	cph += encryptor.update(m)
	cph += encryptor.finalize()
	return cph

def dec(k, c, nonce):
	cipher = Cipher(algorithms.AES(k), modes.CTR(nonce))
	decryptor = cipher.decryptor()
	msg = b""
	msg += decryptor.update(c)
	msg += decryptor.finalize()
	return msg
```

*Note*: for this python file to work we need to have installed the python cryptography module

- Analysing the code, we can discern the functions:

* **gen()** - Function used to generate the cipher key

* **enc()** - Function that when given a key, a message and a nonce, encrypts the message using the *AES* cipher

* **dec()** - Function that when given a key, a ciphertext and a nonce, decrypts the ciphertext following the *AES* cipher


While analyzing the code, we found a vulnerability in the `gen()` function

```python
def gen(): 
	offset = 3 # Hotfix to make Crypto blazing fast!!
	key = bytearray(b'\x00'*(KEYLEN-offset)) 
	key.extend(os.urandom(offset))
	return bytes(key)
```

- The main issue resides in how the function randomizes the bytes. That is because we get an `offset` rather small (*3*).
- The key is first generated using the byte array function to create an array of bytes with the value 0.
- Then the **problem** is in the key extension function (`key.extend()`), according to the line on the code provide, it only randomizes 3 bytes which is a very low number and makes the cipher vulnerable to exploits (such as **_brute-force_** attacks).

To exploit this vulnerability we needed to create a bite array filled with 0s (our key) and then attempt to decrypt the message using the same bite array. We would do this until the decrypted message was the **flag** needed, always incrementing the last three bytes and trying again.

### Challenge Parameters

In the CTF guide we were provided with a server that contains our challenge, so we firstly connect to said server by doing:

```bash 
$ nc ctf-fsi.fe.up.pt 6003
```

This command gives us the following output:

```console
nonce: 5ecb4e5d0ec740b849b68c3b14399265
ciphertext: e92447bfe1a0e7f8267f407250cd6b4bb3b3841f3b6ec55dd0318bd294f56ef7f9928f4e6a7320
```

- Letting us know the `nonce` and the `ciphertext` for the challenge

### Script

- The next step was to make a script that would exploit the vulnerability seen in the cipherspec.py, for that we created a file named *exploit.py*

* First we need to lay out all the information we have into variables like so:

```python
ciphertext = e92447bfe1a0e7f8267f407250cd6b4bb3b3841f3b6ec55dd0318bd294f56ef7f9928f4e6a7320
nonce = 5ecb4e5d0ec740b849b68c3b14399265

offset = 3
```

* Now we iterate through all the possible keys. We know that only the last three bytes will differ from 0, so the total combinations possible would be the numbers in the range of 0 (*0x000*) to 4095 (*0xFFF*), meaning the total amount of possible numbers would be 4096² decimal numbers, which in turn is equal to *16777216*. But for easier understanding we will use *2²⁴*

- To represent *2 to the power of 24* in python we use `2 ** 24`

* The iteration should look something like this:

```python
for index in range(2**24):
    key = bytearray(b'\x00' * (KEYLEN - offset))    # recreating the byte array generator from cipherspec.py
    key.extend(index.to_bytes(3, "little"))     # returns integer value of bytes in little endian machine
```

* Now we need to decrypt the ciphertext with the key we obtained. And convert it to a string, using the `unhexlify()` function to convert as suggested by the guide.

```python
flag = str(dec(key, unhexlify(ciphertext), unhexlify(nonce)))
```

* All that's left to do is to compare the decrypted message to see if it is indeed a flag.

```python
if (re.search("flag{[A-Za-z0-9]+}", flag)):
    print(flag)
    break
```

- This Means that one the flag is found, the script will print it and exit the code.

#### Full *exploit.py* code

```python
import re #regex

from binascii import unhexlify
from cipherspec import *

ciphertext = "e92447bfe1a0e7f8267f407250cd6b4bb3b3841f3b6ec55dd0318bd294f56ef7f9928f4e6a7320"
nonce = "5ecb4e5d0ec740b849b68c3b14399265"

offset = 3

for index in range(2**24):
    key = bytearray(b'\x00' * (KEYLEN - offset))    # recreating the byte array generator from cipherspec.py
    key.extend(index.to_bytes(3, "little"))     # returns integer value of bytes in little endian machine
    
    flag = str(dec(key, unhexlify(ciphertext), unhexlify(nonce)))
    
    if (re.search("flag{[A-Za-z0-9]+}", flag)):
        print(flag)
        break

```

### Exploiting the vulnerability

- Having just completed the *exploit.py* we just need to run the following:

```bash
$ python3 exploit.py
```
* We then get the flag:

> ?

- nc ctf-fsi.fe.up.pt 6003 not working
