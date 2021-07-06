Require Import Coqlib.
Require Import ITreelib.
Require Import ImpPrelude.
Require Import STS.
Require Import Behavior.
Require Import ModSem.
Require Import Skeleton.
Require Import PCM.
Require Import Hoare.
Require Import STB KnotHeader SimModSem.
Require Import KnotMainImp KnotMain0 KnotMain1 KnotImp Knot0 Knot1 Mem0 Mem1.
Require Import KnotMainImp0proof KnotImp0proof KnotMain01proof Knot01proof Mem01proof.
Require Import ProofMode.

Require Import HTactics Invariant.

Set Implicit Arguments.




Section PROOF.

  Let Σ: GRA.t := GRA.of_list [invRA; knotRA; memRA].
  Local Existing Instance Σ.

  Let invRA_inG: @GRA.inG invRA Σ.
  Proof.
    exists 0. ss.
  Qed.
  Local Existing Instance invRA_inG.

  Let knotRA_inG: @GRA.inG knotRA Σ.
  Proof.
    exists 1. ss.
  Qed.
  Local Existing Instance knotRA_inG.

  Let memRA_inG: @GRA.inG memRA Σ.
  Proof.
    exists 2. ss.
  Qed.
  Local Existing Instance memRA_inG.

  Let RecStb: Sk.t -> gname -> option fspec :=
    fun sk => to_stb KnotRecStb.
  Hint Unfold RecStb: stb.

  Let FunStb: Sk.t -> gname -> option fspec :=
    fun sk => to_stb (MainFunStb RecStb sk).
  Hint Unfold FunStb: stb.

  Let smds := [SMain RecStb; SKnot RecStb FunStb; SMem].
  Let GlobalStb := fun sk => to_stb (SMod.get_stb smds sk).

  Definition KnotAllImp: list Mod.t := [KnotMainImp.KnotMain; KnotImp.Knot; Mem0.Mem].
  Definition KnotAll0: list Mod.t := [KnotMain0.Main; Knot0.Knot; Mem0.Mem].
  Definition KnotAll1: list Mod.t := List.map (SMod.to_tgt GlobalStb) smds.
  Definition KnotAll2: list Mod.t := List.map SMod.to_src smds.

  Hint Unfold GlobalStb: stb.

  Ltac stb_incl_tac :=
    i; eapply incl_to_stb;
    [ autounfold with stb; autorewrite with stb; ii; ss; des; clarify; auto|
      autounfold with stb; autorewrite with stb; repeat econs; ii; ss; des; ss].

  Ltac ors_tac := repeat ((try by (ss; left; ss)); right).

  Lemma KnotAll01_correct:
    refines2 KnotAll0 KnotAll1.
  Proof.
    cbn. eapply refines2_pairwise. econs; [|econs; [|econs; ss]].
    - eapply adequacy_local2.
      eapply KnotMain01proof.correct with (RecStb0:=RecStb) (FunStb0:=FunStb) (GlobalStb0:=GlobalStb).
      + stb_incl_tac.
      + ii. econs; ss. refl.
      + ii. econs; ss. refl.
    - eapply adequacy_local2.
      eapply Knot01proof.correct with (RecStb0:=RecStb) (FunStb0:=FunStb) (GlobalStb0:=GlobalStb).
      + stb_incl_tac.
      + stb_incl_tac.
      + stb_incl_tac; ors_tac.
    - etrans.
      { eapply adequacy_local2. eapply Mem01proof.correct. }
      { eapply adequacy_local2. eapply Weakening.adequacy_weaken. ss. }
  Qed.

  Lemma KnotAll12_correct:
    refines_closed (Mod.add_list KnotAll1) (Mod.add_list KnotAll2).
  Proof.
    eapply adequacy_type.
    { instantiate (1:=GRA.embed inv_token ⋅ GRA.embed (Auth.white (Some None: Excl.t (option (nat -> nat))): knotRA)).
      unfold SMod.get_initial_mrs. simpl. admit "".
    }
    { i. ss. clarify. ss. exists id. splits; auto.
      { iIntros "[H0 H1]". iFrame. iSplits; ss. }
      { i. iPureIntro. i. des; auto. }
    }
  Qed.

  Theorem Knot_correct:
    refines_closed (Mod.add_list KnotAllImp) (Mod.add_list KnotAll2).
  Proof.
    transitivity (Mod.add_list KnotAll0).
    { eapply refines_close. eapply refines2_pairwise. econs; simpl.
      { eapply adequacy_local2. eapply KnotMainImp0proof.correct. }
      econs; simpl.
      { eapply adequacy_local2. eapply KnotImp0proof.correct. }
      econs; ss.
    }
    etrans.
    { eapply refines_close. eapply KnotAll01_correct. }
    { eapply KnotAll12_correct. }
  Qed.

End PROOF.
