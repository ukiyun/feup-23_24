#!/bin/env python3

import random

s = "abcdefghijkflmnopqrstuvwxyz"
list = random.sample(s, len(s))
key = ''.join(list)
print(key)
