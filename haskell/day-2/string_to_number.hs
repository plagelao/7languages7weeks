module Main where
  toNumber (h:t) = read (filter (/= ',') t) :: Double
