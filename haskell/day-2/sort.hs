module Main where
  mySort :: [Integer] -> [Integer]
  mySort list
    | list == []    = []
    | t == []       = list
    | tail t == []  = sortTwoNumbers h (head t)
    | otherwise     = if areOrdered h t then h:(mySort t) else (head (mySort t)):mySort((h:(tail (mySort t))))
      where h = head list
            t = tail list
            areOrdered number list =  number > (head (mySort list))
            sortTwoNumbers x y = if x > y then [x,y] else [y,x]

  mySortWithFunction list fun
    | list == []    = []
    | t == []       = list
    | tail t == []  = sortTwoNumbers h (head t)
    | otherwise     = if areOrdered h t then h:(orderWithFun t) else (head(orderWithFun t)):orderWithFun((h:(tail(orderWithFun t))))
      where h = head list
            t = tail list
            areOrdered number list = fun number (head (orderWithFun list))
            sortTwoNumbers x y = if fun x y then [x,y] else [y,x]
            orderWithFun list = mySortWithFunction list fun
