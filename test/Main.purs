module Test.Main where

import Prelude

import Effect.Aff (attempt, launchAff_)
import Effect.Class.Console (log)
import Effect (Effect)
import Data.ArrayBuffer.ArrayBuffer (byteLength)
import Data.Either (Either(..))
import Data.Image.PNG.Decoder (decode)
import Network.HTTP.Affjax (get)
import Network.HTTP.Affjax.Response as Response


main :: Effect Unit
main = launchAff_ do
  tst "https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png"
  where tst url = do
          response <- attempt $ get Response.arrayBuffer url
          case response of
            Left err -> report err
            Right res -> do
              case decode res.response of
                Left err -> report err
                Right im -> do
                  log $ show im.width <> "x" <> show im.height <> " size " <> show (byteLength im.data)
                  pure unit
              pure unit
          pure unit
        report e = log $ "Error : " <> show e
