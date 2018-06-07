module Data.Image.PNG.Decoder where

import Effect.Exception (Error)
import Data.ArrayBuffer.Types (ArrayBuffer)
import Data.Either (Either(..))

type Image = { width :: Int
             , height :: Int
             , data :: ArrayBuffer
             }

foreign import decodeImpl :: (Error -> Either Error Image) -> (Image -> Either Error Image) -> ArrayBuffer -> Either Error Image

decode :: ArrayBuffer -> Either Error Image
decode = decodeImpl Left Right
