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
