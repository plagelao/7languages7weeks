fib2 := method(number, f0, f1, if(number == 2, f1, fib2(number - 1, f1, f0 + f1)))
fib := method(number, if(number == 1, 1, fib2(number, 1, 1)))

for(i,1,20,fib(i) println)
