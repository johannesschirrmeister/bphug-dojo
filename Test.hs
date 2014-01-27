module Test where

import qualified Data.List as DL


data Test = Test { f :: Bool, msg :: String }
data TestResult = Pass | Fail [String]

instance Show TestResult where
  show (Pass) = "All tests passed!"
  show (Fail msgs) = (show $ length msgs) ++ " tests failed:\n" ++ (DL.intercalate "\n" msgs)

combineTestResults :: TestResult -> TestResult -> TestResult
combineTestResults Pass Pass = Pass
combineTestResults retval@(Fail msgs) Pass = retval
combineTestResults Pass retval@(Fail msgs) = retval
combineTestResults (Fail msgs1) (Fail msgs2) = Fail $ msgs1 ++ msgs2

runTest :: Test -> TestResult
runTest (Test True _) = Pass
runTest (Test False msg) = Fail [msg]

runTests :: [Test] -> TestResult
runTests = (foldl combineTestResults Pass) . (map runTest)

add2 = (+3)

add2_3_f = Test (add2 3 == 5) "2 + 3 should equal 5"
add2_4_f = Test (add2 4 == 6) "2 + 4 should equal 6"
add2_5_f = Test (add2 5 == 7) "2 + 5 should equal 7"

add2_3_p = Test (add2 2 == 5) "2 + 3 should equal 5"
add2_4_p = Test (add2 3 == 6) "2 + 4 should equal 6"
add2_5_p = Test (add2 4 == 7) "2 + 5 should equal 7"

exampleFailingTests = [add2_3_f, add2_4_f, add2_5_f]
examplePassingTests = [add2_3_p, add2_4_p, add2_5_p]
