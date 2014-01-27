```
GHCi, version 7.6.3: http://www.haskell.org/ghc/  :? for help
Loading package ghc-prim ... linking ... done.
Loading package integer-gmp ... linking ... done.
Loading package base ... linking ... done.
Prelude> :load Main
[1 of 2] Compiling Test             ( Test.hs, interpreted )
[2 of 2] Compiling Main             ( Main.hs, interpreted )
Ok, modules loaded: Test, Main.
*Main> runTests mainTests
All tests passed!
*Main> runTests exampleFailingTests
3 tests failed:
2 + 3 should equal 5
2 + 4 should equal 6
2 + 5 should equal 7
*Main> runTests examplePassingTests
All tests passed!
```
