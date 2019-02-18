module Client (Client(Person, Company, Government, Organization), clientName, fibonacci) where

data Client = Person String
            | Company String
            | Government String
            | Organization String
            deriving Show

clientName :: Client -> Maybe String
clientName client = case client of
                      Person name  -> Just name 
                      Company name -> Just name 
                      _            -> Nothing

fibonacci :: Integer -> Integer
fibonacci n = case n of
                0 -> 1
                1 -> 1
                _ -> fibonacci(n - 1) + fibonacci(n - 2)

