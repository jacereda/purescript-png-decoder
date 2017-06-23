module Test.Main where

import Prelude
import Control.Monad.Aff (attempt, launchAff)
import Control.Monad.Aff.Console (CONSOLE, log)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Either (Either(..))
import Data.Image.PNG.Decoder (decode)
import Network.HTTP.Affjax (AJAX, get)

main :: forall e. Eff (exception :: EXCEPTION, ajax :: AJAX, console :: CONSOLE | e) Unit
main = void $ launchAff do
  tst "https://upload.wikimedia.org/wikipedia/en/2/24/Lenna.png"
  where tst url = do
          response <- attempt $ get url
          case response of
            Left err -> report err
            Right res -> do
              case decode res.response of
                Left err -> report err
                Right im -> log $ show im.width <> "x" <> show im.height
              pure unit
          pure unit

        report e = log $ "Error : " <> show e
