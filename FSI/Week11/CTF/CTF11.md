# CTF - Week 11

## RSA

In this challenge, we were given a flag{xxxxxxxx} that was ciphered using **RSA**.

As seen in [LOGBOOK11](LOGBOOK11.md), for this type of encryption, there are some important values needed, those being:

- `p` and `q` : two large prime numbers
- `n` : the modulus  
- `e` : public exponent
- `d` : the modular multiplicative inverse of `e` modulo `φ(n)`

To start off there are some things to take into account when looking at these values:

- **n = pq**

- **φ(n) = (p-1)(q-1)**, *(this value is kept secret)*

- **2 < e < φ(n) and gcd(e, φ(n)) = 1**, *gcd = greatest common divisor*

- **d ≡ e<sup>-1</sup> * (mod(φ(n)))**

The *public key* consists of the modulus `n` and the public exponent `e` and the *private key* consists of the modulus `n` and private exponent `d`:

- *public key* = (`n`, `e`)
- *private key* = (`n`, `d`)

**Note** : *p* , *q* and *φ(n)* must also be kepy secret, since they can be used to calculate *d*.

According to the challenge description we know that:

- `p` ≈ 2<sup>512</sup>
- `p` ≈ 2<sup>513</sup>

### Flag convertion

The challenge also made available to us a *python* file for us to understand the method of conversion of a flag in bytes to its numerical value and an algorithm for deciphering that does the opposite.

One extra information given to us was that : ciphering **m** means calculating *m<sup>e</sup>* and deciphering would be *(m<sup>e</sup>)<sup>d</sup> = m*


## Challenge.py Analysis

The python script firstly includes the libraries that will be used, those being :

- *os* → responsible for interacting with the operating system
- *sys* → responsible for the interaction between the program and the Python interpreter
- *getParams* → function that attempts to retrieve the parameters
- *hexlify* → function that converts the binary representation of data to hexadecimal
- *unhexlify* → opposite function of the *hexlify* function

```python
# Python Module ciphersuite
import os
import sys
from rsa_utils import getParams
from binascii import hexlify, unhexlify
```

Then it writes a way to read and interpret the file containing the flags 

```python
FLAG_FILE = '/flags/flag.txt'
...
with open(FLAG_FILE, 'r') as fd:
	un_flag = fd.read()
```

