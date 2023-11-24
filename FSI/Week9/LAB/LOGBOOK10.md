# Week 10 - Secret Key Encription

// missing stuff


## Task 1 -> Frequency Analysis:

> executing *./freq.py* we get:

```console
-------------------------------------
1-gram (top 20):
g: 488
z: 373
u: 348
j: 291
y: 280
m: 276
v: 264
q: 235
h: 183
b: 166
f: 156
s: 116
t: 104
c: 95
p: 90
n: 83
x: 83
a: 82
w: 76
r: 59
-------------------------------------
2-gram (top 20):
zh: 115
hg: 89
vy: 74
gq: 58
uq: 57
qg: 57
uy: 56
gm: 53
jy: 52
yf: 46
jq: 45
zg: 44
gf: 44
uz: 44
gy: 42
mz: 39
um: 33
ub: 32
ng: 32
su: 31
-------------------------------------
3-gram (top 20):
zhg: 78
uyf: 30
vya: 20
zgq: 18
jcz: 16
vjy: 14
ngm: 14
zhu: 13
gmz: 13
ubb: 13
xjq: 13
pum: 12
gyz: 12
uzg: 12
yuz: 11
pvy: 11
guq: 11
tvy: 11
hvm: 10
uqf: 10
``` 

- To better keep track of our decrypting, we use the txt file with all the letters in lowercase *lowscase.txt*, and the letters we substitute will be in upper case.

- According to english language, 'e' is the most common single letter, 'th' is the most common bigram and, 'the' is the most common trigram.

- This strongly suggest that in our ciphered text 
  - g -> e, zh -> th, zhg-> the; z = t, h = h, g = e.

```console
tr 'zhg' 'THE' <lowscase.txt> out.txt
```

// show the change in out.txt 

- Since g and z are accounted for, the next more frequent char is the letter 'a', so we will assume for now that
  - u-> a

```console
tr 'u' 'A' <out.txt> out1.txt
```

// show the change in out1.txt

- In the current text, with the letters already deciphered, we see various instances of 'THAy', since y is not deciphered, it can't be the word 'THAT' so the next most frequent one would be 'THAN', so we are presuming that
  - y -> n

```console
tr 'y' 'N' <out1.txt> out2.txt
```

- We know the second most frequent trigram is 'uyf', since we assume we know 'u' and 'y', we get 'ANf' and arguably the most common trigram with 'AN' in the beginning would be the word 'AND'
  - f -> d

```console
tr 'f' 'D' <out2.txt> out3.txt
```

- We have the word 'vNTENDED', the possible words would be either 'UNTENDED' or 'INTENDED', and since the letter 'i' is more frequent in the english language, we will for now assume
  - v -> i

```console
tr 'v' 'I' <out3.txt> out4.txt
```

- We have the words 'pHETHEq' 'THEqE', the most common word with 'THE_E' would be 'THERE' so lets make q -> e, and now the first word becomes 'pHETER', and the only word with 5 letter ending in 'HETER' is 'WHETER'
  - p->w

```console
tr 'pq' 'WR' <out4.txt> out5.txt
```

- We have the words 'INmTEAD' 'AWARDm' being that the letter missing is the same, the only letter possible to complete those words is 's'
  - m->s

```console
tr 'm' 'S' <out5.txt> out6.txt
```

- We have the word 'TcRNS', the only possible letters for 'c' would be either 'u', 'a', 'e', but since we already have the letters equivalent to 'a' and 'e', the only option is that the letter 'c' is the ciphered 'u'
  - c -> u

```console
tr 'c' 'U' <out6.txt> out7.txt
```

- We have the word 'SwEARHEADED', the only word fitting that would be SPEARHEADED, so w -> p, with this, the words 'SUwwjRTERS'; 'SUwwjRT' become 'SUPPwRTERS' and 'SUPPwRT', meaning that most likely those words are 'SUPPORTERS' and 'SUPPORT'
  - j->o

```console
tr 'wj' 'po' <out7.txt> out8.txt
```

- We have the following phrase: 'AS IT TURNS OUT AT bEAST IN TERtS Ox THE OSsARS IT PROnAnbr WONT nE', this most likely deciphered says: 'AS IT TURNS OUT AT LEAST IN TERMS OF THE OSCARS IT PROBABLY WONT BE'
so we can assume an array of letters just from the phrase:
  - b->l ; t->m ; x-> f ; n->b ; r->y  *(All letter that are not still defined in our deciphered text)*

```console
tr 'btxnr' 'LMFBY' <out8.txt> out9.txt
```

- Lets look at the first paragraph : 'THE OSsARS TURN  ON SUNDAY WHIsH SEEMS ABOUT RIaHT AFTER THIS LONa STRANaE AWARDS TRIP THE BAaaER FEELS LIlE A NONAaENARIAN TOO', while analyzing this phrase, we conclude that these might be the deciphered letters:
  - s->c ; a->g ; l->k

```console
tr 'sal' 'CGK' <out9.txt> out10.txt
```

- 'HARiEY WEINSTEIN' probably refers to Harvey Weinstein so:
  - i->v

```console
tr 'i' 'v' <out10.txt> out11.txt
```

- With a quick search on google, we were able to find the [corresponding article in the *nytimes* website](https://www.nytimes.com/2018/03/01/movies/oscars-sunday-what-to-expect.html)
  - Comparing the article with the text we currently have we conclude that the missing deciphered letters are:
        - d->x  ; e->q ; k->j ; o->z

```console
tr 'deko' 'XQJZ' <out11.txt> out12.txt
```

- And with that we have solved the ciphered text!


## Task 2 -> Encryption using Different Ciphers and Modes

