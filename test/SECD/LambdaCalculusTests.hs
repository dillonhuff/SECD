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
   (lambda ["oooh"] (floatVal 9.3), [closure [float 9.3, ret]]),
   (ifThenElse (boolVal True) (intVal 0) (intVal 2),
    [bool True, condJump 0, int 2, jump 1, label 0, int 0, label 1]),
   (letRec [("sub", (lambda ["n"]
     (ifThenElse (var "n") (app (var "sub") [var "n"]) (boolVal True))))]
    (app (var "sub") [boolVal True]),
    [dum, int 0, closure [access 0 0, condJump 0, bool True, jump 1, label 0,
     int 0, access 0 0, cons, access 1 0, apply, label 1, ret], cons,
     closure [int 0, bool True, cons, access 0 0, apply, ret], rap])]
