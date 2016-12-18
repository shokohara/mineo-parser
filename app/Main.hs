{-# LANGUAGE OverloadedStrings #-}
module Main where

import Prelude hiding (putStrLn)
import Lib
import Data.Text.IO

main :: IO ()
main = crawl "id" "pw" >>= putStrLn

