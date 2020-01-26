# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 x 98
#Find the largest palindrome made from the product of two 3-digit numbers.

from itertools import product

val = range(111, 999)
cross_product = [x * y for x, y in product(val, val)]
cross_product.sort(reverse = True)

for n in cross_product:
    if n == int(''.join(reversed(str(n)))):
        print(n)
        break 


    
