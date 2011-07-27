module Main where
  colorCombinations = [(aColor, anotherColor) | aColor <- ["black","white","blue","yellow","red"],
                                                anotherColor <- ["black","white","blue","yellow","red"],
                                                aColor > anotherColor]
