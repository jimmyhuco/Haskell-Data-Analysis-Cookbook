import Text.XML.HXT.Core

-- Parses an XML file
main :: IO ()
main = do
  input <- readFile "input.xml"
  dates <-
    runX $ readString [withValidate no] input //> hasName "date" //> getText
  bodies <-
    runX $ readString [withValidate no] input //> hasName "body" //> getText
  print dates
  print bodies