Using one of the modules aforementioned, it will retrieve the parameters mentioned in the [beggining of the document](#rsa), and save them to predetermined variables those being:

- `p`and `q` for the prime numbers
- `n` for their modulus
- `phi` for φ(n)
- `e` and `d` for the public and private exponent respectivelly

```python
(p, q, n, phi, e, d) = getParams()
```

Then the last two functions (*both prints*) will print first the public parameters and second will print the *ciphertext* which will take the flag and encrypt it.

```python
print("Public parameters -- \ne: ", e, "\nn: ", n)
print("ciphertext:", hexlify(enc(un_flag.encode(), e, n)).decode())
```

At last we analized the two functions `enc` and `dec`:

### *enc()*

1. Input Parameters:
    - `x` → A sequence of bytes
    - `e` → The public exponent
    - `n` → The modulus

2. Function Steps:
    - Converts the byte sequence *x* into an integer using the build-in function **int.from_bytes** with little-endian byte order
    - Uses the *pow()* function to perform a modular exponentiation : *y* = *int_x<sup>e</sup>* **mod** *n*
    - Uses *hexlify()* function to convert the byte sequence into its hexadecimal representation

3. Return:
    - The hexadecimal representation of the encrypted message

```python
def enc(x, e, n):
    int_x = int.from_bytes(x, "little")
    y = pow(int_x,e,n)
    return hexlify(y.to_bytes(256, 'little'))
```

### *dec()*

1. Input Parameters:
    - `y` → The hexadecimal representation of an encrypted message
    - `d` → The private exponent
    - `n` → The modulus

2. Function Steps:
    - Converts the hexadecimal representation *y* into an integer using the build-in function **int.from_bytes** with little-endian byte order after unhexlifying the input (converts hexadecimal to bytes)
    - Uses the *pow()* function to perform a modular exponentiation : *x* = *y<sup>d</sup>* **mod** *n*
    - Converts the resulting integer *x* into a byte sequence of length 256 with little-endian byte order

3. Return:
    - The decrypted byte sequence, which is the original message

```python
def dec(y, d, n):
    int_y = int.from_bytes(unhexlify(y), "little")
    x = pow(int_y,d,n)
    return x.to_bytes(256, 'little')
```

This meant that if we found the values of the primes `p` and `q` used to encrypt the flag, we would be able to find the value `d` and therefore use the function `dec()` with the known parameters to decrypt the message.


## Finding the Prime Numbers

Yielding to what the guide provided us, we had the need to implement a function that would test the primality of numbers. The guide also suggest using the [*Miller-Rabin* algorithm](https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test) to do these tests.

A quick-search led us to a rather [simplified implementation](https://gist.github.com/Ayrx/5884790) of said algorithm:

```python
import random

def miller_rabin(n, k):

    # Implementation uses the Miller-Rabin Primality Test
    # The optimal number of rounds for this test is 40
    # See http://stackoverflow.com/questions/6325576/how-many-iterations-of-rabin-miller-should-i-use-for-cryptographic-safe-primes
    # for justification

    # If number is even, it's a composite number

    if n == 2:
        return True

    if n % 2 == 0:
        return False

    r, s = 0, n - 1
    while s % 2 == 0:
        r += 1
        s //= 2
    for _ in range(k):
        a = random.randrange(2, n - 1)
        x = pow(a, s, n)
        if x == 1 or x == n - 1:
            continue
        for _ in range(r - 1):
            x = pow(x, 2, n)
            if x == n - 1:
                break
        else:
            return False
    return True
```

After that, the guide advided us to implement an RSA. Including that since we could already test for prime number, we would only need to find *(e,d)* such that *ed % (p-1)(q-1) = 1*, which will be used for the public and private key, respectively.

To start off, the guide tells us that the primes are next to a certain number, and with that, we deduced that, for example, `p` would be a number after 2<sup>512</sup> and that number had to be a prime one.

Since we already had the function to test the prime numbers, we decided to implement a function that would find the next prime value.

```python
def closestPrime(n):
    
    if (n <= 1): 
        return 2  # first prime number is 2
    
    prime = n
    primeFound = False
    
    while(not primeFound):
        prime = prime + 1
        
        if (miller_rabin(prime,40)==True):
            primeFound = True
    
    return prime
```

We saved these two functions in a *Python* file called [*scriptedPrime.py*](/week11-extras/ctf/scriptedPrime.py).


Now that we had dealt with the issue of the prime numbers, we just had write the script to decrypt the flag.

Since we already had the decrypting function defined in *challenge.py*, we decided to just add new information to said file in order to comply with our desired output. The full new script can be found [here](/week11-extras/ctf/challenge.py)


First we had to add our previously defined function to this file:

```python
from scriptedPrime import closestPrime
```

Since we would not need to encrypt messages we removed the following from the original file:

```python
import os
import sys
from rsa_utils import getParams
import hexlify
FLAG_FILE = '/flags/flag.txt'

def enc(x, e, n):
    int_x = int.from_bytes(x, "little")
    y = pow(int_x,e,n)
    return hexlify(y.to_bytes(256, 'little'))

with open(FLAG_FILE, 'r') as fd:
	un_flag = fd.read()

(p, q, n, phi, e, d) = getParams()

print("Public parameters -- \ne: ", e, "\nn: ", n)
print("ciphertext:", hexlify(enc(un_flag.encode(), e, n)).decode())
sys.stdout.flush()
```

Now  that we were ready for the rest of the script, we finally went into the server `nc ctf-fsi.fe.up.pt 6004` in which we obtained:

```bash
Public parameters --
e:  65537
n: 359538626972463181545861038157804946723595395788461314546860162315465351611001926265416954644815072042240227759742786715317579537628833244985694861278971243146135638403756740005476362228600815351288481858812807445552284189996501896013041435503010713705189426005962420057108679785981920977128846367293882688819
ciphertext: 3861666438333061363430323863323333333436623437643233363735306364383935626634666238323434373031623065643030643162653839383261353735303965383964393937646335313730613238633465363739656332383961306432396130306631363762393862666663656235623031396231643430373861383536383039336333326537343861343338353038373064643766356662633337323738333263363734363034643733623231346565663939333638363436323737353732376561386632386136366235613234303932353033643838386636396233643833393730306361326131396363333239393536663264616439336230303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030
```

We took these values and hard coded them into our cript, adding them as variables `e`, the public exponent, `n`, the modulus, and `ciphertext`, the text we want to decipher.

Looking back at the guide we have the knowledge that both `p` and `q` are the prime numbers next to 2<sup>512</sup> and 2<sup>513</sup>, respectively. Meaning that we could use our new function *closestPrime(n)* to find these values.

```python
# Finding the values of P and Q prime numbers

p = closestPrime(2**512)
q = closestPrime(2**513)
```

We know that *pq = n* so we needed to make something to test the prime numbers we asserted before.

#### Thought Process:

1. The outer *while* loop runs indefinitely (or until **break** is called)
2. The inner *while* loop continues generating the next prime for `p` until *pq* >= *n*, ensuring that the product of `p` and `q` is at least as large as `n`
3. Checking for equality, i.e., if *pq* = *n* the loop is terminated and the desired pair of primes was found
4. Adjusting `q` and reseting `p`, so if *pq* < *n*, *q* is updated to the next prime. *p* is reset to its initial value and the loop continues

```python
# pq = n

p_temp = p

while(True):
    
    # when the multiplication is inferior to the modulus
    while p * q < n:
        p_temp = closestPrime(p_temp)
        continue    
    
    if p * q == n:
        break
    
    q = closestPrime(q)
    p_temp = p
```

Now we know that when we have knowledge of the values of `p`, `q` and  `n` we can calculate the value of `d`, aka, the private exponent.
*(m<sup>e</sup>)<sup>d</sup> = m*, meaning that after finding `d`, we would be able to decipher the message.

As previously mentioned, `d` = e<sup>-1</sup> * (mod(φ(n))), therefore, as we saw when analysing the *enc()* function, we can use the built-in *pow()* function with 3 parameters to obtain that value.

__*Note*__: As we saw above, *φ(n)* can be obtained by doing *(p-1)(q-1)*

```python
# Find out d value

phi = (p-1) * (q-1)

d = pow(e, -1, phi)
```

All that's left to do is to decrypt the message and print it so we finally obtain our desired flag.
We once again reporpused the *challenge.py* file and retrieved the following *print()* command

```python
print("ciphertext:", hexlify(enc(un_flag.encode(), e, n)).decode())
```

Since this command was used to print the ciphered text, we just needed to modify some values in order to do the opposite.

1. Remove the unnecessary string at the beggining
2. Instead of *hexlify()*, we use *unhexlify*
3. We remove the *enc()* function and add the *dec()* function in the begging
4. We used the **unhexlified** ciphertext, our calculated d variable and the provided n value as parameters for the *dec()* function.
5. At the end we keep the *decode()* function which will decode the encoded form of a string, aka, our flag.
6. Instead of a print, make it a variable and then print it


```python
# decrypting the message and printing it

flag = dec(unhexlify(ciphertext), d, n).decode()

print(flag)
```

### Obtaining the Flag

All thats left to do now is to compile our script and check the result.

```bash
$ python3 challenge.py
```

Which yielded the result:

`flag{444e2f8c7eebe7269df3d7421a9fa76c}`

Meaning that we had found our flag!