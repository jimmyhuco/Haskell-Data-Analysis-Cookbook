{-# LANGUAGE OverloadedStrings #-}

import Control.Applicative
import Data.Aeson
import qualified Data.ByteString.Lazy as B
import Data.Maybe (fromJust)

data Mathematician = Mathematician
  { name :: String
  , nationality :: String
  , born :: Int
  , died :: Maybe Int
  }

instance FromJSON Mathematician where
  parseJSON (Object v) =
    Mathematician <$> (v .: "name") <*> (v .: "nationality") <*> (v .: "born") <*>
    (v .:? "died")

-- Parses a JSON object as a Mathematician data type.
main :: IO ()
main = do
  input <- B.readFile "input.json"
  let mm = decode input :: Maybe Mathematician
  case mm of
    Nothing -> print "error parsing JSON"
    Just m -> (putStrLn . greet) m

greet m =
  (show . name) m ++
  " was born in the year " ++
  (show . born) m ++ " and died in the year " ++ (show . fromJust . died) m
