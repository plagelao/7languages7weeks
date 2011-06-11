#!/usr/bin/env ruby

number = rand(10) + 1
guess = 0
puts "Can you guess the number I'm thinking of? (1-10)"
while guess != number
  guess = gets.to_i
  puts "Your guess is to low" if guess < number
  puts "Your guess is to high" if guess > number
end
puts "Well done!"
