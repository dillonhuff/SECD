module SECD.LambdaCalculus(
  toSECD, intVal, floatVal, boolVal) where

import SECD.SECDCode

toSECD :: LambdaExpr -> SECDCode
toSECD (IntNum n) = int n
toSECD (FloatNum n) = float n
toSECD (BoolVal b) = bool b

data LambdaExpr
     = Lambda LambdaExpr
     | App LambdaExpr LambdaExpr
     | Var Variable
     | Let LambdaExpr LambdaExpr
     | IntNum Int
     | FloatNum Float
     | BoolVal Bool
       deriving (Eq, Ord, Show)
                
intVal = IntNum
floatVal = FloatNum
boolVal = BoolVal
       
data Variable
     = Free String
     | Bound Int
       deriving (Eq, Ord, Show)