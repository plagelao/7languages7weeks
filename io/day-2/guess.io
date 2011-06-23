tryAGuess := method(input, input readLine asNumber == call sender asNumber)
Number guess := method(10 repeat(if(tryAGuess(File standardInput), return "Right" println, "Wrong" println)))

Random value(100) ceil guess
