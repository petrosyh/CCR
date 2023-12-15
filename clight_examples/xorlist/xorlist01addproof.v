Require Import Coqlib.
Require Import Any.
Require Import STS.
Require Import Behavior.
Require Import ModSem.
Require Import Skeleton.
Require Import SimModSem.
Require Import PCM.
Require Import HoareDef.
Require Import STB.
Require Import HTactics ProofMode.
Require Import HSim IProofMode.
Require Import ClightDmExprgen ClightDmgen.
Require Import ClightDmMem1.
Require Import CIProofMode.
Require Import xorlist.
Require Import xorlist0.
Require Import xorlist1.
Require Import PtrofsArith.
From Coq Require Import Program.
From compcert Require Import Clightdefs.

Section LEMMA.

  Lemma f_bind_ret_r E R A (s : A -> itree E R)
    : (fun a => ` x : R <- (s a);; Ret x) = s.
  Proof. apply func_ext. i. apply bind_ret_r. Qed.

  Lemma decode_encode_ofs i : decode_val Mint64 (encode_val Mint64 (Vptrofs i)) = Vptrofs i.
  Proof.
    pose proof (decode_encode_val_general (Vptrofs i) Mint64 Mint64).
    unfold Vptrofs in *. des_ifs.
  Qed.

  Lemma decode_encode_null : decode_val Mint64 (encode_val Mint64 Vnullptr) = Vnullptr.
  Proof.
    rewrite (decode_encode_val_general Vnullptr Mint64 Mint64). et.
  Qed.

  Lemma null_zero i : Vptrofs i = Vnullptr -> i = Ptrofs.zero.
  Proof.
    unfold Vptrofs, Vnullptr. des_ifs. i. inv H. 
    rewrite <- (Ptrofs.of_int64_to_int64 Heq i).
    rewrite <- (Ptrofs.of_int64_to_int64 Heq Ptrofs.zero).
    f_equal. des_ifs. change (Ptrofs.to_int64 Ptrofs.zero) with Int64.zero.
    rewrite Heq1. f_equal. apply proof_irrel.
  Qed.

  Context `{eventE -< eff}.

  Lemma cast_ptrofs i : cast_to_ptr (Vptrofs i) = Ret (Vptrofs i).
  Proof. des_ifs. Qed.

  Lemma cast_long i : Archi.ptr64 = true -> cast_to_ptr (Vlong i) = Ret (Vlong i).
  Proof. ss. Qed.

End LEMMA.

Section PROOF.

  Context `{@GRA.inG pointstoRA Σ}.
  Context `{@GRA.inG allocatedRA Σ}.
  Context `{@GRA.inG blocksizeRA Σ}.
  Context `{@GRA.inG blockaddressRA Σ}.

  Variable GlobalStb : Sk.sem -> gname -> option fspec.
  Hypothesis STBINCL : forall sk, stb_incl (to_stb xorStb) (GlobalStb sk).
  Hypothesis MEMINCL : forall sk, stb_incl (to_stb MemStb) (GlobalStb sk).


  Definition wf : _ -> Any.t * Any.t -> Prop :=
    @mk_wf
      _
      unit
      (fun _ st_src st_tgt => ⌜True⌝)%I.


  Let ce := map (fun '(id, p) => (string_of_ident id, p)) (Maps.PTree.elements (prog_comp_env prog)).

  Section SIMFUNS.
  Variable sk: Sk.t.
  Hypothesis SKINCL : Sk.extends (xorlist0.xor.(Mod.sk)) sk.
  Hypothesis SKWF : Sk.wf (Sk.canon sk).


  Lemma sim_add_hd :
    sim_fnsem wf top2
      ("add_hd", fun_to_tgt "xorlist" (GlobalStb (Sk.canon sk)) (mk_pure add_hd_spec))
      ("add_hd", cfunU (decomp_func (Sk.canon sk) ce f_add_hd)).
  Proof.
    Opaque encode_val.
    Opaque cast_to_ptr.
    econs; ss. red.

    (* current state: 1 *)
    unfold prog in ce. unfold mkprogram in ce.
    destruct (build_composite_env'). ss.
    get_composite ce e.

    dup SKINCL. rename SKINCL0 into SKINCLENV.
    apply Sk.incl_incl_env in SKINCLENV.
    unfold Sk.incl_env in SKINCLENV.
    pose proof Sk.sk_incl_gd as SKINCLGD.

    apply isim_fun_to_tgt; auto.
    unfold f_add_hd. i; ss.
    unfold decomp_func, function_entry_c. ss.
    let H := fresh "HIDDEN" in
    set (H := hide 1).

    iIntros "[INV PRE]". des_ifs_safe. ss.
    iDestruct "PRE" as "[[% PRE] %]".
    des. clarify. hred_r. 
    rename v into hd_hdl, v0 into tl_hdl, l into lfull, i into item.

    (* node* entry = (node* ) malloc(sizeof(node)) start *)
    unhide. hred_r. unhide. remove_tau. unhide. remove_tau.

    hexploit SKINCLENV.
    { instantiate (2:="malloc"). ss. }
    i. des. ss. rewrite FIND. rename FIND into malloc_loc.
    hred_r. des_ifs_safe.
    rewrite cast_ptrofs.
    rename Heq1 into ptr64. rename Heq0 into get_co.
    clear Heq e. hred_r.

    replace (pred _) with blk by nia.
    erewrite SKINCLGD; et.
    hred_r. ss.
    iApply isim_apc. iExists (Some (20%nat : Ord.t)).
    rewrite co_co_sizeof.

    iApply isim_ccallU_malloc; ss; oauto.
    iSplitL "INV"; iFrame.
    { iPureIntro. ss. }
    iIntros (st_src0 st_tgt0 p_new m_new) "[INV [[% new_point] new_ofs]]".
    set (Z.to_nat _) as si. vm_compute in si. unfold si. clear si.
    rename H3 into m_new_size.

    hred_r. unhide. remove_tau. 
    iPoseProof ((@offset_cast_ptr _ _ _ _ Es) with "new_ofs") as "%".
    rewrite H3. rename H3 into new_cast_ptr.
    (* node* entry = (node* ) malloc(sizeof(node)) end *)

    hred_r. unhide. remove_tau. unhide. remove_tau.

    unfold full_xorlist.
    iDestruct "PRE" as (m_hd_hdl m_tl_hdl hd tl ofs_hd_hdl ofs_tl_hdl tg_hd_hdl tg_tl_hdl)
      "[[[[[[hd_hdl_point hd_hdl_ofs] %] tl_hdl_point] tl_hdl_ofs] %] LIST]".
    rename H3 into hd_hdl_align.
    rename H4 into tl_hdl_align.

    (* node* hd = *hd_handler start *)
    iPoseProof (points_to_is_ptr with "hd_hdl_point") as "%".
    rewrite H3. rename H3 into hd_hdl_ptr. hred_r.

    iApply isim_ccallU_load; ss; oauto.
    iSplitL "INV hd_hdl_point hd_hdl_ofs"; iFrame.
    { rewrite encode_val_length. et. }
    iIntros (st_src1 st_tgt1) "[INV [hd_hdl_point hd_hdl_ofs]]".
    unfold Mptr. rewrite ptr64.
    iPoseProof (xorlist_hd_ptr with "LIST") as "%". rewrite H3. rename H3 into hd_deen.
    (* node* hd = *hd_handler end *)

    hred_r. unhide. remove_tau. unhide. remove_tau.

    (* node* tl = *tl_handler start *)
    iPoseProof (points_to_is_ptr with "tl_hdl_point") as "%".
    rewrite H3. rename H3 into tl_hdl_is_point. hred_r.

    iApply isim_ccallU_load; ss; oauto.
    iSplitL "INV tl_hdl_point tl_hdl_ofs"; iFrame.
    { rewrite encode_val_length. et. }
    iIntros (st_src2 st_tgt2) "[INV [tl_hdl_point tl_hdl_ofs]]".
    unfold Mptr. rewrite ptr64. 
    iPoseProof (xorlist_tl_ptr with "LIST") as "%". rewrite H3. rename H3 into tl_deen.
    (* node* tl = *tl_handler end *)

    hred_r. unhide. remove_tau. unhide. remove_tau.

    (* entry->item = item start *)
    iPoseProof (points_to_is_ptr with "new_point") as "%".
    rewrite H3. rename H3 into new_is_point. hred_r. rewrite new_is_point. hred_r.

    rewrite co_co_members. ss. hred_r.
    replace (Coqlib.align 0 _) with 0%Z by et.
    replace (Ptrofs.repr 0) with Ptrofs.zero by et.
    iPoseProof (add_null_r with "new_ofs") as "%".
    rewrite H3. rename H3 into new_add_r. rewrite cast_long; et. hred_r.

    replace (points_to _ _ _ _) with (points_to p_new m_new (repeat Undef 8 ++ repeat Undef 8) 1) by reflexivity.
    iPoseProof (points_to_split with "new_point") as "[new_point_item new_point_key]".

    iApply isim_ccallU_store; ss; oauto.
    iSplitL "INV new_point_item new_ofs"; iFrame.
    { iExists _. iFrame. ss. iPureIntro. split; et. exists 0. ss. }
    iIntros (st_src3 st_tgt3) "[INV [new_point_item new_ofs]]".
    (* entry->item = item end *)

    hred_r. unhide. remove_tau.
    (* if (hd == NULL) start *)
    replace (Vlong (Int64.repr _)) with Vnullptr by et.

    destruct lfull.
    (* case: nil list *)
    { 
      (* admit "solved". *)
      ss.
      iDestruct "LIST" as "[NULL_tl NULL_hd]".
      iPoseProof (equiv_sym with "NULL_hd") as "NULL_hd". iPoseProof (null_equiv with "NULL_hd") as "%". subst.

      iApply isim_ccallU_cmp_ptr0; ss; oauto.
      iSplitL "INV"; iFrame.
      iIntros (st_src4 st_tgt4) "INV".
      (* if (hd == NULL) end *)

      hred_r. des_ifs_safe. clear Heq.
      unhide. hred_r. unhide. remove_tau.

      (* entry->link = 0 start *)
      rewrite new_is_point. hred_r. rewrite new_is_point. hred_r.

      rewrite co_co_members. ss. hred_r.
      replace (Coqlib.align _ _) with 8%Z by et.
      replace (Vlong (Int64.repr _)) with Vnullptr by et.
      iApply isim_ccallU_store; ss; oauto.
      iSplitL "INV new_point_key new_ofs"; iFrame.
      { iExists _. iFrame. iSplit; cycle 1.  { iApply offset_slide. et. } { iPureIntro. split; ss. exists 1. ss. } }
      iIntros (st_src5 st_tgt5) "[INV [new_point_key new_ofs]]".
      (* entry->link = 0 end *)

      hred_r. unhide. remove_tau. unhide. hred_r. unhide. remove_tau. unhide. remove_tau.

      (* hd_handler = *tl_handler = entry start *)
      rewrite new_cast_ptr. hred_r. unhide. remove_tau.
      rewrite tl_hdl_is_point. hred_r. rewrite new_cast_ptr. hred_r.

      iApply isim_ccallU_store; ss; oauto.
      iSplitL "INV tl_hdl_point tl_hdl_ofs"; iFrame.
      { iExists _. iFrame. rewrite encode_val_length. iPureIntro. ss. }
      iIntros (st_src7 st_tgt7) "[INV [tl_hdl_point tl_hdl_ofs]]".

      hred_r. unhide. remove_tau. rewrite hd_hdl_ptr. hred_r.
      rewrite new_cast_ptr. hred_r.

      iApply isim_ccallU_store; ss; oauto.
      iSplitL "INV hd_hdl_point hd_hdl_ofs"; iFrame.
      { iExists _. iFrame. rewrite encode_val_length. iPureIntro. ss. }
      iIntros (st_src8 st_tgt8) "[INV [hd_hdl_point hd_hdl_ofs]]".

      hred_r. remove_tau. hred_l. iApply isim_choose_src.
      iExists _. iApply isim_ret. iFrame. iSplit; ss. iSplit; ss.
      iCombine "new_point_item new_point_key" as "new_point".
      iPoseProof (points_to_collect with "new_point") as "new_point".

      iExists _,_,_,_,_,_,_,_. iFrame.
      iSplit; ss.
      iPoseProof (offset_slide_rev with "new_ofs") as "new_ofs".
      change Vnullptr with (Vptrofs Ptrofs.zero) at 3 4.
      iPoseProof (equiv_refl_offset with "new_ofs") as "[new_ofs new_equiv]".
      iPoseProof (equiv_dup with "NULL_hd") as "[? ?]".
      iExists _,_,_. iFrame. rewrite Ptrofs.xor_zero_l. iFrame.
      iSplit; ss.
    }
    ss. destruct v; clarify.
    iDestruct "LIST" as (i_prev i_next m_hd) "[[[[% prev_addr] hd_ofs] hd_point] LIST]".
    rename H3 into m_hd_size.

    iApply isim_ccallU_cmp_ptr3; ss; oauto.
    iSplitL "INV hd_ofs".
    { iFrame. iPureIntro. red. rewrite m_hd_size. ss. }
    iIntros (st_src4 st_tgt4) "[INV hd_ofs]".
    (* if (hd == NULL) end *)

    hred_r. des_ifs_safe. clear Heq. unhide. hred_r. unhide. remove_tau. unhide. remove_tau.

    (* entry->link = (intptr_t)hd start *)
    iPoseProof ((@offset_cast_ptr _ _ _ _ Es) with "hd_ofs") as "%".
    rewrite H3. hred_r. rename H3 into hd_cast_ptr.

    iApply isim_ccallU_capture2; ss; oauto.
    iSplitL "INV hd_ofs"; iFrame.
    iIntros (st_src5 st_tgt5 i_hd) "[INV [hd_ofs hd_addr]]".

    hred_r. unhide. remove_tau.

    rewrite new_is_point. hred_r.
    rewrite new_is_point. hred_r.
    rewrite co_co_members. ss. hred_r.
    rewrite cast_ptrofs. hred_r.
    replace (Coqlib.align _ _) with 8%Z by et.

    iApply isim_ccallU_store; ss; oauto.
    iSplitL "INV new_point_key new_ofs"; iFrame.
    { iExists _. iFrame. iSplit; cycle 1.
      { iApply offset_slide. ss. }
      { iPureIntro. split; ss. exists 1. ss. } }
    iIntros (st_src6 st_tgt6) "[INV [new_point_key new_ofs]]".
    (* entry->link = (intptr_t)hd end *)

    hred_r. unhide. remove_tau. unhide. hred_r. unhide. remove_tau.

    (* hd->link = hd->link ^ (intptr_t)entry start *)
    rewrite new_cast_ptr. hred_r.
    iApply isim_ccallU_capture2; ss; oauto.
    iSplitL "INV new_ofs"; iFrame.
    { iApply offset_slide_rev. et. }
    iIntros (st_src7 st_tgt7 i_new) "[INV [new_ofs new_addr]]".

    hred_r. unhide. remove_tau.

    iPoseProof (points_to_is_ptr with "hd_point") as "%".
    rewrite H3. rename H3 into hd_ptr.
    hred_r. rewrite hd_ptr. hred_r.
    rewrite co_co_members. ss. hred_r.
    replace (Coqlib.align _ _) with 8%Z by et.

    rewrite hd_ptr. hred_r. rewrite hd_ptr. hred_r.
    rewrite co_co_members. ss. hred_r.
    replace (Coqlib.align _ _) with 8%Z by et.

    iPoseProof (points_to_split with "hd_point") as "[hd_point_item hd_point_key]".
    iApply isim_ccallU_load; ss; oauto.
    iSplitL "INV hd_point_key hd_ofs".
    { iFrame. iSplit.
      { iApply offset_slide. ss. }
      { iPureIntro. split; ss. exists 1. ss. } }
    iIntros (st_src8 st_tgt8) "[INV [hd_point_key hd_ofs]]".

    unfold Mptr. rewrite ptr64.
    rewrite decode_encode_ofs. hred_r.
    rewrite cast_ptrofs.
    rewrite cast_ptrofs. hred_r.
    des_ifs_safe.

    hred_r. rewrite cast_long; et. hred_r.
    iApply isim_ccallU_store; ss; oauto.
    iSplitL "INV hd_point_key hd_ofs".
    { iFrame. iExists _. iFrame.
      iPureIntro. split; ss. exists 1. ss. }
    iIntros (st_src9 st_tgt9) "[INV [hd_point_key hd_ofs]]".
    (* hd->link = hd->link ^ (intptr_t)entry end *)

    hred_r. unhide. remove_tau.

    (* *hd_handler = entry start *)
    rewrite hd_hdl_ptr. hred_r.
    rewrite new_cast_ptr. hred_r.
    iApply isim_ccallU_store; ss; oauto.
    iSplitL "INV hd_hdl_point hd_hdl_ofs".
    { iFrame. iExists _. iFrame. iPureIntro.
      rewrite encode_val_length. ss. }
    iIntros (st_src10 st_tgt10) "[INV [hd_hdl_point hd_hdl_ofs]]".
    (* *hd_handler = entry end *)

    (* prove post condition *)
    hred_r. remove_tau. hred_l. iApply isim_choose_src.
    iExists _. iApply isim_ret.
    iFrame. iSplit; ss. iSplit; ss.
    iCombine "new_point_item new_point_key" as "new_point".
    iCombine "hd_point_item hd_point_key" as "hd_point".
    iPoseProof (points_to_collect with "new_point") as "new_point".
    iPoseProof (points_to_collect with "hd_point") as "hd_point".
    iPoseProof (offset_slide_rev with "hd_ofs") as "hd_ofs".
    iPoseProof (null_equiv with "prev_addr") as "%".
    assert (i_prev = Ptrofs.zero).
    { unfold Vptrofs, Vnullptr in *. des_ifs. replace intrange with intrange0 in * by apply proof_irrel. rewrite <- Heq0 in Heq. apply (f_equal Ptrofs.of_int64) in Heq. rewrite Ptrofs.of_int64_to_int64 in Heq; et. }
    clear H3. clarify.

    iExists _,_,_,_,_,_,_,_. iFrame. iSplit; ss.
    iExists _,_,_. iFrame. rewrite Ptrofs.xor_zero_l. iFrame. iSplit; ss.
    rewrite <- Heq0.
    
    iPoseProof (equiv_dup with "hd_addr") as "[hd_addr hd_addr']".
    iCombine "hd_addr' hd_point" as "hd_point".
    iPoseProof (equiv_point_comm with "hd_point") as "hd_point".
    iPoseProof (equiv_dup with "hd_addr") as "[hd_addr hd_addr']".
    iCombine "hd_addr' hd_ofs" as "hd_ofs".
    iPoseProof (equiv_offset_comm with "hd_ofs") as "hd_ofs".
    iPoseProof (equiv_sym with "hd_addr") as "hd_addr".
    iExists _,_,_. iFrame.
    instantiate (1:=i_next).
    replace (Vptrofs (Ptrofs.xor _ _)) with (Vlong (Int64.xor i0 i1)).
    - iFrame. iSplit; ss. admit "".
    - unfold Vptrofs in *. des_ifs. f_equal. 
      rewrite int64_ptrofs_xor_comm. f_equal. rewrite Ptrofs.xor_commut.
      f_equal. rewrite Ptrofs.xor_zero_l. et.
  Qed.

  End SIMFUNS.

End PROOF.