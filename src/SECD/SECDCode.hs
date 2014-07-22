module SECD.SECDCode(
  SECDCode, int, bool, float,
  closure, access, apply,
  startLet, endLet, ret,
  jump, condJump, label,
  builtin, cons) where

type Name = String

data SECDCode
     = Integer Int
     | Boolean Bool
     | Floating Float
     | Closure [SECDCode]
     | Access Int Int
     | Builtin Name
     | Apply
     | Cons
     | Let
     | EndLet
     | Return
     | Jump Int
     | CondJump Int
     | Label Int
       deriving (Eq, Ord, Show)

int = Integer
bool = Boolean
float = Floating
closure = Closure
access = Access
builtin = Builtin
apply = Apply
cons = Cons
startLet = Let
endLet = EndLet
ret = Return
jump = Jump
condJump = CondJump
label = Label
