module Main where
  toNumber (h:t) = read (filter (\c -> c /= ',') t) :: Float
