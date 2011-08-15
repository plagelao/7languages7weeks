module GCD where
  gcd :: Int -> Int -> Int
  gcd x y
    | x >= y = my_gcd x y
    | otherwise = my_gcd y x

  my_gcd :: Int -> Int -> Int
  my_gcd x y
    | y == 0 = x
    | otherwise = my_gcd y (mod x y)
