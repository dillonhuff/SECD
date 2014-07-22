module SECD.LambdaCalculus(
  toSECD, intVal, floatVal, boolVal,
  letRec, app, lambda, var, ifThenElse,
  emptyEnv) where

import Data.List

import SECD.SECDCode

toSECD :: Int -> Env -> LambdaExpr -> ([SECDCode], Int)
toSECD l _ (IntNum n) = ([int n], l)
toSECD l _ (FloatNum n) = ([float n], l)
toSECD l _ (BoolVal b) = ([bool b], l)
toSECD l e (Lambda names expr) = ([closure $ clCode], finalL)
  where
    clres =  toSECD l (names : e) expr
    clCode = (fst clres) ++ [ret]
    finalL = snd clres
toSECD l e (App expr args) = (finalCode, finalL)
  where
    appRes = toSECDConsList l e args
    appL = snd appRes
    appCode = fst appRes
    funcRes = toSECD appL e expr
    finalL = snd funcRes
    finalCode = appCode ++ (fst funcRes) ++ [apply]
toSECD l e (Var name) = case elem name builtinOps of
  True -> ([builtin name], l)
  False -> ([accessVar e name], l)
toSECD l e (IfThenElse c1 c2 c3) = (finalCode, finalL)
  where
   c1Res = toSECD (l+2) e c1
   c1Code = fst c1Res
   c1L = snd c1Res
   c2Res = toSECD c1L e c2
   c2Code = fst c2Res
   c2L = snd c2Res
   c3Res = toSECD c2L e c3
   c3Code = fst c3Res
   finalL = snd c3Res
   finalCode = c1Code ++ [condJump l] ++ c3Code ++ [jump (l+1)] ++ [label l] ++ c2Code

toSECDConsList :: Int -> Env -> [LambdaExpr] -> ([SECDCode], Int)
toSECDConsList l e exprs = ((int 0) : listCode, finalL)
  where
    listRes = toSECDConsListRec l e exprs
    listCode = fst listRes
    finalL = snd listRes

toSECDConsListRec :: Int -> Env -> [LambdaExpr] -> ([SECDCode], Int)
toSECDConsListRec l _ [] = ([], l)
toSECDConsListRec l e (expr:rest) = (finalCode, finalL)
  where
    nextRes = toSECD l e expr
    nextCode = fst nextRes
    nextL = snd nextRes
    restRes = toSECDConsListRec nextL e rest
    restCode = fst restRes
    finalL = snd restRes
    finalCode = nextCode ++ [cons] ++ restCode

accessVar :: Env -> Name -> SECDCode
accessVar e name = let nameListInd = getNameIndex 0 e name in
  access (fst nameListInd) (snd nameListInd)

getNameIndex :: Int -> Env -> Name -> (Int, Int)
getNameIndex _ [] n = error $ n ++ " has no entry in current environment"
getNameIndex i (x:xs) n = case elemIndex n x of
  Just j -> (i, j)
  Nothing -> getNameIndex (i+1) xs n

type Name = String

type Env = [[Name]]

emptyEnv :: Env
emptyEnv = []

data LambdaExpr
     = Lambda [Name] LambdaExpr
     | App LambdaExpr [LambdaExpr]
     | Var Name
     | LetRec [(Name, LambdaExpr)] LambdaExpr
     | IfThenElse LambdaExpr LambdaExpr LambdaExpr
     | IntNum Int
     | FloatNum Float
     | BoolVal Bool
       deriving (Eq, Ord, Show)

lambda = Lambda
app = App
var = Var
letRec = LetRec
intVal = IntNum
floatVal = FloatNum
boolVal = BoolVal
ifThenElse = IfThenElse

builtinOps = ["int_add", "int_sub", "int_mul", "int_div"]
