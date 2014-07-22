module SECD.LambdaCalculusTests(allLambdaCalculusTests) where

import SECD.LambdaCalculus
import SECD.SECDCode
import SECD.TestUtils

allLambdaCalculusTests = do
  testFunction (toSECD emptyEnv) toSECDCases
  
toSECDCases =
  [(intVal 5, [int 5]),
   (boolVal True, [bool True]),
   (floatVal (-12.3), [float (-12.3)]),
   (lambda ["no", "yes"] (app (var "int_add") [var "no", var "yes"]),
    [closure [int 0, access 0 0, cons, access 0 1, cons, builtin "int_add", apply]])]
