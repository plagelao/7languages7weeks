module Main where
  my_reverse [] = []
  my_reverse(h:t) = reverse(t) ++ [h]
