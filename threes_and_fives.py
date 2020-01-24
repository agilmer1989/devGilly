# euler problem number 1
#If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
#Find the sum of all the multiples of 3 or 5 below 1000.
#>>> import threes_and_fives as euler
#>>> euler.threes_and_fives(1000)
#233168

def threes_and_fives(x):
  total_sum = 0
  for i in range(x):
    if( i % 3 == 0 or i % 5 == 0 ):
      total_sum+=i;
  print total_sum

