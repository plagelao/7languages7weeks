module Text where

  justify :: Int -> [Char] -> [[Char]]
  justify columns text
    | text == "" = []
    | otherwise = firstLine:(justify columns textWithoutFirstLine)
      where textWords = words text
            firstLine = firstLineWhen columns textWords
            textWithoutFirstLine = unwords (words (drop (length firstLine) text))

  firstLineWhen :: Int -> [[Char]] -> [Char]
  firstLineWhen columns textWords = unwords (line columns textWords)

  line :: Int -> [[Char]] -> [[Char]]
  line columns textWords
    | textWords == [] || columns < length firstWord = []
    | otherwise = firstWord:(line remainingColumns (tail textWords))
      where firstWord = head textWords
            remainingColumns = columns - 1 - (length firstWord)

  addLineNumbers :: Int -> [[Char]] -> [(Int, [Char])]
  addLineNumbers line (firstLine:text) = (line, firstLine):(addLineNumbers (line+1) text)
  addLineNumbers line [] = []

  justifyWithNumbers columns text = addLineNumbers 1 (justify columns text)
