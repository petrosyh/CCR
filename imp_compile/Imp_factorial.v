Require Import Coqlib.
Require Import Universe.
Require Import Imp.
Require Import ImpNotations.

Set Implicit Arguments.

Section Example_Extract.

  Import ImpNotations.

  Local Open Scope expr_scope.
  Local Open Scope stmt_scope.

  Definition factorial : stmt :=
    "fptr" =#& "factorial" ;#
    if# "input"
    then# "output" =@* "fptr" ["input" - 1%Z] ;#
          "output" =# "input" * "output"
    else# "output" =# 1%Z
    fi#;#
    "output".

  Definition factorial_fundef : function := {|
    fn_params := ["input"];
    fn_vars := ["output"; "fptr"];
    fn_body := factorial
  |}.

  Definition main : stmt :=
    "in" =@! "scanf" [] ;#
    "result" =@ "factorial" ["in": expr] ;#
    @! "printf" ["in": expr] ;#
    "result".

  Definition main_fundef : function := {|
    fn_params := [];
    fn_vars := ["in"; "result"];
    fn_body := main
  |}.

  Definition imp_factorial_mod : module := {|
    mod_vars := [];
    mod_funs := [("factorial", factorial_fundef); ("main", main_fundef)];
  |}.

End Example_Extract.
