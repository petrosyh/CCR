Require Import HoareDef MutHeader MutGImp MutG0 SimModSem.
Require Import Coqlib.
Require Import Universe.
Require Import Skeleton.
Require Import PCM.
Require Import ModSem Behavior.
Require Import Relation_Definitions.

(*** TODO: export these in Coqlib or Universe ***)
Require Import Relation_Operators.
Require Import RelationPairs.
From ITree Require Import
     Events.MapDefault.
From ExtLib Require Import
     Core.RelDec
     Structures.Maps
     Data.Map.FMapAList.

Require Import HTactics.
Require Import TODO.

Generalizable Variables E R A B C X Y.

Set Implicit Arguments.

Local Open Scope nat_scope.




Section SIMMODSEM.

  Context `{Σ: GRA.t}.
  Local Opaque GRA.to_URA.

  Let W: Type := (alist mname (Σ * Any.t)) * (alist mname (Σ * Any.t)).

  Let wf: W -> Prop :=
    fun '(mrps_src0, mrps_tgt0) =>
      (<<SRC: mrps_src0 = Maps.add "G" (ε, tt↑) Maps.empty>>) /\
      (<<TGT: mrps_tgt0 = Maps.add "G" (ε, tt↑) Maps.empty>>)
  .

  Theorem correct: ModSemPair.sim MutG0.GSem MutGImp.GSem.
  Proof.
    econstructor 1 with (wf:=wf) (le:=top2); et; ss.
    econs; ss. init. unfold cfun, gF.
    unfold Imp.eval_function. ss. steps.
    eapply Any.downcast_upcast in _UNWRAPN. des. clarify.
    unfold unint in *. ss. des_ifs.
    - steps. admit "lemmas for imp...".
    - unfold ccall. steps.
      admit "lemmas for imp...".
  Qed.

End SIMMODSEM.
