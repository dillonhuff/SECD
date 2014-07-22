module SECD.LambdaCalculus(
  toSECD, intVal, floatVal, boolVal,
  letRec, app, lambda, var,
  emptyEnv) where

import Data.List

import SECD.SECDCode

toSECD :: Env -> LambdaExpr -> [SECDCode]
toSECD _ (IntNum n) = [int n]
toSECD _ (FloatNum n) = [float n]
toSECD _ (BoolVal b) = [bool b]
toSECD e (Lambda names expr) = [closure $ toSECD (names : e) expr]
toSECD e (App expr args) = (toSECDConsList e args) ++ (toSECD e expr) ++ [apply]
toSECD e (Var name) = case elem name builtinOps of
  True -> [builtin name]
  False -> [accessVar e name]

toSECDConsList :: Env -> [LambdaExpr] -> [SECDCode]
toSECDConsList e exprs = (int 0) : (toSECDConsListRec e exprs)

toSECDConsListRec :: Env -> [LambdaExpr] -> [SECDCode]
toSECDConsListRec _ [] = []
toSECDConsListRec e (expr:rest) = (toSECD e expr) ++ [cons] ++ (toSECDConsListRec e rest)

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

builtinOps = ["int_add", "int_sub", "int_mul", "int_div"]
