{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

import Data.Aeson
import qualified Data.ByteString.Lazy as B
import Data.Maybe (fromJust)
import GHC.Generics

data Mathematician = Mathematician
  { name :: String
  , nationality :: String
  , born :: Int
  , died :: Maybe Int
  } deriving (Generic)

instance FromJSON Mathematician

instance ToJSON Mathematician

main = do
  input <- B.readFile "input.json"
  let mm = decode input :: Maybe Mathematician
  case mm of
    Nothing -> print "error parsing JSON"
    Just m -> (putStrLn . greet) m

greet m =
  (show . name) m ++
  " was born in the year " ++ (show . born) m ++ "\n JSON: " ++ show (encode m)
