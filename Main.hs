import Test
import GildedRoseTest
import System.Exit

mainTests = gildedRoseTest


main = handle $ runTests mainTests
       where handle result@(Fail msgs) = do
               print result
               exitFailure
             handle Pass = do
               print Pass
               exitSuccess
