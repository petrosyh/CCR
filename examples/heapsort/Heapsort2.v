Require Import Coqlib.
Require Import ImpPrelude.
Require Import STS.
Require Import Behavior.
Require Import ModSem.
Require Import Skeleton.
Require Import PCM.
Require Import HoareDef.
Require Import ProofMode.
Require Import STB.
Require Import HeapsortHeader.
Require Import Coq.Sorting.Permutation.
Require Import Coq.Sorting.Sorted.

Set Implicit Arguments.

Section HEAPSORT.

  Context `{Σ : GRA.t}.

  Definition create_body : list Z * nat -> itree hEs (list Z) :=
    fun _ => trigger (Choose _).

  Definition create_spec : fspec :=
    mk_simple (X := bintree Z * nat)
              (fun '(tree, i) =>
                 (ord_pure 1,
                  fun varg => ⌜varg = (toList tree, i)↑
                           /\ 1 <= i <= length (toList tree)
                           /\ forall j, j > i -> heap Z.ge (subtree j tree)⌝,
                  fun vret => ∃ tree' : bintree Z, ⌜vret = (toList tree')↑
                                                /\ toList tree ≡ₚ toList tree'
                                                /\ forall j, j >= i -> heap Z.ge (subtree j tree')⌝
                 )
              )%I.
  
  Definition heapify_body : (list Z * Z) -> itree hEs (list Z) :=
    fun _ => trigger (Choose _).

  Definition heapify_spec : fspec :=
    mk_simple (X := bintree Z * Z)
              (fun '(tree, k) =>
                ( ord_pure 1
                , fun varg => ⌜varg = (toList tree, k)↑ /\ heap Z.ge tree⌝
                , fun vret => ∃ tree' : bintree Z, ⌜vret = (toList tree')↑
                                                /\ (k :: tail (toList tree) ≡ₚ toList tree')
                                                /\ heap Z.ge tree'⌝
                )
              )%I.

  Definition heapsort_body : list Z -> itree hEs (list Z) :=
    fun xs =>
      ys <- trigger (Choose (list Z));;
      Ret ys.

  Definition heapsort_spec : fspec :=
    mk_simple (X := list Z)
              (fun xs => (
                   ord_pure 2,
                   (fun varg => ⌜varg = xs↑⌝),
                   (fun vret => ∃ ys : list Z, ⌜vret = ys↑ /\ xs ≡ₚ ys /\ Sorted Z.le ys⌝)
                 )
              )%I.

  Definition HeapsortSbtb : list (gname * fspecbody) :=
    [("create",  mk_specbody create_spec   (cfunN create_body));
    ("heapify",  mk_specbody heapify_spec  (cfunN heapify_body));
    ("heapsort", mk_specbody heapsort_spec (cfunN heapsort_body))
    ].

  Definition HeapsortStb : list (gname * fspec).
    eapply (Seal.sealing "stb").
    let x := constr:(List.map (map_snd (fun fsb => fsb.(fsb_fspec) : fspec)) HeapsortSbtb) in
    let y := eval cbn in x in
    eapply y.
  Defined.

  Definition SHeapsortSem : SModSem.t := {|
    SModSem.fnsems := HeapsortSbtb;
    SModSem.mn := "Heapsort";
    SModSem.initial_mr := ε;
    SModSem.initial_st := tt↑;
  |}.

  Definition SHeapsort : SMod.t := {|
    SMod.get_modsem := fun _ => SHeapsortSem;
    SMod.sk := Sk.unit;
  |}.

  Definition Heapsort stb : Mod.t := (SMod.to_tgt stb) SHeapsort.

End HEAPSORT.
