module SECD.LambdaCalculusTests(allLambdaCalculusTests) where

import SECD.LambdaCalculus
import SECD.SECDCode
import SECD.TestUtils

allLambdaCalculusTests = do
  testFunction toSECD toSECDCases
  
toSECDCases =
  [(intVal 5, int 5),
   (boolVal True, bool True),
   (floatVal (-12.3), float (-12.3))]