#The prime factors of 13195 are 5, 7, 13 and 29.
#
#What is the largest prime factor of the number 600851475143 ?

import time
import math
from itertools import compress

def is_prime_v1 (n):
    """ Return 'true' if 'n' is a prime number. False otherwise"""
    if n== 1:
        return False # 1 is not a prime number

    for d in range (2, n):
        if n % 2 == 0:
            return False
    return True

def is_prime_v2(n):
    """ Return 'true' if 'n' is prime """
    if n == 1:
        return False

    max_divisor = math.floor(math.sqrt(n))
    for d in range(2, 1 + max_divisor):
        if n % d == 0:
            return False
    return True

def is_prime_v3(n):
    if n == 1:
        return False

    if n == 2:
        return True
    if n > 2 and n % 2 == 0:
        return False

    max_divisor = math.floor(math.sqrt(n))
    for d in range(3, 1 + max_divisor, 2):
        if n % d == 0:
            return False
    return True

def largest_prime_factor(n):
    i = 1
    while  i * i  < n:
        while n % i == 0:
            n = n / i
        i = i + 1
    print (n)



#====== Test function
for n in range (1, 21):
    print(n, is_prime_v3(n))

#==== Time function
t0 = time.time()
for n in range(1, 1000):
    is_prime_v3(n)
t1 = time.time()

print("Time required: ", t1 -t0)

#==== Euler Solution
max_number = 600851475143

#1) is n divisible by 2?
# 2) yes add 2 to list of factors and divide n by 2
# 3) If no, increment initial prime factor by 1 and repeat

def find_prime_factors(n):
  list_of_factors=[]
  i=2
  while n>1:
    if n%i==0:
      list_of_factors.append(i)
      n=n/i
      i=i-1
    i+=1  
  return list_of_factors

print(find_prime_facs(max_number))

