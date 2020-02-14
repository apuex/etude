{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import qualified Control.Monad        as M
import qualified Data.List            as L
import qualified Data.Text.Lazy       as TL
import qualified Data.Text.Lazy.IO    as TLIO
import qualified Data.Set             as Set
import           Text.Regex
import           System.IO
import           System.Environment
import           CmdLine
import           Tokenizer


main :: IO ()
main = do
    progName <- getProgName
    args     <- getArgs
    (opts, files) <- compileOpts progName args
    if null files
        then hPutStrLn stderr (header progName)
        else do
            tokens <- M.mapM (withInputFile transform opts) files
            let (_, a) = token
                    $ TL.pack
                    $ show
                    $ Set.fromList
                    $ L.concat tokens
            TLIO.putStrLn $ TL.strip a

withInputFile :: (Options -> TL.Text -> [TL.Text]) -> Options -> String -> IO [TL.Text]
withInputFile f opts inputFile = do
    content <- TLIO.readFile inputFile
    return (f opts content)

transform ::Options -> TL.Text -> [TL.Text]
transform opts content = filter (\ t -> case matchRegex (mkRegex "[0-9]+") (TL.unpack t) of
    Just _ -> False
    _      -> True
    )
    $ L.concatMap (fst . tokenize)
    $ TL.lines content
