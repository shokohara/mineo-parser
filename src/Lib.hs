{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
module Lib where

--import Text.XML.HXT.Core hiding (getText)
--import Text.XML.HXT.Arrow.XmlArrow hiding (getText)
--import Text.XML.HXT.XPath.Arrows
--import Control.Arrow
import Test.WebDriver
import Data.Text
import Data.String.Here

someFunc :: IO ()
someFunc = putStrLn "someFunc"

--x :: IOStateArrow s b XmlTree
--x = readDocument [withValidate no] ""

chromeConfig = useBrowser chrome defaultConfig

crawl :: Text -> Text -> IO Text
crawl eoId password = runSession chromeConfig $ do
  openPage "https://my.mineo.jp/"
  saveScreenshot "1.png"
  userInput <- findElem . ByXPath $ [i|//*[@id="user"]|]
  passwordInput <- findElem . ByXPath $ [i|//*[@id="password"]|]
  sendButton <- findElem . ByXPath $ [i|//*[@id="pagePaging"]/li/p/input|]
  sendRawKeys eoId userInput
  sendRawKeys password passwordInput
  saveScreenshot "2.png"
  click sendButton
  radioButton <- findElem . ByXPath $ [i|//*[@id="radio_0"]|]
  click radioButton
  nextButton <- findElem . ByCSS $ [i|#pagePaging > li > p > input|]
  click nextButton
  x <- findElem . ByXPath $ [i|//*[@id="graphRemaining"]|]
  getText x

