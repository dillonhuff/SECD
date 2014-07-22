module SECD.SECDCode(
  SECDCode, int, bool, float,
  closure, access, apply,
  startLet, endLet, ret) where

data SECDCode
     = Integer Int
     | Boolean Bool
     | Floating Float
     | Closure [SECDCode]
     | Access Int
     | Apply
     | Let
     | EndLet
     | Return
       deriving (Eq, Ord, Show)
       
int = Integer
bool = Boolean
float = Floating
closure = Closure
access = Access
apply = Apply
startLet = Let
endLet = EndLet
ret = Return