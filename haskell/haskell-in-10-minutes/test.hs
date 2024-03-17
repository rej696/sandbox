module Main where

-- factorial n = if n == 0 then 1 else n * factorial (n - 1)
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- main = do putStrLn "What is 5! ?"
--           x <- readLn
--           if x == factorial 5
--              then putStrLn "You're right!"
--              else putStrLn "You're wrong!"

-- secsToWeeks secs = let perMinute = 60
--                        perHour   = 60
--                        perDay    = 24
--                        perWeek   = 7
--                     in secs / perWeek

classify age = case age of 0 -> "newborn"
                           1 -> "infant"
                           2 -> "toddler"
                           _ -> "senior citizen"

main = do x <- readLn
          print (classify x)
