module Test.Main where

import Prelude

import Control.Monad.Aff (attempt, launchAff)
import Control.Monad.Aff.Class (liftAff)
import Control.Monad.Aff.Console (CONSOLE, log)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.ArrayBuffer.ArrayBuffer (ARRAY_BUFFER, byteLength)
import Data.ArrayBuffer.DataView (whole)
import Data.ArrayBuffer.Typed (asInt8Array, toArray) as AB
import Data.Either (Either(..))
import Data.Image.PNG.Decoder (decode)
import Network.HTTP.Affjax (AJAX, get)
import Debug.Trace(spy)

main :: forall e. Eff (exception :: EXCEPTION, ajax :: AJAX, console :: CONSOLE, arrayBuffer :: ARRAY_BUFFER | e) Unit
main = void $ launchAff do
  tst "https://upload.wikimedia.org/wikipedia/en/2/24/Lenna.png"
  where tst url = do
          response <- attempt $ get url
          case response of
            Left err -> report err
            Right res -> do
              case decode res.response of
                Left err -> report err
                Right im -> do
                  log $ show im.width <> "x" <> show im.height <> " size " <> show (byteLength $ spy im.data)
                  pure unit
              pure unit
          pure unit
        report e = log $ "Error : " <> show e

