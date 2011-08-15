module Text_Test where
  import Text
  import Test.HUnit

  tests = TestList [
      wordSizeIsNumberOfColumns,
      firstLineOfAText,
      breakText
    ]

  wordSizeIsNumberOfColumns = TestList [
      ["Hello"] ~=? justify 5 "Hello",
      ["Hello", "Hello"] ~=? justify 5  "Hello Hello",
      ["Hello", "Hello", "Hello"] ~=? justify 5 "Hello Hello Hello",
      ["Hello", "Hello", "Hello"] ~=? justify 6 "Hello Hello Hello"
    ]

  firstLineOfAText = TestList [
      "hello" ~=? firstLineWhen 5 ["hello", "goodbye"],
      "the sun" ~=? firstLineWhen 8 ["the","sun"]
    ]

  breakText =
      ["I am so", "glad to", "meet you"] ~=? justify 10 "I am so glad to meet you"

  main = runTestTT tests
