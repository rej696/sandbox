
hello s = "Hi " ++ s

main = do
    putStrLn "name: "
    name <- getLine
    putStrLn $ hello name
