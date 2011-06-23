originalDiv := Number getSlot("/")
Number / := method(d,if(d == 0, 0, self originalDiv(d)))

1/0 println
1/2 println
10/5 println
