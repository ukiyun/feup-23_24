# Trabalho realizado nas Semanas #2 e #3

## Identificação

- CVE-2013-6632
- Integer overflow in Google Chrome prior to version 31.0.1650.57.
- Exploit available on Chromium browser on all compatible OS devices.

## Catalogação

- Demonstrated by Pinky Pie during a Mobile Pwn2Own competition at PacSec 2013
- Bug Bounty of $50,000
- Ranking 9.3 base score and 8.6 exploitability score with a 10.0 impact score.

## Exploit

- Runtime_TypedArrayInitializeFromArrayLike checks for the lack of multiplicative overflow with 'length * element_size < length'.
- 0x24924925 is 2^32/7 + 1, the smallest number for which this check passes, yet there was in fact overflow. 
- As for large numbers this check will pass despite an overflow occurring.

## Ataques

- This vulnerability would allow the exectution of remote code on the targeted device.
- No attacks utilizing this exploit were documented




