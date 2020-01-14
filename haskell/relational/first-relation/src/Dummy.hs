import Database.Relational -- for LTS-11 or LTS-10
-- import Database.Relational.Query -- instead of "import Database.Relational" for LTS-9 or LTS-8

hello :: Relation () (Int, String)
hello = relation $ return (value 0 >< value "Hello")

main :: IO ()
main = putStrLn $ show hello ++ ";"
