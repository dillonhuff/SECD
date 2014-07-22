module SECD.LambdaCalculusTests(allLambdaCalculusTests) where

import SECD.LambdaCalculus
import SECD.SECDCode
import SECD.TestUtils

allLambdaCalculusTests = do
  testFunction (fst . toSECD 0 emptyEnv) toSECDCases
  
toSECDCases =
  [(intVal 5, [int 5]),
   (boolVal True, [bool True]),
   (floatVal (-12.3), [float (-12.3)]),
   (app (var "int_sub") [intVal 4, intVal (-23)],
    [int 0, int 4, cons, int (-23), cons, builtin "int_sub", apply]),
   (lambda ["no", "yes"] (app (var "int_add") [var "no", var "yes"]),
    [closure
      [int 0, access 0 0, cons, access 0 1, cons, builtin "int_add", apply, ret]]),
   (ifThenElse (boolVal True) (intVal 0) (intVal 2),
    [bool True, condJump 0, int 2, jump 1, label 0, int 0])]
