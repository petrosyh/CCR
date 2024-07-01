Require Import CoqlibCCR Any.
Require Import Skeleton.
Require Import ModSem Behavior SimModSem.
Require Import PCM IPM.
Require Import HoareDef STB.

From compcert Require Import Ctypes Floats Integers Values Memory AST Clight Clightdefs IntPtrRel.

Require Import ClightPlusSkel ClightPlusMemRA ClightPlusMem0 ClightPlusMem1 ClightPlusMemAux.

Local Transparent Archi.ptr64.

Section RESINIT.

  Local Open Scope Z.

  Context `{@GRA.inG Mem.t Σ}.

  Lemma valid_point
      sk' sk p a s
      (SUCC: alloc_globals sk' (ε, ε, ε) xH sk = Some (p, a, s)) :
    URA.wf p.
  Proof.
    set ε as p0 in SUCC. set ε as a0 in SUCC. set ε as s0 in SUCC. set xH as b0 in SUCC.
    assert (forall b, (b0 ≤ b)%positive -> p0 b = ε).
    { i. unfold p0. ss. }
    assert (URA.wf p0).
    { ur. i. unfold p0. ur. i. ur. ss. }
    clearbody p0 a0 s0 b0. rename H0 into NEXT, H1 into WFi.
    revert p a s sk' p0 a0 s0 b0 SUCC NEXT WFi.
    induction sk; i; ss; clarify. des_ifs.
    - hexploit IHsk; et. i. apply NEXT. nia.
    - rename Heq0 into REST. hexploit IHsk; et.
      + i. ur. rewrite NEXT; try nia. r_solve. clear -REST H0.
        set 0%Z in REST. set ε in REST. set (gvar_init v) in REST. assert (RES: c0 b = ε) by ss. clearbody z c0 l.
        ginduction l; i; ss; clarify.
        des_ifs. hexploit IHl; et. extensionalities.
        unfold store_init_data in Heq. des_ifs.
        all: do 2 ur; rewrite RES; rewrite points_to_diff_blk; try nia; ur; ss.
      + ur in WFi. ur in WFi. ur. ur. i. destruct (Pos.eq_dec k b0); subst; cycle 1.
        * replace (c k k0) with (ε : Consent.t memval); r_solve; et.
          clear -REST n. set 0%Z in REST. set ε in REST. set (gvar_init v) in REST. assert (RES: c0 k = ε) by ss. clearbody z c0 l.
          ginduction l; i; ss; clarify. { rewrite RES. ss. }
          des_ifs. hexploit IHl; et. extensionalities.
          unfold store_init_data in Heq. des_ifs.
          all: do 2 ur; rewrite RES; rewrite points_to_diff_blk; try nia; ur; ss.
        * rewrite NEXT; try nia. set (_ k0). assert (RES: y = ε) by ss. rewrite RES. r_solve.
          clear -REST. set 0%Z in REST. set ε in REST. set (gvar_init v) in REST.
          assert (RES0: forall i, (z ≤ i)%Z -> c0 b0 i = ε).
          { i. unfold c0. ss. }
          assert (RES1: forall i, (i < z)%Z -> URA.wf (c0 b0 i)).
          { i. unfold c0. ur. ss. }
          clearbody z c0 l.
          ginduction l; i; ss; clarify.
          { destruct (Coqlib.zlt k0 z); unfold Coqlib.Plt in *; [apply RES1|rewrite RES0]; try nia; ur; ss. }
          des_ifs. hexploit IHl; et.
          { i. unfold store_init_data in Heq. des_ifs; ur; ur; ss.
            all: rewrite RES0; [|try nia]; rewrite points_to_outbound; ur; et; try rewrite length_inj_bytes; first [rewrite encode_int_length| rewrite repeat_length|et]; nia. }
          { i. destruct (Coqlib.zle z i).
            { unfold store_init_data in Heq. des_ifs; ur; ur; ss.
              all: rewrite RES0; [|try nia]; r_solve; unfold __points_to; des_ifs. }
            { ur in RES1. unfold store_init_data in Heq. des_ifs; ur; ur; ss.
              all: rewrite points_to_outbound; r_solve; [apply RES1; nia|].
              all: try rewrite length_inj_bytes; first [rewrite encode_int_length| rewrite repeat_length|et]; nia. } }
    - rename Heq0 into REST. hexploit IHsk; et.
      + i. ur. rewrite NEXT; try nia. r_solve. clear -REST H0.
        set 0%Z in REST. set ε in REST. set (gvar_init v) in REST. assert (RES: c0 b = ε) by ss. clearbody z c0 l.
        ginduction l; i; ss; clarify.
        des_ifs. hexploit IHl; et. extensionalities.
        unfold store_init_data in Heq. des_ifs.
        all: do 2 ur; rewrite RES; rewrite points_to_diff_blk; try nia; ur; ss.
      + do 2 ur in WFi. do 2 ur. i. destruct (Pos.eq_dec k b0); subst; cycle 1.
        * replace (c k k0) with (ε : Consent.t memval); r_solve; et.
          clear -REST n. set 0%Z in REST. set ε in REST. set (gvar_init v) in REST. assert (RES: c0 k = ε) by ss. clearbody z c0 l.
          ginduction l; i; ss; clarify. { rewrite RES. ss. }
          des_ifs. hexploit IHl; et. extensionalities.
          unfold store_init_data in Heq. des_ifs.
          all: do 2 ur; rewrite RES; rewrite points_to_diff_blk; try nia; ur; ss.
        * rewrite NEXT; try nia. set (_ k0). assert (RES: y = ε) by ss. rewrite RES. r_solve.
          clear -REST. set 0%Z in REST. set ε in REST. set (gvar_init v) in REST.
          assert (RES0: forall i, (z ≤ i)%Z -> c0 b0 i = ε).
          { i. unfold c0. ss. }
          assert (RES1: forall i, (i < z)%Z -> URA.wf (c0 b0 i)).
          { i. unfold c0. ur. ss. }
          clearbody z c0 l.
          ginduction l; i; ss; clarify.
          { destruct (Coqlib.zlt k0 z); unfold Coqlib.Plt in *; [apply RES1|rewrite RES0]; try nia; ur; ss. }
          des_ifs. hexploit IHl; et.
          { i. unfold store_init_data in Heq. des_ifs; ur; ur; ss.
            all: rewrite RES0; [|try nia]; rewrite points_to_outbound; ur; et; try rewrite length_inj_bytes; first [rewrite encode_int_length| rewrite repeat_length|et]; nia. }
          { i. destruct (Coqlib.zle z i).
            { unfold store_init_data in Heq. des_ifs; ur; ur; ss.
              all: rewrite RES0; [|try nia]; r_solve; unfold __points_to; des_ifs. }
            { ur in RES1. unfold store_init_data in Heq. des_ifs; ur; ur; ss.
              all: rewrite points_to_outbound; r_solve; [apply RES1; nia|].
              all: try rewrite length_inj_bytes; first [rewrite encode_int_length| rewrite repeat_length|et]; nia. } }
    - rename Heq0 into REST. hexploit IHsk; et.
      + i. ur. rewrite NEXT; try nia. r_solve. clear -REST H0.
        set 0%Z in REST. set ε in REST. set (gvar_init v) in REST. assert (RES: c0 b = ε) by ss. clearbody z c0 l.
        ginduction l; i; ss; clarify.
        des_ifs. hexploit IHl; et. extensionalities.
        unfold store_init_data in Heq. des_ifs.
        all: do 2 ur; rewrite RES; rewrite points_to_diff_blk; try nia; ur; ss.
      + do 2 ur in WFi. do 2 ur. i. destruct (Pos.eq_dec k b0); subst; cycle 1.
        * replace (c k k0) with (ε : Consent.t memval); r_solve; et.
          clear -REST n. set 0%Z in REST. set ε in REST. set (gvar_init v) in REST. assert (RES: c0 k = ε) by ss. clearbody z c0 l.
          ginduction l; i; ss; clarify. { rewrite RES. ss. }
          des_ifs. hexploit IHl; et. extensionalities.
          unfold store_init_data in Heq. des_ifs.
          all: do 2 ur; rewrite RES; rewrite points_to_diff_blk; try nia; ur; ss.
        * rewrite NEXT; try nia. set (_ k0). assert (RES: y = ε) by ss. rewrite RES. r_solve.
          clear -REST. set 0%Z in REST. set ε in REST. set (gvar_init v) in REST.
          assert (RES0: forall i, (z ≤ i)%Z -> c0 b0 i = ε).
          { i. unfold c0. ss. }
          assert (RES1: forall i, (i < z)%Z -> URA.wf (c0 b0 i)).
          { i. unfold c0. ur. ss. }
          clearbody z c0 l.
          ginduction l; i; ss; clarify.
          { destruct (Coqlib.zlt k0 z); unfold Coqlib.Plt in *; [apply RES1|rewrite RES0]; try nia; ur; ss. }
          des_ifs. hexploit IHl; et.
          { i. unfold store_init_data in Heq. des_ifs; ur; ur; ss.
            all: rewrite RES0; [|try nia]; rewrite points_to_outbound; ur; et; try rewrite length_inj_bytes; first [rewrite encode_int_length| rewrite repeat_length|et]; nia. }
          { i. destruct (Coqlib.zle z i).
            { unfold store_init_data in Heq. des_ifs; ur; ur; ss.
              all: rewrite RES0; [|try nia]; r_solve; unfold __points_to; des_ifs. }
            { ur in RES1. unfold store_init_data in Heq. des_ifs; ur; ur; ss.
              all: rewrite points_to_outbound; r_solve; [apply RES1; nia|].
              all: try rewrite length_inj_bytes; first [rewrite encode_int_length| rewrite repeat_length|et]; nia. } }
    - rename Heq0 into REST. hexploit IHsk; et.
      + i. ur. rewrite NEXT; try nia. r_solve. clear -REST H0.
        set 0%Z in REST. set ε in REST. set (gvar_init v) in REST. assert (RES: c0 b = ε) by ss. clearbody z c0 l.
        ginduction l; i; ss; clarify.
        des_ifs. hexploit IHl; et. extensionalities.
        unfold store_init_data in Heq. des_ifs; rewrite RES; et.
      + do 2 ur in WFi. do 2 ur. i. destruct (Pos.eq_dec k b0); subst; cycle 1.
        * replace (c k k0) with (ε : Consent.t memval); r_solve; et.
          clear -REST n. set 0%Z in REST. set ε in REST. set (gvar_init v) in REST. assert (RES: c0 k = ε) by ss. clearbody z c0 l.
          ginduction l; i; ss; clarify. { rewrite RES. ss. }
          des_ifs. hexploit IHl; et. extensionalities.
          unfold store_init_data in Heq. des_ifs; rewrite RES; et.
        * rewrite NEXT; try nia. set (_ k0). assert (RES: y = ε) by ss. rewrite RES. r_solve.
          clear -REST. set 0%Z in REST. set ε in REST. set (gvar_init v) in REST.
          assert (RES0: forall i, (z ≤ i)%Z -> c0 b0 i = ε).
          { i. unfold c0. ss. }
          assert (RES1: forall i, (i < z)%Z -> URA.wf (c0 b0 i)).
          { i. unfold c0. ur. ss. }
          clearbody z c0 l.
          ginduction l; i; ss; clarify.
          { destruct (Coqlib.zlt k0 z); unfold Coqlib.Plt in *; [apply RES1|rewrite RES0]; try nia; ur; ss. }
          des_ifs. hexploit IHl; et.
          { i. unfold store_init_data in Heq. des_ifs; ur; ur; ss.
            all: rewrite RES0; et; nia. }
          { i. destruct (Coqlib.zle z i).
            { unfold store_init_data in Heq. des_ifs; ur; ur; ss.
              all: rewrite RES0; et; r_solve. }
            { ur in RES1. unfold store_init_data in Heq. des_ifs; ur; ur; ss.
              all: apply RES1; nia. } }
  Qed.

  Lemma valid_alloc sk' sk p a s
    (SUCC: alloc_globals sk' (ε, ε, ε) xH sk = Some (p, a, s))
    : URA.wf a.
  Proof.
    set ε as p0 in SUCC. set ε as a0 in SUCC. set ε as s0 in SUCC. set xH as b0 in SUCC.
    assert (forall b, (b0 ≤ b)%positive -> a0 b = ε). { i. unfold a0. ss. }
    assert (URA.wf a0). { ur. i. unfold a0. ur. ss. }
    clearbody p0 a0 s0 b0. rename H0 into RES. rename H1 into WFi.
    revert p a s sk' p0 a0 s0 b0 SUCC RES WFi.
    induction sk; i; ss; clarify. des_ifs.
    - hexploit IHsk; et.
      + i. ur. rewrite RES; try nia. r_solve. unfold __allocated_with. des_ifs. nia.
      + ur in WFi. ur. i. destruct (Pos.eq_dec k b0); subst; cycle 1.
        * rewrite allocated_with_diff_blk; et. r_solve. et.
        * rewrite RES; try nia. unfold __allocated_with. des_ifs. r_solve. ur. ss.
    - hexploit IHsk; et.
      + i. ur. rewrite RES; try nia. r_solve. unfold __allocated_with. des_ifs. nia.
      + ur in WFi. ur. i. destruct (Pos.eq_dec k b0); subst; cycle 1.
        * rewrite allocated_with_diff_blk; et. r_solve. et.
        * rewrite RES; try nia. unfold __allocated_with. des_ifs. r_solve. ur. ss.
    - hexploit IHsk; et.
      + i. ur. rewrite RES; try nia. r_solve. unfold __allocated_with. des_ifs. nia.
      + ur in WFi. ur. i. destruct (Pos.eq_dec k b0); subst; cycle 1.
        * rewrite allocated_with_diff_blk; et. r_solve. et.
        * rewrite RES; try nia. unfold __allocated_with. des_ifs. r_solve. ur. ss.
    - hexploit IHsk; et.
      + i. ur. rewrite RES; try nia. r_solve. unfold __allocated_with. des_ifs. nia.
      + ur in WFi. ur. i. destruct (Pos.eq_dec k b0); subst; cycle 1.
        * rewrite allocated_with_diff_blk; et. r_solve. et.
        * rewrite RES; try nia. unfold __allocated_with. des_ifs. r_solve. ur. ss.
    - hexploit IHsk; et.
      + i. ur. rewrite RES; try nia. r_solve. unfold __allocated_with. des_ifs. nia.
      + ur in WFi. ur. i. destruct (Pos.eq_dec k b0); subst; cycle 1.
        * rewrite allocated_with_diff_blk; et. r_solve. et.
        * rewrite RES; try nia. unfold __allocated_with. des_ifs. r_solve. ur. ss.
  Qed.

  Lemma valid_size sk' sk p a s
    (SUCC: alloc_globals sk' (ε, ε, ε) xH sk = Some (p, a, s))
    : URA.wf (s ⋅ (fun k => match k with
                            | Some b => if Coqlib.plt b (Pos.of_succ_nat (List.length sk)) then OneShot.unit else OneShot.black
                            | None => OneShot.white 0%Z
                            end)).
  Proof.
    set ε as p0 in SUCC. set ε as a0 in SUCC. set ε as s0 in SUCC. set xH as b0 in SUCC.
    assert (s0 None = ε) by ss.
    replace (Pos.of_succ_nat (strings.length sk)) with (Pos.of_nat (Pos.to_nat b0 + (strings.length sk))) by nia.
    assert (forall b, (b0 ≤ b)%positive -> s0 (Some b) = ε). { i. unfold s0. ss. }
    assert (forall b, (b < b0)%positive -> URA.wf (s0 (Some b))). { i. unfold s0. ur. ss. }
    clearbody p0 a0 s0 b0. rename H0 into UNIT, H1 into RES, H2 into WFi.
    revert p a s sk' p0 a0 s0 b0 SUCC UNIT RES WFi.
    induction sk; i; ss; clarify.
    - ur. i. des_ifs.
      { unfold Coqlib.Plt in p0. hexploit (WFi b); try nia. ur. des_ifs. }
      { unfold Coqlib.Plt in n. hexploit (RES b); try nia. i. unfold Values.block. ur. des_ifs. }
      { unfold Values.block in *. ur. des_ifs. }
    - des_ifs.
      + hexploit IHsk; et.
        * do 2 ur. des_ifs.
        * i. ur. rewrite RES; try nia. r_solve. des_ifs. nia.
        * i. ur. des_ifs. { rewrite RES; try nia. r_solve. et. } hexploit (WFi b); try nia. ur. des_ifs.
        * do 2 set (Pos.of_nat _). replace p1 with p2; et. nia.
      + hexploit IHsk; et.
        * do 2 ur. des_ifs.
        * i. ur. rewrite RES; try nia. r_solve. des_ifs. nia.
        * i. ur. des_ifs. { rewrite RES; try nia. r_solve. et. } hexploit (WFi b); try nia. ur. des_ifs.
        * do 2 set (Pos.of_nat _). replace p1 with p2; et. nia.
      + hexploit IHsk; et.
        * do 2 ur. des_ifs.
        * i. ur. rewrite RES; try nia. r_solve. des_ifs. nia.
        * i. ur. des_ifs. { rewrite RES; try nia. r_solve. et. } hexploit (WFi b); try nia. ur. des_ifs.
        * do 2 set (Pos.of_nat _). replace p1 with p2; et. nia.
      + hexploit IHsk; et.
        * do 2 ur. des_ifs.
        * i. ur. rewrite RES; try nia. r_solve. des_ifs. nia.
        * i. ur. des_ifs. { rewrite RES; try nia. r_solve. et. } hexploit (WFi b); try nia. ur. des_ifs.
        * do 2 set (Pos.of_nat _). replace p1 with p2; et. nia.
      + hexploit IHsk; et.
        * do 2 ur. des_ifs.
        * i. ur. rewrite RES; try nia. r_solve. des_ifs. nia.
        * i. ur. des_ifs. { rewrite RES; try nia. r_solve. et. } hexploit (WFi b); try nia. ur. des_ifs.
        * do 2 set (Pos.of_nat _). replace p1 with p2; et. nia.
  Qed.

End RESINIT.

Section STATE_INTERP.

  Local Open Scope Z.

  Context `{@GRA.inG Mem.t Σ}.

  Definition Q1 : Qp := 1%Qp.

  (* permission sim for points to *)
  Inductive sim_cnt
  : URA.car (t:=(Consent.t _)) -> (perm_kind -> option permission) -> memval ->  Prop :=
  | sim_cnt_readable (res: Consent.t _) q mv perm p
      (RES: res = Consent.just q mv)
      (Qwf: (q ≤ Q1)%Qp)
      (PERM: perm Cur = Some p)
      (Qread: perm_order p Readable)
      (Qwrite: q = Q1 -> perm_order p Writable)
    : sim_cnt res perm mv
  | sim_empty perm mv
    : sim_cnt ε perm mv
  .

  (* permission sim for allocated with, block size *)
  Inductive sim_allocated
  : URA.car (t:=(Consent.t tag)) -> URA.car (t:=(OneShot.t Z)) -> (Z -> perm_kind -> option permission) -> Maps.ZMap.t memval -> Prop :=
  | sim_allocated_nonempty (res: Consent.t _) (sres: OneShot.t _) perm cnt q tag sz init minp
      (RES: res = Consent.just q tag)
      (SRES: sres = OneShot.white sz)
      (DYNAMIC: tag = Dynamic -> Mem.getN (size_chunk_nat Mptr) (- size_chunk Mptr) cnt = inj_bytes (encode_int (size_chunk_nat Mptr) sz) /\ init = - size_chunk Mptr)
      (COMMON: tag <> Dynamic -> init = 0)
      (Qwf: (q ≤ Q1)%Qp)
      (Qnonempty: (q < Q1)%Qp -> minp = Nonempty)
      (Qfree: q = Q1 -> minp = Freeable)
      (PERMinrange: forall ofs, init <= ofs < sz -> exists p, perm ofs Cur = Some p /\ perm_order p minp)
      (PERMoutrange: forall ofs, ~ (init <= ofs < sz) -> perm ofs Cur = None)
    : sim_allocated res sres perm cnt
  | sim_allocated_empty sres perm cnt : sim_allocated ε sres perm cnt
  .

  (* block underlying concrete address sim *)
  Inductive sim_concrete
  : URA.car (t:=(OneShot.t ptrofs)) -> option Z -> Prop :=
  | sim_captured cres base
      (RES: cres = OneShot.white base):
    sim_concrete cres (Some (Ptrofs.unsigned base))
  | sim_logical cres
      (RES: cres = OneShot.black):
    sim_concrete cres None
  .

  Inductive sim_mem : Mem.t -> mem -> Prop :=
  | sim_mem_intro mem_tgt
        (memcnt_src: ClightPlusMemRA.__pointstoRA)
        (memalloc_src: ClightPlusMemRA.__allocatedRA)
        (memsz_src: ClightPlusMemRA._blocksizeRA)
        (memconc_src: ClightPlusMemRA._blockaddressRA)
        (SIM_CNT: forall b ofs (POSOFS: 0 ≤ ofs),
                    sim_cnt (memcnt_src b ofs)
                      ((Maps.PMap.get b mem_tgt.(Mem.mem_access)) ofs)
                      (Maps.ZMap.get ofs (Maps.PMap.get b mem_tgt.(Mem.mem_contents))))
        (SIM_CONC: forall ob,
                      match ob with
                      | Some b => sim_concrete (memconc_src (Some b)) (Maps.PTree.get b mem_tgt.(Mem.mem_concrete))
                      | None => memconc_src None = OneShot.white Ptrofs.zero
                      end)
        (SIM_ALLOC: forall ob,
                      match ob with
                      | Some b => sim_allocated (memalloc_src b) (memsz_src (Some b))
                                    (Maps.PMap.get b mem_tgt.(Mem.mem_access))
                                    (Maps.PMap.get b mem_tgt.(Mem.mem_contents))
                                  /\ ((mem_tgt.(Mem.nextblock) ≤ b)%positive -> memsz_src (Some b) = OneShot.black)
                                  /\ (memsz_src (Some b) <> OneShot.unit)
                      | None => memsz_src None = OneShot.white 0
                      end)
        (SIM_CA: forall b ofs q mv sz (RANGE: 0 <= ofs < sz) (PRES: memcnt_src b ofs = Consent.just q mv) (SRES: memsz_src (Some b) = OneShot.white sz),
                  exists q2 tg, memalloc_src b = Consent.just q2 tg) :
      sim_mem (Auth.black memcnt_src, Auth.black memalloc_src, memsz_src, memconc_src) mem_tgt
  .

End STATE_INTERP.

Section INITSIM.

  Local Open Scope Z.

  Context `{@GRA.inG Mem.t Σ}.

  Local Ltac case_points_to := unfold __points_to; destruct (AList.dec _ _); destruct (Coqlib.zle _ _); destruct (Coqlib.zlt).

  Local Hint Constructors sim_cnt: core.
  Local Hint Constructors sim_allocated: core.
  Local Hint Constructors sim_concrete: core.

  Local Transparent Mem.alloc Mem.store Mem.loadbytes Mem.storebytes.
  Local Opaque encode_val.

  Lemma store_init_data_access
      sk mem b i a m
      (MM: ClightPlusMem0.store_init_data sk mem b i a = Some m) :
    Mem.mem_access mem = Mem.mem_access m.
  Proof. unfold ClightPlusMem0.store_init_data, Mem.store in MM. des_ifs. Qed.

  Lemma store_iff
      l sk mem b i res oq
      (VALID: Mem.range_perm mem b i (i + init_data_list_size l) Cur Freeable) :
    ClightPlusMem0.store_init_data_list sk mem b i l = None <-> store_init_data_list sk res b i oq l = None.
  Proof.
    revert_until l. induction l; split; ss; et.
    - i. des_ifs.
      + eapply IHl; et. ii. red in VALID. unfold Mem.perm in *. hexploit store_init_data_access; et. intro EQ.
        rewrite <- EQ. apply VALID. unfold init_data_size in *. des_ifs; nia.
      + exfalso. unfold store_init_data, ClightPlusMem0.store_init_data, Mem.store in *.
        des_ifs.
        all: try solve [apply n; unfold Mem.valid_access; split; et; eapply Mem.range_perm_implies with (p1:=Freeable); try econs; ii; apply VALID; ss; pose proof (init_data_list_size_pos l); try nia].
        { apply n0. unfold Mem.valid_access; split; et. eapply Mem.range_perm_implies with (p1:=Freeable); try econs. ii; apply VALID; ss. unfold size_chunk in *. des_ifs. pose proof (init_data_list_size_pos l); try nia. }
        { apply n0. unfold Mem.valid_access; split; et. eapply Mem.range_perm_implies with (p1:=Freeable); try econs. ii; apply VALID; ss. unfold size_chunk in *. des_ifs. pose proof (init_data_list_size_pos l); try nia. }
    - i. des_ifs.
      + eapply IHl; et. ii. red in VALID. unfold Mem.perm in *. hexploit store_init_data_access; et. intro X.
        rewrite <- X. apply VALID. unfold init_data_size in *. des_ifs; nia.
      + exfalso. unfold store_init_data, ClightPlusMem0.store_init_data in *.
        des_ifs; unfold Mem.store in *; des_ifs; unfold Mem.valid_access in *; des; clarify.
  Qed.

  Lemma alloc_has_perm
      mem b lo hi m'
      (MA: Mem.alloc mem lo hi = (m', b)) :
    Mem.range_perm m' b lo hi Cur Freeable.
  Proof. unfold Mem.alloc in MA. clarify. unfold Mem.range_perm, Mem.perm. ss. i. rewrite Maps.PMap.gss. destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia. econs. Qed.

  Lemma store_zeros_inv
      m b lo sz
      (PERM: Mem.range_perm m b lo (lo + sz) Cur Freeable) :
    exists m', Globalenvs.store_zeros m b lo sz = Some m' /\ Mem.range_perm m' b lo (lo + sz) Cur Freeable.
  Proof.
    hexploit Globalenvs.Genv.store_zeros_exists. { eapply Mem.range_perm_implies; et. econs. }
    intro EX. des. esplits; et.
    symmetry in EX. apply Globalenvs.R_store_zeros_correct in EX. remember (Some m') as om in EX.
    set (lo + sz) as f in *. assert (R1: lo + sz ≤ f) by nia. clearbody f.
    set lo as i in PERM. change lo with i. assert (R2: i ≤ lo) by nia. clearbody i.
    revert R1 R2 Heqom. induction EX; i; clarify.
    unfold Mem.store in e0. des_ifs. hexploit IHEX; et; try nia.
  Qed.

  Lemma store_dl_inv
      sk m m' b lo l
      (PERM: Mem.range_perm m b lo (lo + (init_data_list_size l)) Cur Freeable)
      (MS: ClightPlusMem0.store_init_data_list sk m b lo l = Some m') :
    Mem.range_perm m' b lo (lo + (init_data_list_size l)) Cur Freeable.
  Proof.
    set (lo + _) as f in *. assert (R1: lo + (init_data_list_size l) ≤ f) by nia. clearbody f.
    set lo as i. change lo with i in PERM. assert (R2: i ≤ lo) by nia. clearbody i.
    revert m m' lo MS PERM R1 R2. induction l; ss; i; clarify.
    des_ifs. eapply IHl; et; try nia.
    { unfold ClightPlusMem0.store_init_data, Mem.store in *. des_ifs. }
    { unfold init_data_size in *. des_ifs; nia. }
  Qed.

  Lemma alloc_gl_iff
      sk mem g res :
    ClightPlusMem0.alloc_global sk mem g = None <-> alloc_global sk res (Mem.nextblock mem) g = None.
  Proof.
    unfold alloc_global, ClightPlusMem0.alloc_global in *. destruct g.
    - des_ifs. split; i; clarify.
      unfold Mem.alloc, Mem.drop_perm in *.
      ss. destruct Mem.range_perm_dec; clarify.
      exfalso. apply n. unfold Mem.range_perm, Mem.perm.
      i. ss. rewrite Maps.PMap.gss. destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia.
      econs.
    - des_ifs_safe. hexploit alloc_has_perm; et. intro P.
      assert (BL: b = Mem.nextblock mem); clarify. { unfold Mem.alloc in Heq. clarify. }
      rewrite <- (Z.add_0_l (init_data_list_size _)) in P.
      hexploit store_zeros_inv; et. intro EX. des. rewrite EX.
      hexploit store_iff; et. intro IFF.
      destruct (ClightPlusMem0.store_init_data_list sk m' _ 0 (gvar_init v)) eqn:?; cycle 1.
      { rewrite IFF in Heqo. rewrite Heqo. et. }
      destruct (store_init_data_list) eqn:?; cycle 1.
      { destruct IFF as [IFF IFF0]. hexploit IFF0; et. intro contra. clarify. }
      split; i; clarify.
      exfalso. hexploit store_dl_inv; et. intro P0.
      unfold Mem.drop_perm in *. des_ifs.
  Qed.

  Lemma alloc_gl_nextblock
      sk mem g m'
      (AL: ClightPlusMem0.alloc_global sk mem g = Some m') :
    Mem.nextblock m' = Pos.succ (Mem.nextblock mem).
  Proof.
    unfold ClightPlusMem0.alloc_global, Mem.alloc, Mem.drop_perm in *.
    des_ifs. ss. apply Globalenvs.Genv.store_zeros_nextblock in Heq.
    ss. rewrite <- Heq. clear -Heq0. rename Heq0 into MSL.
    set 0 as i in MSL. set (gvar_init v) as l in MSL.
    clearbody i l. revert m i MSL. induction l; i; ss; clarify.
    des_ifs. hexploit IHl; et. intro EQ. rewrite EQ.
    unfold ClightPlusMem0.store_init_data, Mem.store in Heq. des_ifs.
  Qed.

  Lemma alloc_gl_concrete
      sk mem g m'
      (AL: ClightPlusMem0.alloc_global sk mem g = Some m') :
    Mem.mem_concrete m' = Mem.mem_concrete mem.
  Proof.
    unfold ClightPlusMem0.alloc_global, Mem.alloc, Mem.drop_perm in *.
    des_ifs. ss. hexploit concrete_store_zeros; et. ss. intro CEQ. rewrite CEQ.
    ss. clear -Heq0. rename Heq0 into MSL.
    set 0 as i in MSL. set (gvar_init v) as l in MSL.
    clearbody i l. revert m i MSL. induction l; i; ss; clarify.
    des_ifs. hexploit IHl; et. intro CEQ. rewrite CEQ.
    unfold ClightPlusMem0.store_init_data, Mem.store in *. des_ifs.
  Qed.

  Lemma alloc_gl_unmodified
      sk mem v m0 b
      (AL: ClightPlusMem0.alloc_global sk mem (Gvar v) = Some m0)
      (DIF: b <> (Mem.nextblock mem)) :
    Maps.PMap.get b (Mem.mem_access m0) = Maps.PMap.get b (Mem.mem_access mem) /\
    Maps.PMap.get b (Mem.mem_contents m0) = Maps.PMap.get b (Mem.mem_contents mem).
  Proof.
    unfold ClightPlusMem0.alloc_global in AL. des_ifs.
    assert (Maps.PMap.get b (Mem.mem_access mem) = Maps.PMap.get b (Mem.mem_access m) /\
              Maps.PMap.get b (Mem.mem_contents mem) = Maps.PMap.get b (Mem.mem_contents m)).
    { unfold Mem.alloc in Heq. clarify. ss. rewrite !Maps.PMap.gso; et. }
    assert (b0 = Mem.nextblock mem); clarify. { unfold Mem.alloc in *. clarify. }
    assert (Maps.PMap.get b (Mem.mem_access m) = Maps.PMap.get b (Mem.mem_access m1) /\
              Maps.PMap.get b (Mem.mem_contents m) = Maps.PMap.get b (Mem.mem_contents m1)).
    { clear - DIF Heq0. symmetry in Heq0. apply Globalenvs.R_store_zeros_correct in Heq0.
      remember (Some m1) as om in Heq0. remember (Mem.nextblock mem) as b' in Heq0.
      ginduction Heq0; i; clarify.
      hexploit IHHeq0; et. intros [A C]. rewrite <- A. rewrite <- C.
      unfold Mem.store in e0. des_ifs. ss. rewrite !Maps.PMap.gso; et. }
    assert (Maps.PMap.get b (Mem.mem_access m1) = Maps.PMap.get b (Mem.mem_access m2) /\
              Maps.PMap.get b (Mem.mem_contents m1) = Maps.PMap.get b (Mem.mem_contents m2)).
    { clear - DIF Heq1.
      set 0 as i in Heq1. clearbody i.
      revert m1 m2 i Heq1. induction (gvar_init v); i; ss; clarify.
      des_ifs. hexploit IHl; et. intros [A C]. rewrite <- A. rewrite <- C.
      unfold ClightPlusMem0.store_init_data in Heq. unfold Mem.store in Heq.
      des_ifs; ss; rewrite ! Maps.PMap.gso; et. }
    assert (Maps.PMap.get b (Mem.mem_access m2) = Maps.PMap.get b (Mem.mem_access m0) /\
              Maps.PMap.get b (Mem.mem_contents m2) = Maps.PMap.get b (Mem.mem_contents m0)).
    { unfold Mem.drop_perm in AL. des_ifs. ss. rewrite !Maps.PMap.gso; et. }
    des. split; symmetry.
    { repeat (etrans; try eassumption). }
    { repeat (etrans; try eassumption). }
  Qed.

  Lemma alloc_gl_modified_access
      sk mem v m0
      (AL: ClightPlusMem0.alloc_global sk mem (Gvar v) = Some m0) :
    (forall ofs (RAN: 0 ≤ ofs < init_data_list_size (gvar_init v)),
      Maps.PMap.get (Mem.nextblock mem) (Mem.mem_access m0) ofs Cur = Some (Globalenvs.Genv.perm_globvar v))
    /\ (forall ofs (RAN: not (0 ≤ ofs < init_data_list_size (gvar_init v))),
          Maps.PMap.get (Mem.nextblock mem) (Mem.mem_access m0) ofs Cur = None).
  Proof.
    unfold ClightPlusMem0.alloc_global in AL. des_ifs. rename Heq into MA, Heq0 into MSZ, Heq1 into MS, AL into DP.
    assert (b = Mem.nextblock mem); clarify. { unfold Mem.alloc in MA. clarify. }
    assert (S1: (forall ofs (RAN: 0 ≤ ofs < init_data_list_size (gvar_init v)),
                    Maps.PMap.get (Mem.nextblock mem) (Mem.mem_access m) ofs Cur = Some Freeable)
                  /\ forall ofs (RAN: not (0 ≤ ofs < init_data_list_size (gvar_init v))),
                        Maps.PMap.get (Mem.nextblock mem) (Mem.mem_access m) ofs Cur = None).
    { unfold Mem.alloc in MA. clarify. ss. rewrite !Maps.PMap.gss.
      split; i; destruct Coqlib.zlt; destruct Coqlib.zle; ss; try nia. }
    destruct S1 as [S1 R1].
    assert (S2: (forall ofs (RAN: 0 ≤ ofs < init_data_list_size (gvar_init v)),
                  Maps.PMap.get (Mem.nextblock mem) (Mem.mem_access m1) ofs Cur = Some Freeable)
                  /\ forall ofs (RAN: not (0 ≤ ofs < init_data_list_size (gvar_init v))),
                        Maps.PMap.get (Mem.nextblock mem) (Mem.mem_access m1) ofs Cur = None).
    { clear - S1 R1 MSZ. symmetry in MSZ. apply Globalenvs.R_store_zeros_correct in MSZ.
      remember (Some m1) as om in MSZ.
      set 0 as i in MSZ. assert (0 ≤ i) by ss.
      set (_ (_ v)) as n in MSZ. assert (i + n ≤ init_data_list_size (gvar_init v)) by nia.
      clearbody i n. ginduction MSZ; i; clarify. hexploit IHMSZ; et; try nia.
      { i. unfold Mem.store in e0. des_ifs. ss. et. }
      { i. unfold Mem.store in e0. des_ifs. ss. et. } }
    destruct S2 as [S2 R2].
    assert (S3: (forall ofs (RAN: 0 ≤ ofs < init_data_list_size (gvar_init v)),
                    Maps.PMap.get (Mem.nextblock mem) (Mem.mem_access m2) ofs Cur = Some Freeable)
                  /\ forall ofs (RAN: not (0 ≤ ofs < init_data_list_size (gvar_init v))),
                      Maps.PMap.get (Mem.nextblock mem) (Mem.mem_access m2) ofs Cur = None).
    { clear - S2 R2 MS.
      set 0 as i in MS. assert (0 ≤ i) by ss.
      set (_ v) as l in MS. assert (i + (init_data_list_size l) ≤ init_data_list_size (gvar_init v)). { unfold i, l. nia. }
      clearbody i l. ginduction l; i; ss; clarify. des_ifs.
      pose proof (init_data_size_pos a). hexploit IHl; et; try nia.
      { i. unfold ClightPlusMem0.store_init_data, Mem.store in Heq. des_ifs; et. }
      { i. unfold ClightPlusMem0.store_init_data, Mem.store in Heq. des_ifs; et. } }
    destruct S3 as [S3 R3].
    unfold Mem.drop_perm in DP. des_ifs. ss. rewrite Maps.PMap.gss.
    split; i; ss; destruct Coqlib.zlt; destruct Coqlib.zle; ss; try nia; et.
  Qed.

  Definition init_data_to_memval sk idt : option (list memval) :=
    match idt with
    | Init_int8 n => Some (encode_val Mint8unsigned (Vint n))
    | Init_int16 n => Some (encode_val Mint16unsigned (Vint n))
    | Init_int32 n => Some (encode_val Mint32 (Vint n))
    | Init_int64 n => Some (encode_val Mint64 (Vlong n))
    | Init_float32 n => Some (encode_val Mfloat32 (Vsingle n))
    | Init_float64 n => Some (encode_val Mfloat64 (Vfloat n))
    | Init_space z => Some (repeat (Byte Byte.zero) (Z.to_nat z))
    | Init_addrof symb ofs =>
      match SkEnv.id2blk (load_skenv sk) (string_of_ident symb) with
      | Some b' => Some (encode_val Mptr (Vptr (Pos.of_succ_nat b') ofs))
      | None => None
      end
    end.

  Fixpoint option_list_map {A} (l : list (option A)) : option (list A) :=
    match l with
    | [] => Some []
    | Some h :: t =>
      match option_list_map t with
      | Some t' => Some (h :: t')
      | None => None
      end
    | _ => None
    end.

  Definition init_data_list_to_memval_list sk idl : option (list memval) := option_map (@List.concat _) (option_list_map (map (init_data_to_memval sk) idl)).

  Lemma store_init_data_list_nonempty
      sk b i l c1 c2
      (MS: store_init_data_list sk c1 b i None l = Some c2):
    c1 = c2.
  Proof. ginduction l; ss; i; clarify. des_ifs. unfold store_init_data in *. des_ifs; et. Qed.

  Lemma store_init_data_list_diff_blk
      sk b b' i l c1 c2 o
      (DIF: b <> b')
      (MS: store_init_data_list sk c1 b i o l = Some c2):
    forall z, c1 b' z = c2 b' z.
  Proof.
    ginduction l; ss; i; clarify. des_ifs. etrans; cycle 1.
    - eapply IHl; et.
    - unfold store_init_data in *. des_ifs; et; do 2 ur; rewrite points_to_diff_blk; et; r_solve.
  Qed.


  Lemma store_init_data_list_content
      sk b q l c2
      (MS: store_init_data_list sk ε b 0 (Some q) l = Some c2) :
    exists mvl, init_data_list_to_memval_list sk l = Some mvl /\
      forall ofs mv (R: 0 ≤ ofs) (FIND: nth_error mvl (Z.to_nat ofs) = Some mv), c2 b ofs = Consent.just q mv.
  Proof.
    set ε as res in MS. set 0 as i in MS.
    assert (R: 0 ≤ i) by ss. assert (RES: forall ofs, i ≤ ofs -> res b ofs = ε) by ss.
    assert (exists mvl, init_data_list_to_memval_list sk l = Some mvl /\
              (forall ofs (R: 0 ≤ ofs < i), res b ofs = c2 b ofs) /\
                forall ofs mv (R: 0 ≤ ofs) (FIND: nth_error mvl (Z.to_nat ofs) = Some mv), c2 b (i + ofs) = Consent.just q mv); cycle 1.
    { des. esplits; et. }
    clearbody res i. revert c2 res i MS R RES. induction l; i; ss; clarify.
    { unfold init_data_list_to_memval_list. ss. esplits; et. i. destruct (Z.to_nat _) in *; clarify. }
    des_ifs. pose proof (init_data_size_pos a). hexploit IHl; et; try nia.
    { clear - Heq RES. i. unfold store_init_data in Heq. des_ifs.
      all: do 2 ur; ss; rewrite RES; [|nia]; try rewrite URA.unit_id; rewrite points_to_outbound; et.
      all: solve [rewrite encode_val_length in *; ss; nia| rewrite repeat_length; nia]. }
    intros [mvl [BYTE [RES1 RES2]]]. unfold init_data_list_to_memval_list in *.
    destruct (option_list_map _) eqn:? in BYTE; clarify. ss. clarify. rewrite Heqo.
    assert (EX: exists h, init_data_to_memval sk a = Some h).
    { unfold store_init_data in Heq. des_ifs; ss; et. rewrite Heq0. et. }
    des. rewrite EX. ss. esplits; et; i.
    - rewrite <- RES1; try nia. unfold store_init_data in *. des_ifs.
      all: ss; do 2 ur; rewrite points_to_outbound;[rewrite URA.unit_idl; et|].
      all: first [rewrite encode_val_length| rewrite repeat_length]; ss; nia.
    - assert (List.length h = Z.to_nat (init_data_size a)).
      { unfold init_data_to_memval in EX; des_ifs. rewrite repeat_length. ss. nia. }
      destruct (lt_dec (Z.to_nat ofs) (List.length h)); cycle 1.
      + rewrite nth_error_app2 in FIND; try nia.
        replace (Nat.sub _ _) with (Z.to_nat (ofs - init_data_size a)) in FIND by nia.
        hexploit RES2; try apply FIND; try nia. i. etrans; try eassumption. f_equal. nia.
      + rewrite nth_error_app1 in FIND; try nia.
        rewrite <- RES1; try nia. unfold store_init_data in Heq. des_ifs; ss; clarify.
        all: do 2 ur; rewrite RES; [|nia].
        all: rewrite URA.unit_id.
        all: unfold __points_to; destruct Pos.eq_dec; destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia.
        all: unfold Mptr in *; replace (i + ofs - i) with ofs by nia; des_ifs.
        nia.
  Qed.

  Lemma alloc_gl_modified_content
      sk mem v m0 ofs mv mvl
      (AL: ClightPlusMem0.alloc_global sk mem (Gvar v) = Some m0)
      (BYTE: init_data_list_to_memval_list sk (gvar_init v) = Some mvl)
      (FIND: nth_error mvl ofs = Some mv) :
    Maps.ZMap.get ofs (Maps.PMap.get (Mem.nextblock mem) (Mem.mem_contents m0)) = mv.
  Proof.
    unfold ClightPlusMem0.alloc_global in AL. des_ifs. rename Heq into MA, Heq0 into MSZ, Heq1 into MS, AL into DP.
    apply Globalenvs.Genv.store_zeros_loadbytes in MSZ.
    unfold Mem.drop_perm in DP. des_ifs. ss. unfold Mem.alloc in MA. clarify.
    clear - BYTE FIND MSZ MS.
    set (gvar_init v) as l in *. clearbody l.
    set 0 as i in MSZ, MS. assert (R: 0 ≤ i) by ss.
    assert ((forall ofs, 0 ≤ ofs < i -> Maps.ZMap.get ofs (Maps.PMap.get (Mem.nextblock mem) m1.(Mem.mem_contents)) = Maps.ZMap.get ofs (Maps.PMap.get (Mem.nextblock mem) m2.(Mem.mem_contents))) /\ forall ofs mv, nth_error mvl ofs = Some mv -> Maps.ZMap.get (i + ofs) (Maps.PMap.get (Mem.nextblock mem) (Mem.mem_contents m2)) = mv); cycle 1.
    { destruct H. replace (Z.of_nat ofs) with (i + Z.of_nat ofs) by nia. et. }
    clearbody i. clear FIND. revert i m1 m2 mvl ofs MSZ MS BYTE R.
    induction l; i; ss; clarify.
    { unfold init_data_list_to_memval_list in BYTE. ss. clarify. split; et. i. destruct ofs0; ss. }
    des_ifs. rename Heq into Cur. unfold init_data_list_to_memval_list in BYTE.
    ss. des_ifs. rename Heq into Cur0, Heq0 into REST. ss. clarify. pose proof (init_data_size_pos a).
    hexploit IHl; et; try nia.
    { unfold ClightPlusMem0.store_init_data in Cur. des_ifs.
      7:{ ii. apply MSZ; et; try nia. }
      all: ii; erewrite Mem.loadbytes_store_other; et.
      all: apply MSZ; et; try nia. }
    { unfold init_data_list_to_memval_list. rewrite REST. ss. }
    intros [C1 C2]. split.
    - intros ofs0 R0. rewrite <- (C1 ofs0); try nia. unfold ClightPlusMem0.store_init_data, Mem.store in *.
      des_ifs; ss. all: rewrite Maps.PMap.gss; rewrite Mem.setN_outside; et; try nia.
    - intros ofs0 mv0 FIND.
      assert (EQ: List.length l0 = Z.to_nat (init_data_size a)).
      { unfold init_data_to_memval in Cur0; des_ifs. rewrite repeat_length. ss. nia. }
      destruct (lt_dec ofs0 (List.length l0)); cycle 1.
      { rewrite nth_error_app2 in FIND; try nia.
        hexploit C2; et. i. etrans; try eassumption. f_equal. nia. }
      rewrite nth_error_app1 in FIND; try nia.
      rewrite <- C1; try nia. unfold ClightPlusMem0.store_init_data, Mem.store in Cur.
      des_ifs; ss; clarify.
      7:{ rewrite repeat_nth_some in FIND; try nia. clarify.
          red in MSZ. specialize (MSZ (i + ofs0) 1%nat).
          hexploit MSZ; try nia.
          { rewrite repeat_length in *. ss. pose proof (init_data_list_size_pos l). nia. }
          unfold Mem.loadbytes. des_ifs. i. clarify. }
      all: try rewrite Maps.PMap.gss; try erewrite setN_inside; et.
      all: try solve [rewrite encode_val_length; ss; nia].
      all: try (rewrite <- FIND; des_ifs; f_equal; nia).
  Qed.

  Lemma decode_init_len
      sk l mvl
      (BYTE: init_data_list_to_memval_list sk l = Some mvl) :
    List.length mvl = Z.to_nat (init_data_list_size l).
  Proof.
    depgen mvl. induction l.
    - i. unfold init_data_list_to_memval_list in *. ss. clarify.
    - i. unfold init_data_list_to_memval_list in *. ss. des_ifs. ss. clarify.
      rewrite app_length. rewrite (IHl (List.concat _)); et.
      pose proof (init_data_list_size_pos l).
      unfold init_data_to_memval in Heq. des_ifs.
      all: try (rewrite encode_val_length; ss; nia).
      rewrite repeat_length. ss. nia.
  Qed.

  Lemma init_fail_iff sk : alloc_globals sk (ε,ε,ε) xH sk = None <-> load_mem sk = None.
  Proof.
    unfold load_mem.
    set sk as sk' at 2 4. assert (INCL: List.incl sk' sk) by refl. clearbody sk'.
    set (ε, ε, ε) as res. change xH with (Mem.nextblock Mem.empty). set Mem.empty as mem. clearbody res mem.
    revert sk INCL res mem. induction sk'; ss.
    split; ss; i.
    - des_ifs; rename Heq0 into STEP, H0 into REST, Heq into AL.
      + hexploit alloc_gl_nextblock; et. intro EQ. rewrite <- EQ in REST.
        rewrite <- IHsk'; et. etrans; et. unfold List.incl. i. ss. et.
      + rewrite <- alloc_gl_iff in STEP. clarify.
    - des_ifs; rename Heq0 into STEP, H0 into REST, Heq into AL.
      + hexploit alloc_gl_nextblock; et. intro EQ. rewrite <- EQ.
        rewrite IHsk'; et. etrans; et. unfold List.incl. i. ss. et.
      + rewrite alloc_gl_iff in STEP. rewrite AL in STEP. clarify.
  Qed.

  Lemma _start_wf :
          << _ : ∀ (b : block) (ofs : Z),
                    0 ≤ ofs
                    → sim_cnt ((ε : ClightPlusMemRA.__pointstoRA) b ofs)
                        (Maps.PMap.get b (Mem.mem_access Mem.empty) ofs)
                        (Maps.ZMap.get ofs (Maps.PMap.get b (Mem.mem_contents Mem.empty))) >>
                  ∧ << _
                    : ∀ b : block,
                            sim_allocated ((ε : ClightPlusMemRA.__allocatedRA) b) (((ε : ClightPlusMemRA._blocksizeRA) (Some b)) ⋅ if Coqlib.plt b xH then OneShot.unit else OneShot.black)
                              (Maps.PMap.get b (Mem.mem_access Mem.empty))
                              (Maps.PMap.get b (Mem.mem_contents Mem.empty)) >>.
  Proof.
    unfold Mem.empty. ss. split.
    - red. i. rewrite Maps.PMap.gi. econs 2; ss.
    - red. i. des_ifs.
  Qed.

  Lemma init_len
      sk m
      (MEMWF: load_mem sk = Some m) :
    Pos.of_succ_nat (strings.length sk) = m.(Mem.nextblock).
  Proof.
    unfold load_mem in MEMWF.
    destruct (List.length sk) eqn:?. { destruct sk; clarify. ss. clarify. }
    rename Heqn into sklen. rewrite <- sklen. assert (sklen0: 1 ≤ strings.length sk) by nia. clear sklen. rename sklen0 into sklen.
    replace (Pos.of_succ_nat (strings.length sk)) with (Pos.add xH (Pos.of_nat (strings.length sk))) by nia.
    change xH with (Mem.empty.(Mem.nextblock)). set Mem.empty as mi in *. clearbody mi.
    set sk as l in *. unfold l in MEMWF at 1. clearbody l.
    ginduction l; i; ss. des_ifs. destruct l.
    - ss. clarify. hexploit alloc_gl_nextblock; et. i. nia.
    - eapply IHl in MEMWF; et. 2:{ ss. nia. }
      hexploit alloc_gl_nextblock; et. i. rewrite <- MEMWF. ss. nia.
  Qed.

  Lemma init_wf
      sk m p a s
      (RESWF: alloc_globals sk (ε,ε,ε) xH sk = Some (p, a, s))
      (MEMWF: load_mem sk = Some m) :
    OwnM (M := Mem.t)
      (Auth.black p, Auth.black a,
          s ⋅ fun ob : option block =>
                match ob with
                | Some b =>
                  if Coqlib.plt b (Pos.of_succ_nat (strings.length sk)) then OneShot.unit
                  else OneShot.black
                | None => OneShot.white 0
                end,
            fun ob : option block =>
              match ob with
              | Some _ => OneShot.black
              | None => OneShot.white Ptrofs.zero
              end)
    ⊢ ∃ (mem_tgt : mem) (mem_src : Mem.t),
        ⌜(<< _ : Any.upcast m = Any.upcast mem_tgt >>) /\ sim_mem mem_src mem_tgt⌝
        ** OwnM mem_src.
  Proof.
    Local Opaque Pos.add.
    Local Transparent _has_size.
    iIntros "A". iExists _, _. iSplit; et. iPureIntro. split; et.
    erewrite init_len; et. unfold load_mem in MEMWF.
    hexploit _start_wf. i. rename H0 into INV.
    change xH with (Mem.empty.(Mem.nextblock)) in *.
    set ε as pi in RESWF, INV. set ε as ai in RESWF, INV. set ε as si in RESWF, INV.
    set Mem.empty as mem in RESWF, MEMWF, INV.
    assert (conc_empty: Mem.mem_concrete mem = Maps.PTree.empty Z) by ss.
    assert (sres_none: si None = OneShot.unit) by ss.
    assert (sres_next: forall b: block, (Mem.nextblock mem ≤ b)%positive -> si (Some b) = OneShot.unit) by ss.
    assert (sres_nounit: forall b: block, (b < Mem.nextblock mem)%positive -> si (Some b) <> OneShot.unit) by now unfold mem; ss; nia.
    assert (sim_ca: forall b ofs q mv, pi b ofs = Consent.just q mv -> exists q' tg, ai b = Consent.just q' tg) by now i; ss.
    clearbody pi ai si mem. set sk as l in RESWF at 2. change sk with l in MEMWF at 2. clearbody l.
    revert m mem pi ai si p a s RESWF MEMWF INV conc_empty sres_none sres_next sres_nounit sim_ca.
    induction l; i; ss; clarify.
    { des. econs; et.
      { i. des_ifs. rewrite conc_empty. rewrite Maps.PTree.gempty. econs. et. }
      { i. ur. rewrite sres_none. destruct ob; ss. 2:{ ur. et. }
        split; et. split; cycle 1. { des_ifs; ur; des_ifs. unfold Coqlib.Plt in *. hexploit sres_nounit; et. }
        i. rewrite sres_next; et. ur. des_ifs. unfold Coqlib.Plt in *. nia. } }
    des_ifs_safe. destruct p0 as [[p' a'] s']. eapply IHl.
    { erewrite alloc_gl_nextblock; et. } { et. }
    all: cycle 1.
    { erewrite alloc_gl_concrete; et. } { des_ifs; ur; rewrite sres_none; ur; et. }
    { intros b R. erewrite alloc_gl_nextblock in R; et.
      destruct (dec b (mem.(Mem.nextblock))). { subst. nia. }
      des_ifs; ur; rewrite sres_next; try nia; destruct Pos.eq_dec; try nia; ur; et. }
    { intros b R. erewrite alloc_gl_nextblock in R; et.
      destruct (dec b (mem.(Mem.nextblock))). { clarify. des_ifs; ur; des_ifs; ur; des_ifs. }
      des_ifs; ur; des_ifs; intro contra; ur in contra; des_ifs; eapply sres_nounit; et; nia. }
    { intros b ofs q mv P. destruct g; clarify.
      { apply sim_ca in P. des. specialize (z0 b). destruct (Pos.eq_dec b (Mem.nextblock mem)); cycle 1.
        { ur. rewrite allocated_with_diff_blk; et. r_solve. et. }
        clarify. ur. unfold __allocated_with. destruct Pos.eq_dec; clarify.
        destruct Coqlib.plt. { unfold Coqlib.Plt in *. nia. }
        rewrite P in z0. inv z0. ur in SRES. des_ifs. }
      destruct store_init_data_list eqn:?; clarify.
      destruct (Pos.eq_dec b (Mem.nextblock mem)); cycle 1.
      { ur. rewrite allocated_with_diff_blk; et. r_solve.
        eapply store_init_data_list_diff_blk in Heqo; et. do 2 ur in P. rewrite <- Heqo in P.
        eapply sim_ca. rewrite <- P. instantiate (1:=ofs). ur. des_ifs. }
      clarify. ur. unfold __allocated_with. destruct Pos.eq_dec; clarify.
      des. specialize (z0 (Mem.nextblock mem)). destruct Coqlib.plt. { unfold Coqlib.Plt in *. nia. }
      inv z0. 2:{ r_solve. et. } ur in SRES. des_ifs. }

    (* prove main invariant : INV *)
    des. rename z into cnt_init, z0 into alloc_init, Heq into tgt_step.
    clear RESWF MEMWF IHl. destruct g; split. all: swap 3 4.
    (* case : allocate function, sim_cnt *)
    - clarify. ii. rename H0 into R. unfold ClightPlusMem0.alloc_global in tgt_step.
      unfold Mem.alloc, Mem.drop_perm in tgt_step. des_ifs. ss.
      destruct (dec b (Mem.nextblock mem)); cycle 1. { rewrite !Maps.PMap.gso; et. }
      clarify. rewrite !Maps.PMap.gss. hexploit (cnt_init (Mem.nextblock mem)); et. intro D.
      inv D; cycle 1. econs 2.
      rewrite (mem.(Mem.nextblock_noaccess) mem.(Mem.nextblock)) in PERM; clarify.
      unfold Coqlib.Plt. nia.
    (* case : allocate function, sim_allocated *)
    - erewrite alloc_gl_nextblock; et. clarify. ii.
      unfold ClightPlusMem0.alloc_global, Mem.alloc, Mem.drop_perm in tgt_step.
      destruct Mem.range_perm_dec; ss; clarify.
      ss. set (_ b) as ares. eassert (TEMP: ares = _). { unfold ares. ur. refl. } rewrite TEMP. clear TEMP ares.
      set (_ (Some b)) as cres. eassert (TEMP: cres = _). { unfold cres. ur. refl. } rewrite TEMP. clear TEMP cres.
      unfold __allocated_with.
      destruct (Pos.eq_dec b (Mem.nextblock mem)); cycle 1.
      + replace ((ai b : Consent.t tag) ⋅ Consent.unit) with (ai b) by now ur; des_ifs.
        replace ((si (Some b) : OneShot.t Z) ⋅ OneShot.unit) with (si (Some b)) by now ur; des_ifs.
        rewrite !Maps.PMap.gso; et. spc alloc_init. do 2 destruct Coqlib.plt; unfold Coqlib.Plt in *; try nia; et.
      + clarify. rewrite !Maps.PMap.gss. destruct Coqlib.plt; unfold Coqlib.Plt in *; try nia.
        rewrite sres_next; try nia. specialize (alloc_init (Mem.nextblock mem)).
        inv alloc_init. { destruct Coqlib.plt; unfold Coqlib.Plt in *; try nia. ur in SRES. des_ifs. }
        rewrite URA.unit_idl. ur. econs; et; ss; cycle 1.
        all: i; destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia.
        esplits; et. econs.
    (* case : allocate variable, sim_allocated *)
    - erewrite alloc_gl_nextblock; et. destruct store_init_data_list eqn: ?; clarify.
      ii. set (_ b) as ares. eassert (TEMP: ares = _). { unfold ares. ur. refl. } rewrite TEMP. clear TEMP ares.
      set (_ (Some b)) as cres. eassert (TEMP: cres = _). { unfold cres. ur. refl. } rewrite TEMP. clear TEMP cres.
      unfold __allocated_with.
      destruct (Pos.eq_dec b (Mem.nextblock mem)); cycle 1.
      + hexploit alloc_gl_unmodified; et. intros [T T0]. rewrite T. rewrite T0. clear T T0.
        replace ((ai b : Consent.t tag) ⋅ Consent.unit) with (ai b) by now ur; des_ifs.
        replace ((si (Some b) : OneShot.t Z) ⋅ OneShot.unit) with (si (Some b)) by now ur; des_ifs.
        spc alloc_init. do 2 destruct Coqlib.plt; unfold Coqlib.Plt in *; try nia; et.
      + clarify. rewrite sres_next; try nia. destruct Coqlib.plt; unfold Coqlib.Plt in *; try nia.
        specialize (alloc_init (Mem.nextblock mem)).
        inv alloc_init. { destruct Coqlib.plt; unfold Coqlib.Plt in *; try nia. ur in SRES. des_ifs. }
        ur. destruct ε eqn:?; clarify. hexploit alloc_gl_modified_access; et. i. des.
        econs; et; ss. i. esplits; et. econs.
    (* case : allocate variable, sim_cnt *)
    - destruct store_init_data_list eqn: ?; clarify. rename Heqo into src_step.
      ii. rename H0 into RES. destruct (dec b (Mem.nextblock mem)); cycle 1.
      + hexploit alloc_gl_unmodified; et. intros [T1 T2]. rewrite T1. rewrite T2. clear T1 T2.
        do 2 ur. replace (c b ofs) with (ε : Consent.t memval); r_solve; et.
        clear - src_step n. set (_ : option Qp) in src_step.
        set (gvar_init v) as l in src_step. set 0 as i in src_step. clearbody o l i.
        set ε as r in src_step. assert (RES: r b ofs = ε) by ss. clearbody r.
        revert c i r src_step RES. induction l; i; ss; clarify.
        des_ifs. eapply IHl; et. unfold store_init_data in Heq.
        unfold __points_to in Heq. des_ifs.
        all: do 2 ur; destruct Pos.eq_dec; ss; rewrite RES; ur; des_ifs.
      + clarify. hexploit (cnt_init (Mem.nextblock mem)); et. intro D.
        inv D. { erewrite (mem.(Mem.nextblock_noaccess) mem.(Mem.nextblock)) in PERM; unfold Coqlib.Plt; try nia. clarify. }
        do 2 ur. rewrite <- H1. r_solve. clear H1.
        destruct (Coqlib.zle 0 ofs && Coqlib.zlt ofs (init_data_list_size (gvar_init v))) eqn:?; cycle 1.
        * replace (c (Mem.nextblock mem) ofs) with (ε : Consent.t memval). econs 2.
          assert (R: ~ (0 ≤ ofs < init_data_list_size (gvar_init v))). { destruct Coqlib.zle; destruct Coqlib.zlt; ss; clarify; nia. }
          clear - src_step R. set (_ : option Qp) in src_step. set (gvar_init v) as l in src_step. set 0 as i in src_step.
          assert (R0: 0 ≤ i) by ss.
          assert (R1: i + init_data_list_size l ≤ init_data_list_size (gvar_init v)) by now unfold i, l; nia.
          set ε as r in src_step. assert (RES: r (Mem.nextblock mem) ofs = ε) by ss. clearbody o l i r.
          revert c i r src_step ofs R R0 R1 RES. induction l; i; ss; clarify.
          des_ifs. pose proof (init_data_size_pos a). eapply IHl; et; try nia.
          pose proof (init_data_list_size_pos l).
          unfold store_init_data in Heq. des_ifs.
          all: do 2 ur; rewrite points_to_outbound; [r_solve; et|].
          all: try rewrite encode_val_length; try rewrite repeat_length; ss; nia.
        * assert (R: 0 ≤ ofs < init_data_list_size (gvar_init v)). { destruct Coqlib.zle; destruct Coqlib.zlt; ss; clarify; nia. }
          destruct (Mem.perm_order_dec Nonempty (Globalenvs.Genv.perm_globvar v)).
          { replace (Globalenvs.Genv.perm_globvar v) with Nonempty in * by now inv p0; et.
            assert (c = ε); clarify. apply store_init_data_list_nonempty in src_step. clarify. }
          hexploit alloc_gl_modified_access; et. intros [T1 T2].
          set (_ : option Qp) as d in src_step.
          assert (EX: exists q, d = Some q). { unfold d. des_ifs; et. exfalso. apply n. econs. }
          des. rewrite EX in src_step.
          hexploit store_init_data_list_content; et. i. des. rename H0 into BYTE, H1 into RES0.
          assert (nth_error mvl (Z.to_nat ofs) <> None). { rewrite nth_error_Some. erewrite decode_init_len; et. nia. }
          destruct nth_error eqn:?; clarify.
          hexploit alloc_gl_modified_content; et. intro D. econs.
          { erewrite RES0; et. etrans; try eassumption. rewrite <- D. do 2 f_equal. nia. }
          { unfold d in EX. des_ifs. }
          { rewrite T1; et. }
          { destruct Globalenvs.Genv.perm_globvar; clarify; econs. }
          i. unfold d in EX. des_ifs; econs.
    Local Transparent Pos.add.
    Local Opaque _has_size.
  Qed.

End INITSIM.

Section CAPTURESIM.

  Local Open Scope Z.

  Context `{@GRA.inG Mem.t Σ}.

  Local Hint Constructors sim_cnt: core.
  Local Hint Constructors sim_allocated: core.
  Local Hint Constructors sim_concrete: core.

  Lemma capture_match
      p (a : ClightPlusMemRA.__allocatedRA) s c mem_tgt mem_tgt' blk addr sz
      (PERM: a blk <> Consent.unit)
      (SZ: s (Some blk) = OneShot.white sz /\ 0 < sz)
      (SIM: sim_mem (Auth.black p, Auth.black a, s, c) mem_tgt)
      (TGTCAP: Mem.capture mem_tgt blk addr mem_tgt') :
    sim_mem (Auth.black p, Auth.black a, s, update c (Some blk) (OneShot.white (Ptrofs.repr addr))) mem_tgt'.
  Proof.
    inv SIM. inv TGTCAP. rewrite CONTENTS in *. rewrite ACCESS in *. rewrite NEXTBLOCK in *.
    econs; et. i. spc SIM_CONC. spc SIM_ALLOC. des_ifs. destruct (Pos.eq_dec b blk); clarify; cycle 1.
    { rewrite update_diff_blk. 2:{ ii. clarify. } erewrite <- Mem.concrete_other; et. econs; et. }
    rewrite update_same_blk. inv SIM_CONC.
    - rename H2 into old. hexploit PREVADDR; et. intros [T1 T2].
      rewrite T2 in *. rewrite <- old. econs; et. rewrite <- T1.
      rewrite Ptrofs.repr_unsigned. et.
    - rename H2 into NEX. hexploit CAPTURED; et. intro CONC. rewrite CONC.
      rewrite Maps.PTree.gss. replace addr with (Ptrofs.unsigned (Ptrofs.repr addr)) at 2. econs; et.
      rewrite Ptrofs.unsigned_repr; et. hexploit (Mem.weak_valid_address_range mem_tgt' blk addr 0); ss; cycle 2.
      { intro R. inv R. ss. change Ptrofs.max_unsigned with (Ptrofs.modulus - 1). nia. }
      { rewrite CONC. rewrite Maps.PTree.gss. et. }
      rr. des. left. inv SIM_ALLOC; clarify. 2:{ rewrite <- H1 in *. ss; clarify. }
      unfold Mem._valid_pointer. pose proof (Mem.access_max mem_tgt' blk 0).
      unfold Mem.perm_order'. des_ifs; [econs|].
      ss. des_ifs. hexploit (PERMinrange 0); cycle 1. i. des. clarify.
      rewrite SZ in *. clarify. destruct tag. { hexploit DYNAMIC; et. i. des. nia. }
      all: hexploit COMMON; et; nia.
  Qed.

  (* key main thm of capture *)
  Lemma capture_progress
      p (a : ClightPlusMemRA.__allocatedRA) s c mem_tgt mem_tgt' blk addr tg qa sz
      (PERM: a blk <> Consent.unit)
      (SZ: s (Some blk) = OneShot.white sz /\ 0 < sz)
      (SIM: sim_mem (Auth.black p, Auth.black a, s, c) mem_tgt)
      (TGTCAP: Mem.capture mem_tgt blk addr mem_tgt') :
    URA.updatable (t:=Mem.t)
      (Auth.black p, Auth.black a ⋅ Auth.white (__allocated_with blk tg qa), s, c)
      (Auth.black p, Auth.black a ⋅ Auth.white (__allocated_with blk tg qa), s, update c (Some blk) (OneShot.white (Ptrofs.repr addr))).
  Proof.
    exploit capture_match; et. intro SIM'.
    des. destruct (c (Some blk)) eqn:?; cycle 2.
    { inv SIM. specialize (SIM_CONC (Some blk)). ss. inv SIM_CONC; rewrite RES in *; clarify. }
    { inv SIM. specialize (SIM_CONC (Some blk)). ss. inv SIM_CONC; rewrite RES in *; clarify. }
    { inv SIM. specialize (SIM_CONC (Some blk)). ss. inv SIM_CONC; rewrite RES in *; clarify.
      inv TGTCAP. hexploit PREVADDR; et. i. des. clarify. rewrite Ptrofs.repr_unsigned.
      replace (update c (Some blk) (OneShot.white x)) with c. refl. extensionalities. unfold update. des_ifs. }
    eapply capture_update; et; cycle 2. all: swap 3 4.
    { inv SIM. i. spc SIM_ALLOC. des_ifs. des; et. rewrite SIM_ALLOC. et. }
    { inv SIM. i. spc SIM_CONC. des_ifs. inv SIM_CONC; rewrite RES; et. rewrite SIM_CONC; et. }
    - i. inv SIM'. pose proof (SIM_ALLOC (Some b')). ss.
      pose proof (SIM_ALLOC (Some blk)). ss. des.
      pose proof (SIM_CONC (Some b')). ss.
      pose proof (SIM_CONC (Some blk)). ss.
      rename H0 into SZPOS', H1 into SZPOS, H2 into DIF, H3 into RESa, H4 into RESs, H5 into RESc, H6 into A, H7 into A', H10 into NB, H8 into NB', H11 into NU, H9 into NU', H12 into C, H13 into C'.
      rewrite RESa in *. inv A. inv A'. 2:{ rewrite <- H1 in *. clarify. }
      rewrite SZ in *. clarify. i. des. rewrite RESs in *. clarify.
      rewrite update_same_blk in C'. rewrite update_diff_blk in C. 2:{ ii. clarify. }
      rewrite RESc in *. inv C; clarify. inv C'; clarify.
      destruct (Coqlib.zlt (Ptrofs.unsigned (Ptrofs.repr addr) - Ptrofs.unsigned base) sz0); [|nia].
      destruct (Coqlib.zlt (Ptrofs.unsigned base - Ptrofs.unsigned (Ptrofs.repr addr)) sz1); [|nia].
      exfalso. destruct (Coqlib.zle (Ptrofs.unsigned base) (Ptrofs.unsigned (Ptrofs.repr addr))).
      + hexploit (PERMinrange0 0).
        { destruct tag0. { hexploit DYNAMIC0; et. i. des. ss. nia. } all: hexploit COMMON0; et; nia. }
        hexploit (PERMinrange (Ptrofs.unsigned (Ptrofs.repr addr)- Ptrofs.unsigned base)).
        { destruct tag. { hexploit DYNAMIC; et. i. des. ss. nia. } all: hexploit COMMON; et; nia. }
        i. des. pose proof (Mem.no_concrete_overlap mem_tgt' (Ptrofs.unsigned (Ptrofs.repr addr))) as X.
        red in X. hexploit (X b' blk); clarify.
        * econs; et; cycle 1. { destruct (Ptrofs.repr addr), base in *. ss. nia. }
          hexploit (Mem.access_max mem_tgt' b'). rewrite H0.
          unfold Mem.perm_order''. des_ifs. et.
        * econs; et; cycle 1. { destruct (Ptrofs.repr addr). ss. nia. }
          rewrite Z.sub_diag. hexploit (Mem.access_max mem_tgt' blk). rewrite H1.
          unfold Mem.perm_order''. des_ifs. et.
      + hexploit (PERMinrange 0).
        { destruct tag. { hexploit DYNAMIC; et. i. des. ss. nia. } all: hexploit COMMON; et; nia. }
        hexploit (PERMinrange0 (Ptrofs.unsigned base - Ptrofs.unsigned (Ptrofs.repr addr))).
        { destruct tag0. { hexploit DYNAMIC0; et. i. des. ss. nia. } all: hexploit COMMON0; et; nia. }
        i. des. pose proof (Mem.no_concrete_overlap mem_tgt' (Ptrofs.unsigned base)) as X.
        red in X. hexploit (X b' blk); clarify.
        * econs; et; cycle 1. { destruct (Ptrofs.repr addr) in *. ss. nia. }
          rewrite Z.sub_diag. hexploit (Mem.access_max mem_tgt' b'). rewrite H1.
          unfold Mem.perm_order''. des_ifs. et.
        * econs; et; cycle 1. { destruct (Ptrofs.repr addr), base in *. ss. nia. }
          hexploit (Mem.access_max mem_tgt' blk). rewrite H0.
          unfold Mem.perm_order''. des_ifs. et.
    - i. inv SIM'. pose proof (SIM_ALLOC (Some b')). ss.
      pose proof (SIM_ALLOC (Some blk)). ss. des.
      pose proof (SIM_CONC (Some b')). ss.
      pose proof (SIM_CONC (Some blk)). ss.
      rename H0 into SZPOS0', H13 into SZPOS1', H1 into SZPOS0, H12 into SZPOS1, H2 into RESp', H3 into RESp, H4 into RESs, H5 into RESc, H6 into A, H7 into A', H10 into NB, H8 into NB', H11 into NU, H9 into NU', H14 into C, H15 into C'.
      hexploit SIM_CA; et. intro RESa. des. hexploit (SIM_CA blk). 3:et. all: et. intro RESa'. des.
      rewrite RESa in *. inv A. inv A'. 2:{ rewrite <- H1 in *. clarify. }
      rewrite SZ in *. clarify. i. des. rewrite RESs in *. clarify.
      rewrite update_same_blk in C'. rewrite update_diff_blk in C. 2:{ ii. clarify. }
      rewrite RESc in *. inv C; clarify. inv C'; clarify.
      destruct (Coqlib.zlt (Ptrofs.unsigned (Ptrofs.repr addr) - Ptrofs.unsigned base) sz0); [|nia].
      destruct (Coqlib.zlt (Ptrofs.unsigned base - Ptrofs.unsigned (Ptrofs.repr addr)) sz1); [|nia].
      exfalso. destruct (Coqlib.zle (Ptrofs.unsigned base) (Ptrofs.unsigned (Ptrofs.repr addr))).
      + hexploit (PERMinrange0 0).
        { destruct tag0. { hexploit DYNAMIC0; et. i. des. ss. nia. } all: hexploit COMMON0; et; nia. }
        hexploit (PERMinrange (Ptrofs.unsigned (Ptrofs.repr addr)- Ptrofs.unsigned base)).
        { destruct tag. { hexploit DYNAMIC; et. i. des. ss. nia. } all: hexploit COMMON; et; nia. }
        i. des. pose proof (Mem.no_concrete_overlap mem_tgt' (Ptrofs.unsigned (Ptrofs.repr addr))) as X.
        red in X. hexploit (X b' blk); i; clarify.
        * econs; et; cycle 1. { destruct (Ptrofs.repr addr), base in *. ss. nia. }
          hexploit (Mem.access_max mem_tgt' b'). rewrite H0.
          unfold Mem.perm_order''. des_ifs. et.
        * econs; et; cycle 1. { destruct (Ptrofs.repr addr). ss. nia. }
          rewrite Z.sub_diag. hexploit (Mem.access_max mem_tgt' blk). rewrite H1.
          unfold Mem.perm_order''. des_ifs. et.
      + hexploit (PERMinrange 0).
        { destruct tag. { hexploit DYNAMIC; et. i. des. ss. nia. } all: hexploit COMMON; et; nia. }
        hexploit (PERMinrange0 (Ptrofs.unsigned base - Ptrofs.unsigned (Ptrofs.repr addr))).
        { destruct tag0. { hexploit DYNAMIC0; et. i. des. ss. nia. } all: hexploit COMMON0; et; nia. }
        i. des. pose proof (Mem.no_concrete_overlap mem_tgt' (Ptrofs.unsigned base)) as X.
        red in X. hexploit (X b' blk); i; clarify.
        * econs; et; cycle 1. { destruct (Ptrofs.repr addr) in *. ss. nia. }
          rewrite Z.sub_diag. hexploit (Mem.access_max mem_tgt' b'). rewrite H1.
          unfold Mem.perm_order''. des_ifs. et.
        * econs; et; cycle 1. { destruct (Ptrofs.repr addr), base in *. ss. nia. }
          hexploit (Mem.access_max mem_tgt' blk). rewrite H0.
          unfold Mem.perm_order''. des_ifs. et.
  Qed.

End CAPTURESIM.

Require Import HTactics ProofMode.
Require Import HSim IProofMode.
From compcert Require Import Ctypes Floats Integers Values Memory AST Clight Clightdefs IntPtrRel.

Section SIMMODSEM.

  Context `{@GRA.inG Mem.t Σ}.

  Let world := unit.

  Let wf: world -> Any.t * Any.t -> Prop :=
    mk_wf
      (fun _ _ _mem_tgt =>
          ∃ (mem_tgt: Mem.mem) (mem_src: Mem.t),
            ⌜(<<TGT: _mem_tgt = mem_tgt↑>>) /\ sim_mem mem_src mem_tgt⌝ ** OwnM mem_src)%I
  .

  Local Hint Resolve sim_itree_mon: paco.

  Local Ltac case_points_to := unfold __points_to; destruct Pos.eq_dec; destruct Coqlib.zle; destruct Coqlib.zlt.
  Local Ltac cleartrue := match goal with H : True |- _ => clear H end.


  Local Hint Constructors sim_cnt: core.
  Local Hint Constructors sim_allocated: core.
  Local Hint Constructors sim_concrete: core.

  Local Transparent Mem.alloc Mem.store Mem.free Mem.load.

  Local Transparent _points_to _allocated_with _has_offset _has_size _has_base.

  Lemma sim_salloc :
    sim_fnsem wf top2
      ("salloc", fun_to_tgt "Mem" (to_stb []) (mk_pure salloc_spec))
      ("salloc", cfunU sallocF).
  Proof.
    econs; ss. red; ss. apply isim_fun_to_tgt; ss.
    i. iIntros "[INV PRE]".
    iDestruct "PRE" as "%"; des; clarify.
    rename x into sz, H2 into szran1, H3 into szran2. unfold inv_with.
    iDestruct "INV" as (tt) "[INV %]". cleartrue.
    iDestruct "INV" as (mem_tgt mem_src) "[% MEM]".
    des; clarify. inv H1.

    unfold sallocF. hred_r. iApply isim_pget_tgt. hred_r.
    iApply isim_pput_tgt. hred_r. iApply isim_apc. iExists None. hred_l.
    iApply isim_choose_src. iExists _. iApply isim_upd.

    iPoseProof (OwnM_Upd with "MEM") as ">[MEM MEM_POST]".
    (* resource update *)
    - hexploit alloc_update. 7:{ i. apply H0. }
      { refl. } { refl. }
      + instantiate (1:=Mem.nextblock mem_tgt). instantiate (1:=repeat Undef (Z.to_nat sz)).
        instantiate (1:=0). rewrite repeat_length.
        i. hexploit (SIM_CNT (Mem.nextblock mem_tgt) ofs); try nia.
        intro sim. inv sim; et. rewrite (Mem.nextblock_noaccess mem_tgt) in PERM; clarify.
        unfold Coqlib.Plt. nia.
      + specialize (SIM_ALLOC (Some (Mem.nextblock mem_tgt))). ss.
        des. inv SIM_ALLOC; et. rewrite SIM_ALLOC0 in SRES; clarify. nia.
      + specialize (SIM_ALLOC (Some (Mem.nextblock mem_tgt))). ss.
        des. apply SIM_ALLOC0. nia.
      + specialize (SIM_CONC (Some (Mem.nextblock mem_tgt))). ss.
        inv SIM_CONC; et. rewrite (Mem.nextblocks_logical mem_tgt) in H2; clarify.
        unfold Coqlib.Plt. nia.
    (* prove invariant and post conditions *)
    - iModIntro. iApply isim_ret. iModIntro. instantiate (2:=sz). instantiate (2:=Local).
      iSplitR "MEM_POST"; cycle 1.
      (* post condition *)
      + iSplit; et.
        set {| blk := Some (mem_tgt.(Mem.nextblock)); sz := sz; SZPOS := fun _ => szran1 |} as m.
        iExists m, (Vptr (mem_tgt.(Mem.nextblock)) Ptrofs.zero).
        iSplits; et. rewrite mem_split. iDestruct "MEM_POST" as "[[CNT_POST ALLOC_POST] SZ_POST]".
        unfold m, points_to, has_offset, _has_offset; ss.
        iPoseProof (_has_size_dup with "SZ_POST") as "[? SZ_POST]".
        iPoseProof (_has_size_dup with "SZ_POST") as "[? ?]".
        iFrame. iSplits; ss; et. iPureIntro.
        all: rewrite repeat_length; change (Ptrofs.unsigned _) with 0; nia.
      (* invariant *)
      + iExists _. iSplits; ss. iPureIntro. econs; ss.
        (* sim_cnt *)
        * i. hexploit (SIM_CNT b); et. intro SIM_CNT0. do 2 ur.
          destruct (Pos.eq_dec b (mem_tgt.(Mem.nextblock))); clarify; cycle 1.
          { rewrite points_to_diff_blk; et. r_solve. rewrite ! Maps.PMap.gso; et. }
          rewrite ! Maps.PMap.gss. inv SIM_CNT0.
          { rewrite Mem.nextblock_noaccess in PERM; unfold Coqlib.Plt; try nia; clarify. }
          r_solve. rewrite Maps.ZMap.gi. case_points_to; ss; cycle 1.
          rewrite repeat_length in *.
          destruct nth_error eqn:?; cycle 1. econs 2.
          econs; et.
          { rewrite repeat_nth_some in Heqo; try nia. clarify. }
          { destruct Coqlib.zlt; clarify. nia. }
          { econs. } i. econs.
        (* sim_alloc *)
        * i. des_ifs; cycle 1.
          { specialize (SIM_ALLOC None); ss. }
          destruct (Pos.eq_dec b (mem_tgt.(Mem.nextblock))); clarify; cycle 1.
          { specialize (SIM_ALLOC (Some b)); ss; des. rewrite ! Maps.PMap.gso; et. ur.
            unfold __allocated_with. destruct Pos.eq_dec; clarify.
            set (_ ⋅ _) as st. replace st with (memalloc_src b : Consent.t tag). 2:{ unfold st. ur. des_ifs. } clear st.
            unfold update. des_ifs. splits; et. i. apply SIM_ALLOC0; nia. }
          rewrite ! Maps.PMap.gss. specialize (SIM_ALLOC (Some (mem_tgt.(Mem.nextblock)))); ss; des.
          rewrite update_same_blk. splits; i; try nia; et. hexploit SIM_ALLOC0; try nia. i. rewrite H0 in *. ur.
          inv SIM_ALLOC; clarify. r_solve. unfold __allocated_with.
          des_ifs. econs. 7: et. all: et. all: i; clarify.
          { exists Freeable. i. destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia. split; econs. }
          { destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia. }
        (* sim_ca *)
        * intros b ofs q mv sz0. i. do 2 ur in PRES. ur. unfold __allocated_with. des_ifs; cycle 1.
          { rewrite points_to_diff_blk in PRES; et.
            rewrite update_diff_blk in SRES. 2:{ ii. clarify. }
            revert PRES. r_solve. i. eapply SIM_CA in PRES; et.
            des. rewrite PRES. ur. et. }
          specialize (SIM_ALLOC (Some (Mem.nextblock mem_tgt))); ss; des.
          inv SIM_ALLOC; r_solve; et. rewrite SIM_ALLOC0 in SRES0; clarify. nia.
    Unshelve. et.
  Qed.

  Lemma sim_sfree :
    sim_fnsem wf top2
      ("sfree", fun_to_tgt "Mem" (to_stb []) (mk_pure sfree_spec))
      ("sfree", cfunU sfreeF).
  Proof.
    econs; ss. red; ss. apply isim_fun_to_tgt; ss.
    i. iIntros "[INV PRE]". des_ifs. ss.
    iDestruct "PRE" as "[PRE %]"; clarify.
    do 2 unfold has_offset, _has_offset, points_to.
    iDestruct "PRE" as (m mvs vaddr) "[[% P] A]"; des; clarify. rename H1 into LEN.
    destruct blk; clarify.
    iDestruct "A" as "[ALLOC_PRE [_ A]]".
    iDestruct "P" as "[_ P]".
    iDestruct "P" as (ofs) "[[CNT_PRE [SZ_PRE A0]] %]". rename H0 into R.
    iDestruct "INV" as (tt) "[INV %]". cleartrue.
    iDestruct "INV" as (mem_tgt mem_src) "[% MEM]".
    des; clarify. inv H1.

    unfold sfreeF. hred_r. iApply isim_pget_tgt. hred_r.
    (* prove free is safe *)
    unfold Mem.free.
    destruct Mem.range_perm_dec; cycle 1.
    { specialize (SIM_ALLOC (Some b)); ss; des.
      iCombine "MEM ALLOC_PRE SZ_PRE" as "MEM".
      iOwnWf "MEM" as wfmem. ur in wfmem. des.
      clear wfmem wfmem2 wfmem3 wfmem4. rename wfmem0 into wfalloc. rename wfmem1 into wfsz.
      exfalso. apply n. revert wfalloc wfsz. r_solve. i.
      dup wfalloc. apply Auth.auth_included in wfalloc0.
      do 2 red in wfalloc0. des. rewrite <- wfalloc0 in SIM_ALLOC. ur in SIM_ALLOC.
      unfold __allocated_with in SIM_ALLOC. destruct Pos.eq_dec; clarify.
      inv SIM_ALLOC; cycle 1.
      { ur in H1; des_ifs. }
      ur in wfalloc. des. ur in wfalloc0. specialize (wfalloc0 b).
      unfold __allocated_with in wfalloc0. destruct Pos.eq_dec; clarify.
      destruct ctx; ur in wfalloc0; clarify.
      { des_ifs; apply Qp_not_add_le_l in wfalloc0; clarify. }
      ur in RES. clarify. hexploit COMMON; et. i. clarify.
      hexploit Qfree; et. i. clarify.
      ur in wfsz. specialize (wfsz (Some b)); ss. destruct Pos.eq_dec; clarify.
      rewrite SRES in wfsz. ur in wfsz. des_ifs.
      ii. hexploit PERMinrange; et. i. des. unfold Mem.perm, Mem.perm_order'. des_ifs. }
    hred_r.
    iApply isim_pput_tgt. hred_r. iApply isim_apc. iExists None.
    hred_l. iApply isim_choose_src. iExists _. iApply isim_upd.
    iCombine "MEM CNT_PRE ALLOC_PRE" as "MEM".
    unfold _points_to, _allocated_with. ur. r_solve.
    iOwnWf "MEM" as wfmem. ur in wfmem. des.
    clear wfmem1 wfmem2 wfmem3 wfmem4. rename wfmem into wfcnt, wfmem0 into wfalloc.
    iPoseProof (OwnM_Upd with "MEM") as ">MEM".
    { eapply free_update.
      { i. hexploit (SIM_CNT b ofs0). { destruct ofs. ss. nia. }
        intro sim. revert wfcnt. r_solve. i. ur in wfcnt. des.
        apply URA.pw_extends in wfcnt. spc wfcnt.
        apply URA.pw_extends in wfcnt. spc wfcnt.
        inv sim. 2:{ rewrite <- H1 in wfcnt. unfold URA.extends in wfcnt. des. ur in wfcnt. des_ifs. }
        rewrite RES in wfcnt. unfold URA.extends in wfcnt. des. ur in wfcnt. des_ifs.
        2:{ revert Heq. case_points_to; ss. i. destruct nth_error eqn:?; clarify. apply nth_error_None in Heqo. nia. }
        revert Heq. case_points_to; ss. i. destruct nth_error eqn:?; clarify.
        unfold Q1 in Qwf. apply Qp_not_add_le_l in Qwf. clarify. }
      revert wfalloc. r_solve. i. ur in wfalloc. des.
      apply pw_extends in wfalloc. spc wfalloc. unfold __allocated_with in wfalloc.
      des_ifs. unfold URA.extends in wfalloc. des. ur in wfalloc0. spc wfalloc0.
      ur in wfalloc. ur in wfalloc0. des_ifs. apply Qp_not_add_le_l in wfalloc0. clarify. }

    iAssert ⌜URA.wf (memsz_src ⋅ __has_size (Some b) (sz m))⌝%I as "%".
    { iCombine "MEM SZ_PRE" as "MEM". iOwnWf "MEM" as wfmem. iPureIntro.
      unfold _has_size in wfmem. ur in wfmem. des. et. }
    rename H0 into wfsz.

    (* start proving conditions *)
    iModIntro. iApply isim_ret. iModIntro. iSplit; et.
    (* invariant *)
    iExists _. iSplits; ss. iPureIntro. econs; et.
    (* sim_cnt *)
    - i. hexploit (SIM_CNT b0); et. intro SIM_CNT0.
      unfold Mem.unchecked_free. ss.
      unfold update. destruct dec; clarify; cycle 1.
      { rewrite ! Maps.PMap.gso; et. }
      rewrite ! Maps.PMap.gss.
      do 2 destruct Coqlib.zle; do 2 destruct Coqlib.zlt; ss; try nia.
      rewrite LEN in g. destruct ofs; ss. nia.
    (* sim_alloc *)
    - i. des_ifs; cycle 1.
      { specialize (SIM_ALLOC None); ss. }
      unfold update. destruct dec; clarify; cycle 1.
      { specialize (SIM_ALLOC (Some b0)); ss; des. rewrite ! Maps.PMap.gso; et. }
      unfold Mem.unchecked_free. ss.
      rewrite ! Maps.PMap.gss. specialize (SIM_ALLOC (Some b0)); ss; des. et.
    - i. unfold update. des_ifs. 2:{ rewrite update_diff_blk in PRES; et. }
      rewrite update_same_blk in PRES. des_ifs. exfalso.
      ur in wfsz. specialize (wfsz (Some b0)). ss. des_ifs. ur in wfsz. des_ifs.
      destruct ofs; ss. replace intval with 0 in * by nia.
      destruct Coqlib.zle; destruct Coqlib.zlt; ss; nia.
    Unshelve. et.
  Qed.

  Lemma sim_load :
    sim_fnsem wf top2
      ("load", fun_to_tgt "Mem" (to_stb []) (mk_pure load_spec))
      ("load", cfunU loadF).
  Proof.
    econs; ss. red; ss. apply isim_fun_to_tgt; ss.
    i. iIntros "[INV PRE]". des_ifs. ss.
    do 2 unfold has_offset, _has_offset, points_to.
    iDestruct "PRE" as "[[A P] %]".
    destruct blk; clarify.
    iDestruct "A" as "[% [ALLOC_PRE [SZ1_PRE A]]]".
    des; clarify. rename H1 into LEN, H2 into CHECK, H3 into FORBID, H4 into AL.
    iDestruct "P" as "[SZ_PRE P]".
    iDestruct "P" as (ofs) "[[CNT_PRE [SZ0_PRE A0]] %]". rename H0 into R.
    des; clarify. unfold inv_with.
    iDestruct "INV" as (tt) "[INV %]". cleartrue.
    iDestruct "INV" as (mem_tgt mem_src) "[% MEM]".
    des; clarify.

    unfold loadF. hred_r.
    iApply isim_pget_tgt. hred_r.
    (* if load is safe, the proof is done easily *)
    iAssert ⌜Mem.loadv m0 mem_tgt v = Some (decode_val m0 l)⌝%I as "%"; cycle 1.
    { rewrite H0. hred_r. iApply isim_apc. iExists None.
      hred_l. iApply isim_choose_src. iExists _.
      iApply isim_ret. iSplitL "MEM".
      { iExists _. iSplit; ss. iExists _,_. iFrame. iPureIntro. split; et. }
      iSplit; ss. iExists _. iFrame. iSplit; ss. iExists _. iFrame. ss. }

    (* offset of points_to and has_offset is equal *)
    iAssert ⌜i = ofs⌝%I as "%".
    { des_ifs; cycle 1. { iDestruct "A" as "%". iDestruct "A0" as "%". des. clarify. }
      iDestruct "A" as (a) "[CONC_PRE %]". iDestruct "A0" as (a0) "[CONC0_PRE %]".
      des; clarify. iCombine "CONC_PRE CONC0_PRE" as "CONC_PRE".
      iPoseProof (_has_base_unique with "CONC_PRE") as "%". subst. et. }
    subst. inv H1.

    iCombine "MEM CNT_PRE" as "MEM". iOwnWf "MEM" as wfcnt.
    iDestruct "MEM" as "[MEM CNT_PRE]". ur in wfcnt. des.
    clear wfcnt0 wfcnt1 wfcnt2 wfcnt3 wfcnt4.
    ur in wfcnt. rewrite URA.unit_idl in wfcnt. des. apply pw_extends in wfcnt.
    spc wfcnt. apply pw_extends in wfcnt. red in wfcnt. do 2 ur in wfcnt0.

    (* prove safety of load with only sim_cnt *)
    assert (Mem.load m0 mem_tgt b (Ptrofs.unsigned ofs) = Some (decode_val m0 l)).
    - unfold Mem.load. des_ifs; cycle 1.
      + exfalso. apply n. split; cycle 1.
        { etrans; et. destruct m0; ss; solve [exists 1;ss|exists 2;ss|exists 4;ss|exists 8;ss]. }
        unfold Mem.range_perm. i. spc wfcnt. unfold __points_to in wfcnt.
        case_points_to; ss; try nia; cycle 1.
        { destruct m0; unfold size_chunk_nat in *; ss; nia. }
        destruct nth_error eqn: ?; cycle 1. { rewrite nth_error_None in *. nia. }
        apply Consent.extends in wfcnt; et.
        red in wfcnt. des. do 2 spc SIM_CNT.
        hexploit SIM_CNT. { destruct ofs; ss; nia. }
        intro sim. rewrite wfcnt1 in sim.
        inv sim. clarify. unfold Mem.perm. rewrite PERM. et.
      + replace (Mem.getN _ _ _) with l in *.
        { rewrite pure_memval_good_decode; et. }
        apply nth_error_ext. i.
        destruct (Coqlib.zlt i (size_chunk_nat m0)); cycle 1.
        { edestruct nth_error_None. rewrite H1; try nia.
          edestruct nth_error_None. rewrite H3; et. rewrite Mem.getN_length. nia. }
        rewrite nth_error_getN; try nia.
        specialize (wfcnt (Ptrofs.unsigned ofs + i)).
        unfold __points_to in wfcnt.
        case_points_to; ss; try nia.
        destruct nth_error eqn: ?; cycle 1. { rewrite nth_error_None in *. nia. }
        apply Consent.extends in wfcnt; et.
        red in wfcnt. des. spc SIM_CNT.
        specialize (SIM_CNT (Ptrofs.unsigned ofs + i)).
        hexploit SIM_CNT. { destruct ofs; ss; nia. }
        intro sim. rewrite wfcnt1 in sim. inv sim. clarify. rewrite <- Heqo. f_equal. nia.
    (* prove safety of loadv *)
    - unfold Mem.loadv.
      destruct v; clarify; des; cycle 1.
      (* case: ptr *)
      { iDestruct "A" as "%". iDestruct "A0" as "%". des. clarify. }
      (* case: long *)
      des_ifs_safe.
      iDestruct "A" as (a) "[CONC_PRE %]".
      iDestruct "A0" as (a0) "[CONC0_PRE %]".
      des; clarify.
      iCombine "CONC_PRE CONC0_PRE" as "CONC_PRE".
      iPoseProof (_has_base_unique with "CONC_PRE") as "%". subst.
      iDestruct "CONC_PRE" as "[CONC_PRE _]".
      iCombine "MEM CONC_PRE" as "MEM". iOwnWf "MEM" as wfmem.
      iDestruct "MEM" as "[MEM CONC_PRE]". ur in wfmem. des.
      clear wfmem wfmem0 wfmem1 wfmem3 wfmem4. rename wfmem2 into wfconc.

      (* physical address is larger than base address *)
      ur in wfconc. specialize (wfconc (Some b)). ss. destruct Archi.ptr64 eqn:?; clarify.
      destruct Pos.eq_dec; clarify.
      apply OneShot.oneshot_initialized in wfconc. des.
      all: specialize (SIM_CONC (Some b)); ss; rewrite wfconc in SIM_CONC; inv SIM_CONC; clarify.
      replace (Ptrofs.unsigned (Ptrofs.sub (Ptrofs.of_int64 i) base)) with (Ptrofs.unsigned (Ptrofs.repr (Int64.unsigned i - Ptrofs.unsigned base))) in *; cycle 1.
      { unfold Ptrofs.sub, Ptrofs.of_int64. rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)) ; try apply Int64.unsigned_range_2. et. }
      assert (0 ≤ Int64.unsigned i - Ptrofs.unsigned base ≤ Ptrofs.max_unsigned).
      { split; cycle 1. { destruct i; destruct base; ss. change Int64.modulus with Ptrofs.modulus in *. change Ptrofs.max_unsigned with (Ptrofs.modulus - 1). nia. }
        destruct (Coqlib.zle 0 (Int64.unsigned i - Ptrofs.unsigned base)); et.
        exfalso. rewrite Ptrofs.unsigned_repr_eq in *.
        replace (Int64.unsigned i - Ptrofs.unsigned base) with (- (Ptrofs.unsigned base - Int64.unsigned i)) in * by nia.
        rewrite Z_mod_nz_opp_full in *; [>rewrite Z.mod_small in *|rewrite Z.mod_small..].
        all: try nia; destruct base; destruct i; ss; try nia.
        change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
      rewrite Ptrofs.unsigned_repr in *; et.

      hexploit wfcnt.
      instantiate (1:= Int64.unsigned i - Ptrofs.unsigned base). intros wfcnt_spc.
      unfold __points_to in wfcnt_spc. case_points_to; ss; try nia; cycle 1.
      { destruct m0; unfold size_chunk_nat in *; ss; nia. }
      destruct nth_error eqn: ?; cycle 1. { rewrite nth_error_None in *. nia. }
      apply Consent.extends in wfcnt_spc; et.
      red in wfcnt_spc. des. hexploit SIM_CNT; et. rewrite wfcnt_spc0. intro sim. inv sim.
      clarify. unfold Mem.denormalize.

      destruct Maps.PTree.select eqn: X; first [apply Maps.PTree.gselectf in X|apply Maps.PTree.gselectnf in X]; des; cycle 1.
      { exfalso. apply X. esplits; et. unfold Mem.denormalize_aux, Mem.addr_is_in_block, Mem.is_valid.
        rewrite <- H8. des_ifs; bsimpl; ss; cycle 1.
        { hexploit mem_tgt.(Mem.access_max). rewrite PERM. rewrite Heq1. i. clarify. }
        change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *.
        des; try nia. rewrite Pos.ltb_ge in Heq0.
        rewrite Mem.nextblock_noaccess in Heq1; unfold Coqlib.Plt; try nia; clarify. }
      destruct p0. unfold Mem.denormalize_aux, Mem.is_valid, Mem.addr_is_in_block in *.
      destruct Int64.eq eqn:?.
      { exfalso. unfold Int64.eq in Heqb1. destruct Coqlib.zeq; clarify.
        change (Int64.unsigned Int64.zero) with 0%Z in e1. rewrite e1 in *.
        hexploit H5; i; clarify. destruct base. ss. nia. }
      des_ifs; bsimpl; clarify. des.
      rewrite Ptrofs.unsigned_repr. 2:{ change Ptrofs.max_unsigned with (Ptrofs.modulus - 1). nia. }
      hexploit (Mem.no_concrete_overlap mem_tgt (Int64.unsigned i) p0 b).
      { econs; et. nia. }
      { econs; et.
        - hexploit mem_tgt.(Mem.access_max). rewrite PERM. intro P. red in P. des_ifs. et.
        - change Ptrofs.modulus with (Ptrofs.max_unsigned + 1). nia. }
      i. subst. rewrite <- H8 in *. clarify.
  Unshelve. all: et.
  Qed.

  Lemma sim_store :
    sim_fnsem wf top2
      ("store", fun_to_tgt "Mem" (to_stb []) (mk_pure store_spec))
      ("store", cfunU storeF).
  Proof.
    econs; ss. red; ss. apply isim_fun_to_tgt; ss.
    i. iIntros "[INV PRE]". des_ifs. ss.
    do 2 unfold has_offset, _has_offset, points_to.
    iDestruct "PRE" as "[PRE %]"; clarify.
    iDestruct "PRE" as (mvs_old) "[A P]".
    destruct blk; clarify.
    iDestruct "A" as "[% [ALLOC_PRE [SZ1_PRE A]]]".
    iDestruct "P" as "[SZ_PRE P]".
    iDestruct "P" as (ofs) "[[CNT_PRE [SZ0_PRE A0]] %]".
    des; clarify. rename H2 into LEN, H3 into AL, H1 into R.
    unfold inv_with. iDestruct "INV" as (tt) "[INV %]". cleartrue.
    iDestruct "INV" as (mem_tgt mem_src) "[% MEM]".
    des; clarify. inv H1.

    unfold storeF. hred_r. iApply isim_pget_tgt. hred_r.

    iAssert ⌜i = ofs⌝%I as "%"; clarify.
    { des_ifs; cycle 1. { iDestruct "A" as "%". iDestruct "A0" as "%". des. clarify. }
      iDestruct "A" as (a) "[CONC_PRE %]". iDestruct "A0" as (a0) "[CONC0_PRE %]".
      des; clarify. iCombine "CONC_PRE CONC0_PRE" as "CONC_PRE".
      iPoseProof (_has_base_unique with "CONC_PRE") as "%". subst. et. }

    iCombine "MEM CNT_PRE SZ_PRE" as "MEM". iOwnWf "MEM" as wfcnt.
    iDestruct "MEM" as "[MEM [CNT_PRE SZ_PRE]]". ur in wfcnt. des.
    clear wfcnt0 wfcnt2 wfcnt3 wfcnt4. rename wfcnt1 into wfsz.
    revert wfcnt wfsz. r_solve. i.
    ur in wfcnt. rewrite URA.unit_idl in wfcnt. des. apply pw_extends in wfcnt.
    spc wfcnt. apply pw_extends in wfcnt. red in wfcnt. do 2 ur in wfcnt0.

    (* check whether it is valid access *)
    assert (Mem.valid_access mem_tgt m0 b (Ptrofs.unsigned ofs) Writable).
    { split; cycle 1.
      { etrans; et. destruct m0; ss; solve [exists 1;ss|exists 2;ss|exists 4;ss|exists 8;ss]. }
      unfold Mem.range_perm. i. spc wfcnt. unfold __points_to in wfcnt.
      case_points_to; ss; try nia; cycle 1.
      { destruct m0; unfold size_chunk_nat in *; ss; nia. }
      destruct nth_error eqn: ?; cycle 1. { rewrite nth_error_None in *. nia. }
      apply Consent.extends in wfcnt; et.
      red in wfcnt. des. do 2 spc SIM_CNT.
      hexploit SIM_CNT. { destruct ofs; ss; nia. }
      intro sim. rewrite wfcnt1 in sim.
      inv sim. clarify. assert (Q1 = q0) by now eapply antisymmetry; et.
      subst. unfold Mem.perm. rewrite PERM. hexploit Qwrite; et. }

    iCombine "MEM CNT_PRE" as "MEM". ur. r_solve.

    (* resource update *)
    iPoseProof (OwnM_Upd with "MEM") as ">[MEM MEM_POST]".
    { hexploit store_update. 3: i; apply H1.
      instantiate (1:= encode_val m0 v). rewrite encode_val_length; et.
      i. spc wfcnt. do 2 spc wfcnt0. unfold __points_to in wfcnt.
      destruct Pos.eq_dec; destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia.
      destruct nth_error eqn:?. 2:{ apply nth_error_None in Heqo. nia. }
      unfold URA.extends in wfcnt. des. ur in wfcnt. ur in wfcnt0. des_ifs.
      { apply Qp_not_add_le_l in wfcnt0. clarify. }
      case_points_to; ss; try nia. des_ifs. }
    (* storev is safe *)
    unfold Mem.storev, Mem.store. destruct v0; clarify; des; cycle 1.
    (* case: ptr *)
    - iDestruct "A" as "%". iDestruct "A0" as "%". des. clarify.
      des_ifs. hred_r. iApply isim_pput_tgt. hred_r.
      iApply isim_apc. iExists None.
      hred_l. iApply isim_choose_src. iExists _.
      iApply isim_ret. iSplitL "MEM"; cycle 1.
      { iSplit; ss. iExists _. iFrame. iSplit; ss. iExists _.
        unfold _points_to. iFrame. rewrite encode_val_length.
        i. iPureIntro. splits; et; nia. }
      iExists _. iSplit; ss. iExists _,_. iFrame. iPureIntro.
      split; et. econs; ss; et; cycle 1.
      + i. spc SIM_ALLOC. des_ifs. des. split; et.
        destruct (dec b b0); try solve [rewrite Maps.PMap.gso; et].
        subst. rewrite Maps.PMap.gss. inv SIM_ALLOC; et. econs; et. i.
        spc DYNAMIC. des. rewrite Mem.getN_setN_outside; et.
        unfold size_chunk_nat, size_chunk. destruct i; des_ifs; ss; nia.
      + i. ur in wfsz. specialize (wfsz (Some b)). ss. des_ifs.
        destruct (Pos.eq_dec b b0); clarify; cycle 1.
        { rewrite update_diff_blk in PRES; et. }
        ur in wfsz. des_ifs. specialize (wfcnt ofs). specialize (wfcnt0 b0 ofs).
        unfold URA.extends in wfcnt. des.
        rewrite update_same_blk in PRES.
        rewrite encode_val_length in PRES.
        destruct Coqlib.zle, Coqlib.zlt; ss; try nia; et.
        destruct nth_error eqn:?. 2:{ apply nth_error_None in Heqo. clarify. }
        revert wfcnt. case_points_to; ss; try nia; i.
        destruct (nth_error mvs_old) eqn:?. 2:{ apply nth_error_None in Heqo0. nia. }
        rewrite <- wfcnt in wfcnt0. ur in wfcnt0. des_ifs; ur in wfcnt; des_ifs.
        { apply Qp_not_add_le_l in wfcnt0. clarify. }
        eapply SIM_CA. 2: et. 2: et. nia.
      + i. unfold update. destruct dec; try solve [rewrite Maps.PMap.gso; et].
        subst. rewrite Maps.PMap.gss. do 3 spc SIM_CNT.
        des_ifs; cycle 1.
        { rewrite Mem.setN_outside; et. bsimpl; des; first [destruct Coqlib.zle|destruct Coqlib.zlt]; ss; try nia. }
        destruct Coqlib.zle, Coqlib.zlt in Heq; ss; try nia.
        erewrite setN_inside; et; cycle 1.
        spc wfcnt. unfold __points_to in wfcnt.
        rewrite encode_val_length in l0.
        destruct Pos.eq_dec, Coqlib.zle, Coqlib.zlt in wfcnt; ss; try nia.
        destruct nth_error eqn: ?; cycle 1. { rewrite nth_error_None in Heqo. nia. }
        inv SIM_CNT; [rewrite RES in wfcnt| rewrite <- H5 in wfcnt].
        all: unfold URA.extends in wfcnt; do 2 ur in wfcnt; des; des_ifs; cycle 1.
        econs; et. apply Qp_not_add_le_l in Qwf. ss.
    (* case: long *)
    - des_ifs_safe.
      iDestruct "A" as (a) "[CONC_PRE %]".
      iDestruct "A0" as (a0) "[CONC0_PRE %]".
      des; clarify.
      iCombine "CONC_PRE CONC0_PRE" as "CONC_PRE".
      iPoseProof (_has_base_unique with "CONC_PRE") as "%". subst.
      iDestruct "CONC_PRE" as "[CONC_PRE _]".
      iCombine "MEM CONC_PRE" as "MEM". iOwnWf "MEM" as wfmem.
      iDestruct "MEM" as "[MEM CONC_PRE]". ur in wfmem. des.
      clear wfmem wfmem0 wfmem1 wfmem3 wfmem4. rename wfmem2 into wfconc.

      (* physical address is larger than base address *)
      ur in wfconc.
      specialize (wfconc (Some b)). ss. destruct Pos.eq_dec; clarify.
      apply OneShot.oneshot_initialized in wfconc. des. dup SIM_CONC.
      all: specialize (SIM_CONC (Some b)); ss; rewrite wfconc in SIM_CONC; inv SIM_CONC; clarify.
      replace (Ptrofs.unsigned (Ptrofs.sub (Ptrofs.of_int64 i) base)) with (Ptrofs.unsigned (Ptrofs.repr (Int64.unsigned i - Ptrofs.unsigned base))) in *; cycle 1.
      { unfold Ptrofs.sub, Ptrofs.of_int64. rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)) ; try apply Int64.unsigned_range_2. et. }
      hexploit (@paddr_no_overflow_cond i base (sz m)); try nia.
      { unfold Ptrofs.sub, Ptrofs.of_int64. rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)); try nia. apply Int64.unsigned_range_2. }
      i. rewrite Ptrofs.unsigned_repr in *; et; try solve [destruct base; ss; nia].

      dup wfcnt. hexploit wfcnt.
      instantiate (1:= Int64.unsigned i - Ptrofs.unsigned base). intros wfcnt_spc.
      unfold __points_to in wfcnt_spc. case_points_to; ss; try nia; cycle 1.
      { destruct m0; unfold size_chunk_nat in *; ss; nia. }
      destruct nth_error eqn: ?; cycle 1. { rewrite nth_error_None in *. nia. }
      apply Consent.extends in wfcnt_spc; et.
      red in wfcnt_spc. des. hexploit SIM_CNT; et. rewrite wfcnt_spc0. intro sim.
      inv sim. clarify. unfold Mem.denormalize.

      destruct Maps.PTree.select eqn: X; first [apply Maps.PTree.gselectf in X|apply Maps.PTree.gselectnf in X]; des; cycle 1.
      { exfalso. apply X. esplits; et. unfold Mem.denormalize_aux, Mem.addr_is_in_block, Mem.is_valid.
        des_ifs; bsimpl; ss; cycle 1.
        { hexploit mem_tgt.(Mem.access_max). rewrite PERM. rewrite Heq2. i. clarify. }
        change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *.
        des; try solve [destruct base; ss; nia]. rewrite Pos.ltb_ge in Heq1.
        rewrite Mem.nextblock_noaccess in Heq2; unfold Coqlib.Plt; try nia; clarify. }
      destruct p0. unfold Mem.denormalize_aux, Mem.is_valid, Mem.addr_is_in_block in *.
      rewrite X in X0.
      replace i0 with p0 in * by now des_ifs; bsimpl; clarify.
      replace p0 with b in *; cycle 1.
      { des_ifs; bsimpl; clarify; apply (Mem.no_concrete_overlap mem_tgt (Int64.unsigned i)); cycle 1.
        { econs; et. nia. } econs; et.
        { hexploit mem_tgt.(Mem.access_max). rewrite PERM. intro P. red in P. des_ifs. et. }
        { change Ptrofs.modulus with (Ptrofs.max_unsigned + 1). destruct base; ss; nia. } }
      rewrite X in *. clarify. des_ifs; bsimpl; clarify. hred_r.
      iApply isim_pput_tgt. hred_r. iApply isim_apc. iExists None.
      hred_l. iApply isim_choose_src. iExists _.
      iApply isim_ret. iSplitL "MEM"; cycle 1.
      + iSplit; ss. iExists _. iFrame.
        rewrite _has_base_dup. iDestruct "CONC_PRE" as "[? CONC_PRE]".
        iSplitL "CONC_PRE"; iFrame.
        { iSplit; ss. iExists _. iFrame. ss. }
        iExists (Ptrofs.repr (Int64.unsigned i - Ptrofs.unsigned base)).
        rewrite Ptrofs.unsigned_repr; try solve [destruct base; ss; nia]. iFrame.
        rewrite encode_val_length. iSplits; iFrame; ss; iPureIntro; try nia.
        unfold Ptrofs.sub, Ptrofs.of_int64.
        rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)); et.
        destruct i; ss; nia.
      + iExists _. iSplit; ss. iExists _,_. iFrame. iPureIntro.
        split; et. econs; ss; et; cycle 1.
        * i. spc SIM_ALLOC. des_ifs. des. split; et.
          destruct (dec b b0); try solve [rewrite Maps.PMap.gso; et].
          subst. rewrite Maps.PMap.gss. inv SIM_ALLOC; et. econs; et. i.
          spc DYNAMIC. des. rewrite Mem.getN_setN_outside; et.
        * i. ur in wfsz. specialize (wfsz (Some b)). ss. des_ifs.
          destruct (Pos.eq_dec b b0); clarify; cycle 1.
          { rewrite update_diff_blk in PRES; et. }
          ur in wfsz. des_ifs. specialize (wfcnt ofs). specialize (wfcnt0 b0 ofs).
          unfold URA.extends in wfcnt. des.
          rewrite update_same_blk in PRES.
          destruct Coqlib.zle, Coqlib.zlt; ss; try nia; et.
          destruct nth_error eqn:? in PRES. 2:{ apply nth_error_None in Heqo0. clarify. }
          rewrite encode_val_length in l2.
          revert wfcnt. case_points_to; ss; try nia; i.
          destruct nth_error eqn:? in wfcnt. 2:{ apply nth_error_None in Heqo1. nia. }
          rewrite <- wfcnt in wfcnt0. ur in wfcnt0. des_ifs; ur in wfcnt; des_ifs.
          { apply Qp_not_add_le_l in wfcnt0. clarify. }
          eapply SIM_CA. 2: et. 2: et. nia.
        * i. unfold update. destruct dec; try solve [rewrite Maps.PMap.gso; et].
          subst. rewrite Maps.PMap.gss. specialize (SIM_CNT b0 ofs POSOFS).
          des_ifs; cycle 1.
          { rewrite Mem.setN_outside; et.
            bsimpl; des; first [destruct Coqlib.zle|destruct Coqlib.zlt]; ss; try nia. }
          erewrite setN_inside; et; cycle 1.
          { destruct Coqlib.zle; destruct Coqlib.zlt; ss. }
          specialize (wfcnt ofs). unfold __points_to in wfcnt. revert wfcnt. case_points_to; ss.
          rewrite encode_val_length in l2. destruct Coqlib.zlt; ss; try nia. i.
          destruct nth_error eqn: ? in wfcnt; cycle 1. { rewrite nth_error_None in *. nia. }
          inv SIM_CNT; [rewrite RES in *| rewrite <- H9 in *].
          all: unfold URA.extends in wfcnt; do 2 ur in wfcnt; des; des_ifs; cycle 1.
          econs; et. apply Qp_not_add_le_l in Qwf0. ss.
  Unshelve. all: et. { apply Eqsth. } { apply Qp_le_po. }
  Qed.


  Lemma sim_sub_ptr :
    sim_fnsem wf top2
      ("sub_ptr", fun_to_tgt "Mem" (to_stb []) (mk_pure sub_ptr_spec))
      ("sub_ptr", cfunU sub_ptrF).
  Proof.
    econs; ss. red; ss. apply isim_fun_to_tgt; ss.
    i. iIntros "[INV PRE]". des_ifs. ss.
    do 2 unfold has_offset, _has_offset, points_to, _points_to.
    iDestruct "PRE" as "[[[% A] P] %]"; des; clarify.
    destruct blk; clarify.
    iDestruct "A" as "[ALLOC_PRE [SZ1_PRE A]]".
    iDestruct "P" as "[ALLOC_PRE0 [SZ_PRE P]]".
    unfold inv_with.
    iDestruct "INV" as (tt) "[INV %]".
    iDestruct "INV" as (mem_tgt memcnt_src memalloc_src memsz_src memconc_src) "[[[[% CNT] ALLOC] CONC] SZ]".
    des; clarify.

    unfold sub_ptrF. hred_r.
    iApply isim_pget_tgt. hred_r.
    destruct Coqlib.zlt; destruct Coqlib.zle; ss; try nia. hred_r.
    iAssert ⌜Cop._sem_ptr_sub_join_common v0 v mem_tgt = Some (Ptrofs.sub i0 i)⌝%I as "%"; cycle 1.
    { rewrite H4. hred_r.
      iApply isim_apc. iExists None.
      hred_l. iApply isim_choose_src. iExists _.
      iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
      { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
      iSplit; ss. iFrame. iPureIntro. do 2 f_equal.
      unfold Ptrofs.divs, Ptrofs.sub. f_equal.
      rewrite (Ptrofs.signed_repr z). 2:{ split; et. change Ptrofs.min_signed with (- Ptrofs.max_signed - 1). nia. }
      f_equal. rewrite Ptrofs.signed_repr; et. }
    destruct v; destruct v0; clarify; des_ifs.
    - ss. des_ifs.
      iDestruct "A" as (a) "[CONC_PRE %]".
      iDestruct "P" as (a0) "[CONC0_PRE %]".
      des; clarify.
      iCombine "CONC_PRE CONC0_PRE" as "CONC_PRE".
      iPoseProof (_has_base_unique with "CONC_PRE") as "%". subst.
      iDestruct "CONC_PRE" as "[CONC_PRE _]".
      iPureIntro. f_equal.
      rewrite !(Ptrofs.sub_add_opp _ a0).
      rewrite Ptrofs.sub_shifted.
      rewrite Ptrofs.sub_add_opp.
      rewrite Int64.sub_add_opp.
      rewrite ptrofs_int64_add; et.
      do 2 f_equal. clear. rewrite ptrofs_int64_neg; et.
      rewrite Ptrofs.to_int64_of_int64; et.
    - iDestruct "A" as "%".
      iDestruct "P" as (a0) "[CONC0_PRE %]".
      des; clarify. ss. unfold Cop._sem_ptr_sub_join. ss.
      iCombine "CONC CONC0_PRE" as "CONC".
      iOwnWf "CONC" as wfconc.
      assert (IntPtrRel.to_int_val mem_tgt (Vptr b i2) = Vlong (Int64.repr (Ptrofs.unsigned a0 + Ptrofs.unsigned i2))).
      { ur in wfconc. specialize (wfconc (Some b)). specialize (SIM_CONC (Some b)).
        ss. destruct dec; clarify.
        apply OneShot.oneshot_initialized in wfconc.
        des; rewrite wfconc in *; inv SIM_CONC; clarify.
        unfold to_int_val, Mem.to_int, Mem.ptr2int_v, Mem.ptr2int.
        rewrite <- H14. des_ifs. }
      assert (0 ≤ Int64.unsigned i1 - Ptrofs.unsigned a0 ≤ sz m).
      { ii. unfold weak_valid in *. apply paddr_no_overflow_cond; et. }
      assert (Ptrofs.of_int64 (Int64.sub (Int64.repr (Ptrofs.unsigned a0 + Ptrofs.unsigned i2)) i1) = Ptrofs.sub i2 (Ptrofs.sub (Ptrofs.of_int64 i1) a0)).
      { unfold Ptrofs.of_int64, Ptrofs.sub, Int64.sub. apply Ptrofs.eqm_samerepr.
        rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)).
        2:{ apply Int64.unsigned_range_2. }
        rewrite (Ptrofs.unsigned_repr (_ - _)).
        2:{ destruct a0; ss; nia. }
        rewrite <- Ptrofs.eqm64; et. apply Int64.eqm_sym.
        eapply Int64.eqm_trans. 2:{ apply Int64.eqm_unsigned_repr. }
        eapply Int64.eqm_trans.
        2:{ eapply Int64.eqm_sub. apply Int64.eqm_unsigned_repr. apply Int64.eqm_refl. }
        apply Int64.eqm_refl2. nia. }
      rewrite H4. ss. des_ifs_safe. des_ifs; try solve [iPureIntro; f_equal; et].
      { iPureIntro. f_equal. hexploit Ptrofs.eq_spec. rewrite Heq2. i. rewrite H16. et. }
      unfold to_ptr_val, Mem.to_ptr in Heq3. des_ifs. ss. clarify.
      unfold Mem.denormalize in Heq4. apply Maps.PTree.gselectf in Heq4.
      des. unfold Mem.denormalize_aux, Mem.is_valid, Mem.addr_is_in_block in Heq3.
      des_ifs; bsimpl; des; clarify.
      exfalso. hexploit Ptrofs.eq_spec. rewrite Heq2. i. apply H17.
      rewrite H14. f_equal. unfold Ptrofs.sub, Ptrofs.of_int64.
      rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)).
      2:{ apply Int64.unsigned_range_2. }
      ur in wfconc. specialize (wfconc (Some b0)). specialize (SIM_CONC (Some b0)). ss.
      destruct dec; clarify.
      apply OneShot.oneshot_initialized in wfconc.
      des; rewrite wfconc in *; inv SIM_CONC; clarify.
      rewrite Heq5 in *. clarify.
    - iDestruct "A" as (a) "[CONC_PRE %]".
      iDestruct "P" as "%".
      des; clarify. ss. unfold Cop._sem_ptr_sub_join. ss.
      iCombine "CONC CONC_PRE" as "CONC".
      iOwnWf "CONC" as wfconc.
      assert (IntPtrRel.to_int_val mem_tgt (Vptr b i1) = Vlong (Int64.repr (Ptrofs.unsigned a + Ptrofs.unsigned i1))).
      { ur in wfconc. specialize (wfconc (Some b)). specialize (SIM_CONC (Some b)).
        ss. destruct dec; clarify.
        apply OneShot.oneshot_initialized in wfconc.
        des; rewrite wfconc in *; inv SIM_CONC; clarify.
        unfold to_int_val, Mem.to_int, Mem.ptr2int_v, Mem.ptr2int.
        rewrite <- H12. des_ifs. }
      assert (0 ≤ Int64.unsigned i2 - Ptrofs.unsigned a ≤ sz m).
      { ii. unfold weak_valid in *. apply paddr_no_overflow_cond; et. }
      assert (Ptrofs.of_int64 (Int64.sub i2 (Int64.repr (Ptrofs.unsigned a + Ptrofs.unsigned i1))) = Ptrofs.sub (Ptrofs.sub (Ptrofs.of_int64 i2) a) i1).
      { unfold Ptrofs.of_int64, Ptrofs.sub, Int64.sub. apply Ptrofs.eqm_samerepr.
        rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)).
        2:{ apply Int64.unsigned_range_2. }
        rewrite (Ptrofs.unsigned_repr (_ - _)).
        2:{ destruct a; ss; nia. }
        rewrite <- Ptrofs.eqm64; et. apply Int64.eqm_sym.
        eapply Int64.eqm_trans. 2:{ apply Int64.eqm_unsigned_repr. }
        eapply Int64.eqm_trans.
        2:{ eapply Int64.eqm_sub. apply Int64.eqm_refl. apply Int64.eqm_unsigned_repr. }
        apply Int64.eqm_refl2. nia. }
      rewrite H4. unfold to_ptr_val at 2. unfold Cop._sem_ptr_sub.
      ss. des_ifs_safe. des_ifs; try solve [iPureIntro; f_equal; et].
      { iPureIntro. f_equal. hexploit Ptrofs.eq_spec. rewrite Heq2. i. rewrite H16. et. }
      unfold to_ptr_val, Mem.to_ptr in Heq3. des_ifs. ss. clarify.
      unfold Mem.denormalize in Heq4. apply Maps.PTree.gselectf in Heq4.
      des. unfold Mem.denormalize_aux, Mem.is_valid, Mem.addr_is_in_block in Heq3.
      des_ifs; bsimpl; des; clarify.
      exfalso. hexploit Ptrofs.eq_spec. rewrite Heq2. i. apply H17.
      rewrite H12. f_equal. unfold Ptrofs.sub, Ptrofs.of_int64.
      rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)).
      2:{ apply Int64.unsigned_range_2. }
      ur in wfconc. specialize (wfconc (Some b)). specialize (SIM_CONC (Some b)). ss.
      destruct dec; clarify.
      apply OneShot.oneshot_initialized in wfconc.
      des; rewrite wfconc in *; inv SIM_CONC; clarify.
      rewrite Heq5 in *. clarify.
    - iDestruct "P" as "%".
      iDestruct "A" as "%".
      des. clarify. ss. des_ifs.
    Unshelve. et.
  Qed.

  Lemma sim_cmp_ptr :
    sim_fnsem wf top2
      ("cmp_ptr", fun_to_tgt "Mem" (to_stb []) (mk_pure cmp_ptr_spec))
      ("cmp_ptr", cfunU cmp_ptrF).
  Proof.
    econs; ss. red; ss. apply isim_fun_to_tgt; ss.
    i. unfold "@".
    iIntros "[INV PRE]".
    iDestruct "INV" as (tt) "[INV %]".
    iDestruct "INV" as (mem_tgt memcnt_src memalloc_src memsz_src memconc_src) "[[[[% CNT] ALLOC] CONC] SZ]".
    des; clarify. unfold cmp_ptrF. do 8 (try destruct x as [?|x]).
    - ss. iDestruct "PRE" as "%". des. clarify. hred_r.
      iApply isim_pget_tgt. hred_r. destruct Vnullptr eqn:?; clarify.
      rewrite <- Heqv. unfold cmp_ptr. des_ifs_safe.
      unfold Val.cmplu_bool. destruct Vnullptr eqn:?; clarify.
      hred_r.
      iApply isim_apc. iExists None.
      hred_l. iApply isim_choose_src. iExists _.
      iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
      { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
      iSplit; ss. iPureIntro. unfold Vnullptr in Heqv0. des_ifs.
    - unfold cmp_ptr_hoare1. des_ifs_safe. ss. clarify.
      iDestruct "PRE" as "[[% P] %]".
      do 2 unfold has_offset, _has_offset.
      destruct blk eqn:?; clarify.
      iDestruct "P" as "[ALLOC_PRE0 [SZ_PRE P]]".
      des; clarify. hred_r.
      iApply isim_pget_tgt. hred_r. destruct Vnullptr eqn:?; clarify.
      destruct v; clarify; des_ifs_safe.
      + iDestruct "P" as (a) "[CONC_PRE %]". des. clarify.
        unfold cmp_ptr. des_ifs_safe. ss. hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. destruct (Int64.eq i0 i1) eqn: ?.
        { apply Int64.same_if_eq in Heqb0. subst.
          unfold Vnullptr in Heqv0. des_ifs. exfalso.
          eapply weak_valid_nil_paddr_base; et. ii.
          hexploit H6; clarify. }
        iSplit; ss. iExists _. iFrame. iPureIntro. splits; ss.
      + iDestruct "P" as "%". des. clarify.
        unfold cmp_ptr. des_ifs_safe. unfold Vnullptr in Heqv0. clarify.
        rewrite Int64.eq_true. ss. des_ifs_safe. rewrite Int64.eq_true. ss.
        iCombine "ALLOC ALLOC_PRE0" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz. dup SIM_ALLOC.
        ur in wfalloc. des. rewrite URA.unit_idl in wfalloc.
        ur in wfalloc0. apply pw_extends in wfalloc. spc wfalloc.
        ur in wfsz. specialize (wfsz (Some b)). specialize (SIM_ALLOC (Some b)).
        unfold __allocated_with in *. ss.
        destruct dec; clarify. apply Consent.extends in wfalloc; et. red in wfalloc. des.
        rewrite wfalloc1 in *. apply OneShot.oneshot_initialized in wfsz.
        des; rewrite wfsz in *; inv SIM_ALLOC; clarify.
        unfold weak_valid in *. destruct m. ss. rewrite Heqo in *.
        hexploit SZPOS; et. i.
        assert (Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1)
                || Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1 - 1) = true).
        { bsimpl. unfold Mem.valid_pointer.
          do 2 destruct Mem.perm_dec; ss; et.
          exfalso. dup PERMinrange.
          specialize (PERMinrange (Ptrofs.unsigned i1)).
          specialize (PERMinrange0 (Ptrofs.unsigned i1 - 1)).
          unfold size_chunk in *. des_ifs.
          assert (init ≤ 0) by now destruct tag; try solve [hexploit COMMON; et; nia|hexploit DYNAMIC; et; des; nia].
          unfold Mem.perm in *.
          assert (init ≤ Ptrofs.unsigned i1 < sz \/ init ≤ Ptrofs.unsigned i1 - 1 < sz) by now destruct i1; ss; nia.
          destruct H8.
          { spc PERMinrange. des. rewrite PERMinrange in *. apply n. econs. }
          { spc PERMinrange0. des. rewrite PERMinrange0 in *. apply n0. econs. } }
        rewrite H6. hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iDestruct "ALLOC" as "[ALLOC ?]".
        iDestruct "SZ" as "[SZ ?]".
        iApply isim_ret. iSplitL "CNT CONC ALLOC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. ss.
    - unfold cmp_ptr_hoare2. des_ifs_safe. ss. clarify.
      iDestruct "PRE" as "[[% P] %]".
      do 2 unfold has_offset, _has_offset.
      destruct blk eqn:?; clarify.
      iDestruct "P" as "[ALLOC_PRE0 [SZ_PRE P]]".
      des; clarify. hred_r.
      iApply isim_pget_tgt. hred_r. destruct Vnullptr eqn:?; clarify.
      destruct v; clarify; des_ifs_safe.
      + iDestruct "P" as (a) "[CONC_PRE %]". des. clarify.
        unfold cmp_ptr. des_ifs_safe. ss. hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. destruct (Int64.eq i0 i1) eqn: ?.
        { apply Int64.same_if_eq in Heqb0. subst.
          unfold Vnullptr in Heqv0. des_ifs.
          unfold Ptrofs.sub in H5. change (Ptrofs.unsigned (Ptrofs.of_int64 _)) with 0%Z in H5.
          exfalso. eapply weak_valid_nil_paddr_base; et. ii.
          hexploit H6; clarify. }
        iSplit; ss. iExists _. iFrame. iPureIntro. splits; ss.
      + iDestruct "P" as "%". des. clarify.
        unfold cmp_ptr. des_ifs_safe. unfold Vnullptr in Heqv0. clarify.
        rewrite Int64.eq_true. ss. des_ifs_safe. rewrite Int64.eq_true. ss.
        iCombine "ALLOC ALLOC_PRE0" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz. dup SIM_ALLOC.
        ur in wfalloc. des. rewrite URA.unit_idl in wfalloc.
        ur in wfalloc0. apply pw_extends in wfalloc. spc wfalloc.
        ur in wfsz. specialize (wfsz (Some b)). specialize (SIM_ALLOC (Some b)).
        unfold __allocated_with in *. ss.
        destruct dec; clarify. apply Consent.extends in wfalloc; et. red in wfalloc. des.
        rewrite wfalloc1 in *. apply OneShot.oneshot_initialized in wfsz.
        des; rewrite wfsz in *; inv SIM_ALLOC; clarify.
        unfold weak_valid in *. destruct m. ss. rewrite Heqo in *.
        hexploit SZPOS; et. i.
        assert (Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1)
                || Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1 - 1) = true).
        { bsimpl. unfold Mem.valid_pointer.
          do 2 destruct Mem.perm_dec; ss; et.
          exfalso. dup PERMinrange.
          specialize (PERMinrange (Ptrofs.unsigned i1)).
          specialize (PERMinrange0 (Ptrofs.unsigned i1 - 1)).
          unfold size_chunk in *. des_ifs.
          assert (init ≤ 0) by now destruct tag; try solve [hexploit COMMON; et; nia|hexploit DYNAMIC; et; des; nia].
          unfold Mem.perm in *.
          assert (init ≤ Ptrofs.unsigned i1 < sz \/ init ≤ Ptrofs.unsigned i1 - 1 < sz) by now destruct i1; ss; nia.
          destruct H8.
          { spc PERMinrange. des. rewrite PERMinrange in *. apply n. econs. }
          { spc PERMinrange0. des. rewrite PERMinrange0 in *. apply n0. econs. } }
        rewrite H6. hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iDestruct "ALLOC" as "[ALLOC ?]".
        iDestruct "SZ" as "[SZ ?]".
        iApply isim_ret. iSplitL "CNT CONC ALLOC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. ss.
    - unfold cmp_ptr_hoare3. des_ifs_safe. ss. clarify.
      iDestruct "PRE" as "[[% P] %]".
      do 2 unfold has_offset, _has_offset.
      destruct blk eqn:?; clarify.
      iDestruct "P" as "[ALLOC_PRE0 [SZ_PRE P]]".
      des; clarify. hred_r.
      iApply isim_pget_tgt. hred_r. destruct Vnullptr eqn:?; clarify.
      destruct v; clarify; des_ifs_safe.
      + iDestruct "P" as (a) "[CONC_PRE %]". des. clarify.
        unfold cmp_ptr. des_ifs_safe. ss. hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. destruct (Int64.eq i1 i0) eqn: ?.
        { apply Int64.same_if_eq in Heqb0. subst.
          unfold Vnullptr in Heqv0. des_ifs.
          unfold Ptrofs.sub in H5. change (Ptrofs.unsigned (Ptrofs.of_int64 _)) with 0%Z in H5.
          exfalso. eapply weak_valid_nil_paddr_base; et. ii.
          hexploit H6; clarify. }
        iSplit; ss. iExists _. iFrame. iPureIntro. splits; ss.
      + iDestruct "P" as "%". des. clarify.
        unfold cmp_ptr. des_ifs_safe. unfold Vnullptr in Heqv0. clarify.
        rewrite Int64.eq_true. ss. des_ifs_safe. rewrite Int64.eq_true. ss.
        iCombine "ALLOC ALLOC_PRE0" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz. dup SIM_ALLOC.
        ur in wfalloc. des. rewrite URA.unit_idl in wfalloc.
        ur in wfalloc0. apply pw_extends in wfalloc. spc wfalloc.
        ur in wfsz. specialize (wfsz (Some b)). specialize (SIM_ALLOC (Some b)).
        unfold __allocated_with in *. ss.
        destruct dec; clarify. apply Consent.extends in wfalloc; et. red in wfalloc. des.
        rewrite wfalloc1 in *. apply OneShot.oneshot_initialized in wfsz.
        des; rewrite wfsz in *; inv SIM_ALLOC; clarify.
        unfold weak_valid in *. destruct m. ss. rewrite Heqo in *.
        hexploit SZPOS; et. i.
        assert (Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1)
                || Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1 - 1) = true).
        { bsimpl. unfold Mem.valid_pointer.
          do 2 destruct Mem.perm_dec; ss; et.
          exfalso. dup PERMinrange.
          specialize (PERMinrange (Ptrofs.unsigned i1)).
          specialize (PERMinrange0 (Ptrofs.unsigned i1 - 1)).
          unfold size_chunk in *. des_ifs.
          assert (init ≤ 0) by now destruct tag; try solve [hexploit COMMON; et; nia|hexploit DYNAMIC; et; des; nia].
          unfold Mem.perm in *.
          assert (init ≤ Ptrofs.unsigned i1 < sz \/ init ≤ Ptrofs.unsigned i1 - 1 < sz) by now destruct i1; ss; nia.
          destruct H8.
          { spc PERMinrange. des. rewrite PERMinrange in *. apply n. econs. }
          { spc PERMinrange0. des. rewrite PERMinrange0 in *. apply n0. econs. } }
        rewrite H6. hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iDestruct "ALLOC" as "[ALLOC ?]".
        iDestruct "SZ" as "[SZ ?]".
        iApply isim_ret. iSplitL "CNT CONC ALLOC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. ss.
    - unfold cmp_ptr_hoare4. des_ifs_safe. ss. clarify.
      iDestruct "PRE" as "[[% P] %]".
      do 2 unfold has_offset, _has_offset.
      destruct blk eqn:?; clarify.
      iDestruct "P" as "[ALLOC_PRE0 [SZ_PRE P]]".
      des; clarify. hred_r.
      iApply isim_pget_tgt. hred_r. destruct Vnullptr eqn:?; clarify.
      destruct v; clarify; des_ifs_safe.
      + iDestruct "P" as (a) "[CONC_PRE %]". des. clarify.
        unfold cmp_ptr. des_ifs_safe. ss. hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. destruct (Int64.eq i1 i0) eqn: ?.
        { apply Int64.same_if_eq in Heqb0. subst.
          unfold Vnullptr in Heqv0. des_ifs.
          unfold Ptrofs.sub in H5. change (Ptrofs.unsigned (Ptrofs.of_int64 _)) with 0%Z in H5.
          exfalso. eapply weak_valid_nil_paddr_base; et. ii.
          hexploit H6; clarify. }
        iSplit; ss. iExists _. iFrame. iPureIntro. splits; ss.
      + iDestruct "P" as "%". des. clarify.
        unfold cmp_ptr. des_ifs_safe. unfold Vnullptr in Heqv0. clarify.
        rewrite Int64.eq_true. ss. des_ifs_safe. rewrite Int64.eq_true. ss.
        iCombine "ALLOC ALLOC_PRE0" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz. dup SIM_ALLOC.
        ur in wfalloc. des. rewrite URA.unit_idl in wfalloc.
        ur in wfalloc0. apply pw_extends in wfalloc. spc wfalloc.
        ur in wfsz. specialize (wfsz (Some b)). specialize (SIM_ALLOC (Some b)).
        unfold __allocated_with in *. ss.
        destruct dec; clarify. apply Consent.extends in wfalloc; et. red in wfalloc. des.
        rewrite wfalloc1 in *. apply OneShot.oneshot_initialized in wfsz.
        des; rewrite wfsz in *; inv SIM_ALLOC; clarify.
        unfold weak_valid in *. destruct m. ss. rewrite Heqo in *.
        hexploit SZPOS; et. i.
        assert (Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1)
                || Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1 - 1) = true).
        { bsimpl. unfold Mem.valid_pointer.
          do 2 destruct Mem.perm_dec; ss; et.
          exfalso. dup PERMinrange.
          specialize (PERMinrange (Ptrofs.unsigned i1)).
          specialize (PERMinrange0 (Ptrofs.unsigned i1 - 1)).
          unfold size_chunk in *. des_ifs.
          assert (init ≤ 0) by now destruct tag; try solve [hexploit COMMON; et; nia|hexploit DYNAMIC; et; des; nia].
          unfold Mem.perm in *.
          assert (init ≤ Ptrofs.unsigned i1 < sz \/ init ≤ Ptrofs.unsigned i1 - 1 < sz) by now destruct i1; ss; nia.
          destruct H8.
          { spc PERMinrange. des. rewrite PERMinrange in *. apply n. econs. }
          { spc PERMinrange0. des. rewrite PERMinrange0 in *. apply n0. econs. } }
        rewrite H6. hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iDestruct "ALLOC" as "[ALLOC ?]".
        iDestruct "SZ" as "[SZ ?]".
        iApply isim_ret. iSplitL "CNT CONC ALLOC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. ss.
    (* non-trivial cases *)
    - unfold cmp_ptr_hoare5. des_ifs_safe. ss. clarify.
      iDestruct "PRE" as "[[[% P] A] %]".
      do 2 unfold has_offset, _has_offset.
      destruct blk eqn:?; clarify.
      iDestruct "P" as "[ALLOC_PRE [SZ_PRE P]]".
      iDestruct "A" as "[ALLOC0_PRE [SZ0_PRE A]]".
      des; clarify. hred_r.
      iApply isim_pget_tgt. hred_r.
      destruct v0; clarify; des_ifs_safe;
      destruct v; clarify; des_ifs_safe.
      + iDestruct "P" as (a) "[CONC_PRE %]". des. clarify.
        iDestruct "A" as (a0) "[CONC0_PRE %]". des. clarify.
        unfold cmp_ptr. unfold Val.cmplu_bool. des_ifs_safe.
        hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame.
        iCombine "CONC_PRE CONC0_PRE" as "CONC_PRE".
        iPoseProof (_has_base_unique with "CONC_PRE") as "%".
        subst. iDestruct "CONC_PRE" as "[CONC_PRE ?]".
        iSplitR "CONC_PRE"; cycle 1.
        { iExists _. iFrame. ss. }
        iSplit; cycle 1.
        { iExists _. iFrame. ss. }
        unfold cmp_ofs. unfold Int64.cmpu.
        hexploit paddr_no_overflow_cond; et.
        hexploit (paddr_no_overflow_cond i1); et. i.
        replace (Ptrofs.unsigned _) with (Int64.unsigned i1 - Ptrofs.unsigned a0).
        2:{ unfold Ptrofs.sub, Ptrofs.of_int64.
            rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)); try apply Int64.unsigned_range_2.
            rewrite Ptrofs.unsigned_repr; et. destruct i1; destruct a0; ss; nia. }
        replace (Ptrofs.unsigned (Ptrofs.sub _ _)) with (Int64.unsigned i2 - Ptrofs.unsigned a0).
        2:{ unfold Ptrofs.sub, Ptrofs.of_int64.
            rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)); try apply Int64.unsigned_range_2.
            rewrite Ptrofs.unsigned_repr; et. destruct i2; destruct a0; ss; nia. }
        des_ifs; iPureIntro; f_equal.
        * pose proof (Int64.eq_spec i1 i2).
          destruct (Int64.eq i1 i2) eqn:?.
          { subst. symmetry. rewrite Z.eqb_eq. et. }
          symmetry. rewrite Z.eqb_neq. ii. apply H12.
          apply Int64.same_if_eq. unfold Int64.eq. destruct Coqlib.zeq; nia.
        * f_equal. pose proof (Int64.eq_spec i1 i2).
          destruct (Int64.eq i1 i2) eqn:?.
          { subst. symmetry. rewrite Z.eqb_eq. et. }
          symmetry. rewrite Z.eqb_neq. ii. apply H12.
          apply Int64.same_if_eq. unfold Int64.eq. destruct Coqlib.zeq; nia.
        * unfold Int64.ltu. destruct Coqlib.zlt; clarify.
          { symmetry. rewrite Z.ltb_lt. nia. }
          symmetry. rewrite Z.ltb_ge. nia.
        * unfold Int64.ltu. destruct Coqlib.zlt; clarify.
          { ss. symmetry. rewrite Z.leb_gt. nia. }
          symmetry. rewrite Z.leb_le. nia.
        * unfold Int64.ltu. rewrite Z.gtb_ltb. destruct Coqlib.zlt; clarify.
          { symmetry. rewrite Z.ltb_lt. nia. }
          symmetry. rewrite Z.ltb_ge. nia.
        * unfold Int64.ltu. rewrite Z.geb_leb. destruct Coqlib.zlt; clarify.
          { ss. symmetry. rewrite Z.leb_gt. nia. }
          ss. symmetry. rewrite Z.leb_le. nia.
      + iDestruct "P" as (a) "[CONC_PRE %]". des. clarify.
        iDestruct "A" as "%". des. clarify.
        iCombine "ALLOC ALLOC_PRE" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz. dup SIM_ALLOC.
        ur in wfalloc. des. rewrite URA.unit_idl in wfalloc.
        ur in wfalloc0. apply pw_extends in wfalloc. spc wfalloc.
        ur in wfsz. specialize (wfsz (Some b)). specialize (SIM_ALLOC (Some b)).
        unfold __allocated_with in *. ss.
        destruct dec; clarify. apply Consent.extends in wfalloc; et. red in wfalloc. des.
        rewrite wfalloc1 in *. apply OneShot.oneshot_initialized in wfsz.
        des; rewrite wfsz in *; inv SIM_ALLOC; clarify.
        unfold weak_valid in *. destruct m. ss. rewrite Heqo in *.
        hexploit SZPOS; et. i.
        pose proof (Int64.eq_spec i1 Int64.zero).
        destruct (Int64.eq i1 Int64.zero) eqn: ?.
        { subst. exfalso. eapply weak_valid_nil_paddr_base; et. ii.
          hexploit H7; clarify. }
        unfold cmp_ptr_join. ss.
        iCombine "CONC CONC_PRE" as "CONC".
        iOwnWf "CONC" as wfconc.
        assert (IntPtrRel.to_int_val mem_tgt (Vptr b i2) = Vlong (Int64.repr (Ptrofs.unsigned a + Ptrofs.unsigned i2))).
        { ur in wfconc. specialize (wfconc (Some b)). specialize (SIM_CONC (Some b)).
          ss. destruct dec; clarify.
          apply OneShot.oneshot_initialized in wfconc.
          des; rewrite wfconc in *; inv SIM_CONC; clarify.
          unfold to_int_val, Mem.to_int, Mem.ptr2int_v, Mem.ptr2int.
          rewrite <- H13. des_ifs. }
        hexploit paddr_no_overflow_cond; et. i.
        rewrite H11. unfold to_ptr_val at 2. unfold to_int_val. ss.
        unfold cmp_ptr. unfold Val.cmplu_bool at 1. des_ifs_safe. hred_r.
        des_ifs; hred_r.
        * apply eqb_prop in Heq2. subst.
          iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iDestruct "ALLOC" as "[ALLOC ?]".
          iDestruct "SZ" as "[SZ ?]".
          iDestruct "CONC" as "[CONC ?]".
          iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
          iSplit; ss. iFrame. iSplit; ss. iSplit; ss.
          2:{ iExists _. iFrame. ss. }
          iPureIntro. f_equal. unfold cmp_ofs, Int64.cmpu.
          replace (Ptrofs.unsigned (Ptrofs.sub _ _)) with (Int64.unsigned i1 - Ptrofs.unsigned a).
          2:{ unfold Ptrofs.sub, Ptrofs.of_int64.
              rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)); try apply Int64.unsigned_range_2.
              rewrite Ptrofs.unsigned_repr; et. destruct i1; destruct a; ss; nia. }
          unfold Int64.eq, Int64.ltu.
          rewrite Int64.unsigned_repr.
          2:{ change Int64.max_unsigned with Ptrofs.max_unsigned. split; try nia.
              destruct a; destruct i2; ss; nia. }
          des_ifs; try nia.
        * apply eqb_false_iff in Heq2.
          unfold Val.cmplu_bool in *. unfold to_ptr_val in *.
          des_ifs.
          { unfold Mem.to_ptr in *. des_ifs. }
          { unfold Mem.to_ptr in *. des_ifs.
            unfold Mem.denormalize in *.
            apply Maps.PTree.gselectf in Heq1. des.
            unfold Mem.denormalize_aux, Mem.is_valid, Mem.addr_is_in_block in *.
            des_ifs; ss; clarify; bsimpl; clarify.
            ur in wfconc. specialize (wfconc (Some b)). ss. destruct dec; clarify.
            apply OneShot.oneshot_initialized in wfconc.
            specialize (SIM_CONC (Some b)). ss.
            destruct wfconc as [wfconc|wfconc]; rewrite wfconc in SIM_CONC; inv SIM_CONC; clarify.
            rewrite Heq7 in H16; clarify. exfalso.
            apply Heq2. unfold Ptrofs.cmpu, Int64.cmpu.
            unfold Ptrofs.eq, Ptrofs.ltu, Int64.eq, Int64.ltu.
            change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *.
            rewrite Ptrofs.unsigned_repr; try nia.
            rewrite Int64.unsigned_repr.
            2:{ change Int64.max_unsigned with Ptrofs.max_unsigned.
                destruct base; destruct i2; ss; nia. }
            des_ifs; nia. }
          { unfold Mem.to_ptr in *. des_ifs.
            unfold Mem.denormalize in *.
            apply Maps.PTree.gselectf in Heq6. des.
            unfold Mem.denormalize_aux, Mem.is_valid, Mem.addr_is_in_block in *.
            des_ifs; ss; clarify; bsimpl; clarify. des.
            assert (i1 = Int64.repr (Ptrofs.unsigned a + Ptrofs.unsigned i2)).
            { apply Int64.same_if_eq. destruct c; ss; clarify.
              all: destruct (Int64.eq i1 (Int64.repr _)); clarify. }
            subst. rewrite Int64.unsigned_repr in *.
            all: try (change Int64.max_unsigned with Ptrofs.max_unsigned; destruct a; destruct i2; ss; nia).
            ur in wfconc. specialize (wfconc (Some b)). ss. destruct dec; clarify.
            apply OneShot.oneshot_initialized in wfconc.
            specialize (SIM_CONC (Some b)). ss.
            destruct wfconc as [wfconc|wfconc]; rewrite wfconc in SIM_CONC; inv SIM_CONC; clarify.
            pose proof (mem_tgt.(Mem.no_concrete_overlap) (Ptrofs.unsigned base + Ptrofs.unsigned i2)).
            red in H14. hexploit (H14 b b1); i; clarify.
            { destruct base; destruct i2; ss. econs; et; try nia.
              specialize (PERMinrange (intval + intval0 - intval)).
              unfold Mem.valid_pointer in *.
              do 2 destruct (Mem.perm_dec ); clarify.
              unfold Mem.perm in *.
              replace (intval + intval0 - intval) with intval0 by nia.
              unfold Mem.perm_order' in *. des_ifs.
              pose proof (mem_tgt.(Mem.access_max) b intval0).
              rewrite Heq11 in H15. unfold Mem.perm_order'' in *. des_ifs.
              et. }
            { econs; et. rewrite Z.ltb_lt in *. rewrite Z.leb_le in *. nia. } }
        * iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iDestruct "ALLOC" as "[ALLOC ?]".
          iDestruct "SZ" as "[SZ ?]".
          iDestruct "CONC" as "[CONC ?]".
          iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
          iSplit; ss. iFrame. iSplit; ss. iSplit; ss.
          2:{ iExists _. iFrame. ss. }
          iPureIntro. f_equal. unfold cmp_ofs, Int64.cmpu.
          replace (Ptrofs.unsigned (Ptrofs.sub _ _)) with (Int64.unsigned i1 - Ptrofs.unsigned a).
          2:{ unfold Ptrofs.sub, Ptrofs.of_int64.
              rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)); try apply Int64.unsigned_range_2.
              rewrite Ptrofs.unsigned_repr; et. destruct i1; destruct a; ss; nia. }
          unfold Int64.eq, Int64.ltu.
          rewrite Int64.unsigned_repr.
          2:{ change Int64.max_unsigned with Ptrofs.max_unsigned. split; try nia.
              destruct a; destruct i2; ss; nia. }
          des_ifs; try nia.
      + iDestruct "P" as "%". des. clarify.
        iDestruct "A" as (a) "[CONC_PRE %]". des. clarify.
        rename i1 into i0. rename i2 into i1. rename i0 into i2.
        iCombine "ALLOC ALLOC_PRE" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz. dup SIM_ALLOC.
        ur in wfalloc. des. rewrite URA.unit_idl in wfalloc.
        ur in wfalloc0. apply pw_extends in wfalloc. spc wfalloc.
        ur in wfsz. specialize (wfsz (Some b)). specialize (SIM_ALLOC (Some b)).
        unfold __allocated_with in *. ss.
        destruct dec; clarify. apply Consent.extends in wfalloc; et. red in wfalloc. des.
        rewrite wfalloc1 in *. apply OneShot.oneshot_initialized in wfsz.
        des; rewrite wfsz in *; inv SIM_ALLOC; clarify.
        unfold weak_valid in *. destruct m. ss. rewrite Heqo in *.
        hexploit SZPOS; et. i.
        pose proof (Int64.eq_spec i1 Int64.zero).
        destruct (Int64.eq i1 Int64.zero) eqn: ?.
        { subst. exfalso. hexploit H7; clarify.
          unfold weak_valid, Ptrofs.sub, Ptrofs.of_int64 in *.
          change (Ptrofs.unsigned (Ptrofs.repr (Int64.unsigned _))) with 0 in *.
          rewrite Ptrofs.unsigned_repr_eq in *.
          rewrite Z_mod_nz_opp_full in *; [>rewrite Z.mod_small in *|rewrite Z.mod_small..]; et.
          all: try apply Ptrofs.unsigned_range. 2:{ ii. hexploit H7; clarify. }
          change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
        unfold cmp_ptr_join. ss.
        iCombine "CONC CONC_PRE" as "CONC".
        iOwnWf "CONC" as wfconc.
        assert (IntPtrRel.to_int_val mem_tgt (Vptr b i2) = Vlong (Int64.repr (Ptrofs.unsigned a + Ptrofs.unsigned i2))).
        { ur in wfconc. specialize (wfconc (Some b)). specialize (SIM_CONC (Some b)).
          ss. destruct dec; clarify.
          apply OneShot.oneshot_initialized in wfconc.
          des; rewrite wfconc in *; inv SIM_CONC; clarify.
          unfold to_int_val, Mem.to_int, Mem.ptr2int_v, Mem.ptr2int.
          rewrite <- H13. des_ifs. }
        hexploit paddr_no_overflow_cond; et. i.
        rewrite H11. unfold to_ptr_val at 1. unfold to_int_val. ss.
        unfold cmp_ptr. unfold Val.cmplu_bool at 1. des_ifs_safe.
        Local Opaque Val.cmplu_bool. hred_r.
        des_ifs; hred_r.
        Local Transparent Val.cmplu_bool.
        * apply eqb_prop in Heq2. rewrite Heq2.
          iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iDestruct "ALLOC" as "[ALLOC ?]".
          iDestruct "SZ" as "[SZ ?]".
          iDestruct "CONC" as "[CONC ?]".
          iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
          iSplit; ss. iFrame. iSplit; ss. iSplit; ss.
          2:{ iExists _. iFrame. ss. }
          iPureIntro. f_equal. unfold cmp_ofs, Int64.cmpu.
          replace (Ptrofs.unsigned (Ptrofs.sub _ _)) with (Int64.unsigned i1 - Ptrofs.unsigned a).
          2:{ unfold Ptrofs.sub, Ptrofs.of_int64.
              rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)); try apply Int64.unsigned_range_2.
              rewrite Ptrofs.unsigned_repr; et. destruct i1; destruct a; ss; nia. }
          unfold Int64.eq, Int64.ltu.
          rewrite Int64.unsigned_repr.
          2:{ change Int64.max_unsigned with Ptrofs.max_unsigned. split; try nia.
              destruct a; destruct i2; ss; nia. }
          des_ifs; try nia.
        * apply eqb_false_iff in Heq2.
          unfold Val.cmplu_bool in *. unfold to_ptr_val in *.
          des_ifs.
          { unfold Mem.to_ptr in *. des_ifs. }
          { unfold Mem.to_ptr in *. des_ifs.
            unfold Mem.denormalize in *.
            apply Maps.PTree.gselectf in Heq1. des.
            unfold Mem.denormalize_aux, Mem.is_valid, Mem.addr_is_in_block in *.
            des_ifs; ss; clarify; bsimpl; clarify.
            ur in wfconc. specialize (wfconc (Some b1)). ss. destruct dec; clarify.
            apply OneShot.oneshot_initialized in wfconc.
            specialize (SIM_CONC (Some b1)). ss.
            destruct wfconc as [wfconc|wfconc]; rewrite wfconc in SIM_CONC; inv SIM_CONC; clarify.
            rewrite Heq7 in H16; clarify. exfalso.
            apply Heq2. unfold Ptrofs.cmpu, Int64.cmpu.
            unfold Ptrofs.eq, Ptrofs.ltu, Int64.eq, Int64.ltu.
            change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *.
            rewrite Ptrofs.unsigned_repr; try nia.
            rewrite Int64.unsigned_repr.
            2:{ change Int64.max_unsigned with Ptrofs.max_unsigned.
                destruct base; destruct i2; ss; nia. }
            des_ifs; nia. }
          { unfold Mem.to_ptr in *. des_ifs.
            unfold Mem.denormalize in *.
            apply Maps.PTree.gselectf in Heq6. des.
            unfold Mem.denormalize_aux, Mem.is_valid, Mem.addr_is_in_block in *.
            des_ifs; ss; clarify; bsimpl; clarify. des.
            assert (Int64.repr (Ptrofs.unsigned a + Ptrofs.unsigned i2) = i1).
            { apply Int64.same_if_eq. destruct c; ss; clarify.
              all: destruct (Int64.eq (Int64.repr _) i1); clarify. }
            subst. rewrite Int64.unsigned_repr in *.
            all: try (change Int64.max_unsigned with Ptrofs.max_unsigned; destruct a; destruct i2; ss; nia).
            ur in wfconc. specialize (wfconc (Some b)). ss. destruct dec; clarify.
            apply OneShot.oneshot_initialized in wfconc.
            specialize (SIM_CONC (Some b)). ss.
            destruct wfconc as [wfconc|wfconc]; rewrite wfconc in SIM_CONC; inv SIM_CONC; clarify.
            pose proof (mem_tgt.(Mem.no_concrete_overlap) (Ptrofs.unsigned base + Ptrofs.unsigned i2)).
            red in H14. hexploit (H14 b b1); i; clarify.
            { destruct base; destruct i2; ss. econs; et; try nia.
              specialize (PERMinrange (intval + intval0 - intval)).
              unfold Mem.valid_pointer in *.
              do 2 destruct (Mem.perm_dec ); clarify.
              unfold Mem.perm in *.
              replace (intval + intval0 - intval) with intval0 by nia.
              unfold Mem.perm_order' in *. des_ifs.
              pose proof (mem_tgt.(Mem.access_max) b intval0).
              rewrite Heq12 in H15. unfold Mem.perm_order'' in *. des_ifs.
              et. }
            { econs; et. rewrite Z.ltb_lt in *. rewrite Z.leb_le in *. nia. } }
        * iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iDestruct "ALLOC" as "[ALLOC ?]".
          iDestruct "SZ" as "[SZ ?]".
          iDestruct "CONC" as "[CONC ?]".
          iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
          iSplit; ss. iFrame. iSplit; ss. iSplit; ss.
          2:{ iExists _. iFrame. ss. }
          iPureIntro. f_equal. unfold cmp_ofs, Int64.cmpu.
          replace (Ptrofs.unsigned (Ptrofs.sub _ _)) with (Int64.unsigned i1 - Ptrofs.unsigned a).
          2:{ unfold Ptrofs.sub, Ptrofs.of_int64.
              rewrite (Ptrofs.unsigned_repr (Int64.unsigned _)); try apply Int64.unsigned_range_2.
              rewrite Ptrofs.unsigned_repr; et. destruct i1; destruct a; ss; nia. }
          unfold Int64.eq, Int64.ltu.
          rewrite Int64.unsigned_repr.
          2:{ change Int64.max_unsigned with Ptrofs.max_unsigned. split; try nia.
              destruct a; destruct i2; ss; nia. }
          des_ifs; try nia.
      + iDestruct "P" as "%". des. clarify.
        iDestruct "A" as "%". des. clarify.
        unfold cmp_ptr. des_ifs_safe. unfold Val.cmplu_bool.
        des_ifs_safe. unfold weak_valid in *.
        destruct m. ss. rewrite Heqo in *. hexploit SZPOS; et. i.
        iCombine "ALLOC ALLOC_PRE" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz.
        ur in wfalloc. ur in wfsz. rewrite URA.unit_idl in wfalloc. des.
        apply pw_extends in wfalloc. red in wfalloc. spc wfalloc. dup SIM_ALLOC.
        specialize (wfsz (Some b)). ss. unfold __allocated_with in *.
        destruct dec; clarify. ur in wfalloc0. apply Consent.extends in wfalloc; et.
        red in wfalloc. des. specialize (SIM_ALLOC (Some b)). ss. des.
        rewrite wfalloc1 in *. apply OneShot.oneshot_initialized in wfsz.
        des; rewrite wfsz in *; inv SIM_ALLOC; clarify.
        assert ((Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1)
                || Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1 - 1)) = true).
        { bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          destruct (Coqlib.zeq (Ptrofs.unsigned i1) sz0); subst.
          { unfold size_chunk in *. des_ifs. destruct i1; ss.
            hexploit (PERMinrange (intval - 1)).
            { destruct tag; try solve [hexploit COMMON; et; nia| hexploit DYNAMIC; et; des; nia]. }
            i. des. unfold Mem.perm, Mem.perm_order' in *.
            rewrite H7 in *. apply n0. econs. }
          { unfold size_chunk in *. des_ifs. destruct i1; ss.
            hexploit (PERMinrange intval).
            { destruct tag; try solve [hexploit COMMON; et; nia| hexploit DYNAMIC; et; des; nia]. }
            i. des. unfold Mem.perm, Mem.perm_order' in *.
            rewrite H7 in *. apply n. econs. } }
        assert ((Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i2)
                || Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i2 - 1)) = true).
        { clear H7. bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          destruct (Coqlib.zeq (Ptrofs.unsigned i2) sz0); subst.
          { unfold size_chunk in *. des_ifs. destruct i2; ss.
            hexploit (PERMinrange (intval - 1)).
            { destruct tag; try solve [hexploit COMMON; et; nia| hexploit DYNAMIC; et; des; nia]. }
            i. des. unfold Mem.perm, Mem.perm_order' in *.
            rewrite H7 in *. apply n0. econs. }
          { unfold size_chunk in *. des_ifs. destruct i2; ss.
            hexploit (PERMinrange intval).
            { destruct tag; try solve [hexploit COMMON; et; nia| hexploit DYNAMIC; et; des; nia]. }
            i. des. unfold Mem.perm, Mem.perm_order' in *.
            rewrite H7 in *. apply n. econs. } }
        rewrite H7. rewrite H10. hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iDestruct "ALLOC" as "[ALLOC ALLOC_PRE]".
        iDestruct "SZ" as "[SZ SZ_PRE]".
        iApply isim_ret. iSplitL "CNT CONC ALLOC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. iSplit; ss. iSplit; ss.
        iPureIntro. f_equal. unfold cmp_ofs, Ptrofs.cmpu.
        unfold Ptrofs.eq, Ptrofs.ltu.
        des_ifs; nia.
    - unfold cmp_ptr_hoare6. des_ifs_safe. ss. clarify.
      iDestruct "PRE" as "[[[% P] A] %]".
      do 2 unfold has_offset, _has_offset.
      destruct (blk m) eqn:?; clarify.
      iDestruct "A" as "[ALLOC_PRE [SZ_PRE A]]".
      destruct (blk m0) eqn:?; clarify.
      iDestruct "P" as "[ALLOC0_PRE [SZ0_PRE P]]".
      des; clarify. hred_r.
      iApply isim_pget_tgt. hred_r.
      destruct v0; clarify; des_ifs_safe;
      destruct v; clarify; des_ifs_safe.
      + iDestruct "P" as (a) "[CONC_PRE %]". des. clarify.
        iDestruct "A" as (a0) "[CONC0_PRE %]". des. clarify.
        unfold cmp_ptr. unfold Val.cmplu_bool. des_ifs_safe. hred_r.
        iCombine "ALLOC ALLOC_PRE" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz.
        iDestruct "ALLOC" as "[ALLOC ALLOC_PRE]".
        iDestruct "SZ" as "[SZ SZ_PRE]".
        iCombine "ALLOC ALLOC0_PRE" as "ALLOC".
        iCombine "SZ SZ0_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc0.
        iOwnWf "SZ" as wfsz0.
        iDestruct "ALLOC" as "[ALLOC ALLOC0_PRE]".
        iDestruct "SZ" as "[SZ SZ0_PRE]".
        ur in wfalloc. ur in wfsz. rewrite URA.unit_idl in wfalloc. des.
        apply pw_extends in wfalloc. red in wfalloc.
        ur in wfalloc0. ur in wfsz0. rewrite URA.unit_idl in wfalloc0. des.
        apply pw_extends in wfalloc0. red in wfalloc0. ur in wfalloc1.
        specialize (wfsz (Some b)).
        specialize (wfsz0 (Some b0)).
        specialize (wfalloc b).
        specialize (wfalloc0 b0).
        hexploit (SIM_ALLOC (Some b)).
        hexploit (SIM_ALLOC (Some b0)).
        i. des. unfold __allocated_with in *. destruct dec; clarify.
        destruct dec; clarify.
        apply Consent.extends in wfalloc; et. red in wfalloc. des. rewrite wfalloc3 in *.
        apply Consent.extends in wfalloc0; et. red in wfalloc0. des. rewrite wfalloc4 in *.
        apply OneShot.oneshot_initialized in wfsz.
        apply OneShot.oneshot_initialized in wfsz0.
        destruct wfsz as [wfsz|wfsz]; rewrite wfsz in H12; inv H12; clarify.
        destruct wfsz0 as [wfsz0|wfsz0]; rewrite wfsz0 in H4; inv H4; clarify.
        iCombine "CONC CONC_PRE" as "CONC".
        iOwnWf "CONC" as wfconc.
        iDestruct "CONC" as "[CONC CONC_PRE]".
        iCombine "CONC CONC0_PRE" as "CONC".
        iOwnWf "CONC" as wfconc0.
        iDestruct "CONC" as "[CONC CONC0_PRE]".
        ur in wfconc. specialize (wfconc (Some b0)).
        ur in wfconc0. specialize (wfconc0 (Some b)).
        ss. destruct dec; clarify. destruct dec; clarify.
        apply OneShot.oneshot_initialized in wfconc.
        apply OneShot.oneshot_initialized in wfconc0.
        hexploit (SIM_CONC (Some b)). i.
        hexploit (SIM_CONC (Some b0)). i.
        destruct wfconc as [wfconc|wfconc]; rewrite wfconc in H12; inv H12; clarify.
        destruct wfconc0 as [wfconc0|wfconc0]; rewrite wfconc0 in H4; inv H4; clarify.

        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iApply isim_ret. iSplitL "CNT CONC ALLOC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. iSplitL "CONC_PRE"; cycle 1.
        { iExists _. iFrame. ss. }
        iSplit; ss. 2:{ iExists _. iFrame. ss. }
        iPureIntro. f_equal. pose proof (Int64.eq_spec i2 i1).
        destruct (Int64.eq i2 i1); et. subst. exfalso.
        hexploit paddr_no_overflow_cond_lt; et. i.
        unfold size_chunk in *. des_ifs.
        hexploit (paddr_no_overflow_cond_lt i1 base); et. i.
        assert (init ≤ 0) by now destruct tag; try solve [hexploit COMMON; et; nia|hexploit DYNAMIC; et; des; nia].
        hexploit (PERMinrange (Int64.unsigned i1 - Ptrofs.unsigned base0)); try nia.
        assert (init0 ≤ 0) by now destruct tag0; try solve [hexploit COMMON0; et; nia|hexploit DYNAMIC0; et; des; nia].
        hexploit (PERMinrange0 (Int64.unsigned i1 - Ptrofs.unsigned base)); try nia.
        i. des. pose proof (mem_tgt.(Mem.no_concrete_overlap) (Int64.unsigned i1)).
        red in H25. hexploit (H25 b b0).
        { econs; et.
          - pose proof (mem_tgt.(Mem.access_max) b (Int64.unsigned i1 - Ptrofs.unsigned base0)).
            rewrite H20 in H26. unfold Mem.perm_order'' in *. des_ifs. et.
          - destruct base0; destruct i1; ss.
            change Int64.modulus with (Ptrofs.max_unsigned + 1) in *.
            change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
        { econs; et.
          - pose proof (mem_tgt.(Mem.access_max) b0 (Int64.unsigned i1 - Ptrofs.unsigned base)).
            rewrite H19 in H26. unfold Mem.perm_order'' in *. des_ifs. et.
          - destruct base; destruct i1; ss.
            change Int64.modulus with (Ptrofs.max_unsigned + 1) in *.
            change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
        i. unfold "#^" in *. subst. rewrite <- Heqo in Heqo0. clarify.
      + iDestruct "P" as "%". des. clarify.
        iDestruct "A" as (a) "[CONC_PRE %]". des. clarify.
        iCombine "ALLOC ALLOC_PRE" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz.
        iDestruct "ALLOC" as "[ALLOC ALLOC_PRE]".
        iDestruct "SZ" as "[SZ SZ_PRE]".
        iCombine "ALLOC ALLOC0_PRE" as "ALLOC".
        iCombine "SZ SZ0_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc0.
        iOwnWf "SZ" as wfsz0.
        iDestruct "ALLOC" as "[ALLOC ALLOC0_PRE]".
        iDestruct "SZ" as "[SZ SZ0_PRE]".
        ur in wfalloc. ur in wfsz. rewrite URA.unit_idl in wfalloc. des.
        apply pw_extends in wfalloc. red in wfalloc.
        ur in wfalloc0. ur in wfsz0. rewrite URA.unit_idl in wfalloc0. des.
        apply pw_extends in wfalloc0. red in wfalloc0. ur in wfalloc1.
        specialize (wfsz (Some b)).
        specialize (wfsz0 (Some b0)).
        specialize (wfalloc b).
        specialize (wfalloc0 b0).
        hexploit (SIM_ALLOC (Some b)).
        hexploit (SIM_ALLOC (Some b0)).

        i. des. unfold __allocated_with in *. destruct dec; clarify.
        destruct dec; clarify.
        apply Consent.extends in wfalloc; et. red in wfalloc. des. rewrite wfalloc3 in *.
        apply Consent.extends in wfalloc0; et. red in wfalloc0. des. rewrite wfalloc4 in *.
        apply OneShot.oneshot_initialized in wfsz.
        apply OneShot.oneshot_initialized in wfsz0.
        destruct wfsz as [wfsz|wfsz]; rewrite wfsz in H11; inv H11; clarify.
        destruct wfsz0 as [wfsz0|wfsz0]; rewrite wfsz0 in H4; inv H4; clarify.
        destruct m, m0. unfold "#^", valid in *. ss. rewrite Heqo in *. rewrite Heqo0 in *.
        hexploit SZPOS; et. i.
        hexploit SZPOS0; et. i.
        pose proof (Int64.eq_spec i1 Int64.zero).
        destruct (Int64.eq i1 Int64.zero) eqn: ?.
        { subst. exfalso.
          unfold weak_valid, Ptrofs.sub, Ptrofs.of_int64 in *.
          change (Ptrofs.unsigned (Ptrofs.repr (Int64.unsigned _))) with 0 in *.
          change (0 - Ptrofs.unsigned a) with (- Ptrofs.unsigned a) in *.
          eapply weak_valid_nil_paddr_base; et. 2:{ ii. hexploit H8; clarify. } nia. }
        unfold cmp_ptr_join. ss.
        iCombine "CONC CONC_PRE" as "CONC".
        iOwnWf "CONC" as wfconc.
        ur in wfconc. specialize (wfconc (Some b)). ss. destruct dec; clarify.
        hexploit (SIM_CONC (Some b)). i.
        apply OneShot.oneshot_initialized in wfconc.
        des; rewrite wfconc in *; inv H15; clarify.
        hexploit paddr_no_overflow_cond_lt; et. i.
        assert (to_ptr_val mem_tgt (Vlong i1) = Vptr b (Ptrofs.repr (Int64.unsigned i1 - Ptrofs.unsigned base))).
        { unfold to_ptr_val, Mem.to_ptr.
          des_ifs; [apply Maps.PTree.gselectf in Heq1|apply Maps.PTree.gselectnf in Heq1]; des.
          - ss. unfold Mem.denormalize_aux, Mem.is_valid, Mem.addr_is_in_block in *.
            des_ifs; bsimpl; des; clarify.
            hexploit (PERMinrange (Int64.unsigned i1 - Ptrofs.unsigned base)).
            { unfold size_chunk in *. des_ifs. destruct tag; (hexploit COMMON + hexploit DYNAMIC); et; nia. }
            i. des.
            pose proof (mem_tgt.(Mem.no_concrete_overlap) (Int64.unsigned i1)).
            red in H20. hexploit (H20 b b1).
            { econs; et.
              - epose proof (mem_tgt.(Mem.access_max) b _).
                rewrite H17 in H21. unfold Mem.perm_order'' in *. des_ifs. et.
              - destruct base; destruct i1; ss.
                change Int64.modulus with (Ptrofs.max_unsigned + 1) in *.
                change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
            { econs; et. destruct i1; ss. nia. }
            i. subst. rewrite Heq3 in *. clarify.
          - exfalso. apply Heq1. esplits; et. unfold Mem.denormalize_aux.
            rewrite <- H18. unfold size_chunk in *. des_ifs. bsimpl.
            hexploit (PERMinrange (Int64.unsigned i1 - Ptrofs.unsigned base)); try solve [destruct tag; (hexploit COMMON + hexploit DYNAMIC); et; nia].
            i. unfold Mem.is_valid, Mem.addr_is_in_block in *. rewrite <- H18 in Heq2. des.
            { hexploit (mem_tgt.(Mem.nextblock_noaccess) b); try solve [rewrite H13; et].
              apply Pos.ltb_ge in Heq2. unfold Coqlib.Plt. nia. rewrite H17. et. }
            { des_ifs; bsimpl; des.
              { rewrite PERMoutrange in H17; clarify. destruct tag; (hexploit COMMON + hexploit DYNAMIC); et; nia. }
              { destruct i1; destruct base; ss. change Int64.modulus with Ptrofs.modulus in *. nia. }
              { hexploit (mem_tgt.(Mem.access_max)). rewrite Heq4. rewrite H17. i. inv H20. } } }
        rewrite H16. unfold to_ptr_val at 1. unfold to_int_val at 2. ss.
        unfold cmp_ptr. des_ifs_safe. unfold Val.cmplu_bool at 2.
        rewrite Ptrofs.unsigned_repr; [|destruct base; ss; nia].
        assert (Mem.valid_pointer mem_tgt b0 (Ptrofs.unsigned i2) = true).
        { bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          unfold size_chunk in *. des_ifs. destruct i2; ss.
          hexploit (PERMinrange0 intval).
          { destruct tag0; try solve [hexploit COMMON0; et; nia| hexploit DYNAMIC0; et; des; nia]. }
          i. des. unfold Mem.perm, Mem.perm_order' in *.
          rewrite H17 in *. apply n. econs. }
        assert (Mem.valid_pointer mem_tgt b (Int64.unsigned i1 - Ptrofs.unsigned base) = true).
        { clear H17. bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          unfold size_chunk in *. des_ifs. destruct i1; destruct base; ss.
          hexploit (PERMinrange (intval - intval0)).
          { destruct tag; try solve [hexploit COMMON; et; nia| hexploit DYNAMIC; et; des; nia]. }
          i. des. unfold Mem.perm, Mem.perm_order' in *.
          rewrite H17 in *. apply n. econs. }
        rewrite H19. rewrite H17. ss. destruct eq_block; clarify.
        Local Opaque Val.cmplu_bool.
        des_ifs; hred_r; des_ifs; hred_r.
        Local Transparent Val.cmplu_bool.
        * iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iDestruct "CONC" as "[CONC ?]".
          iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
          iSplit; ss. iFrame. iSplit; ss. iExists _. iFrame. ss.
        * unfold Val.cmplu_bool, to_int_val, Mem.to_int, Mem.ptr2int_v, Mem.ptr2int in *.
          des_ifs. ss. clarify. hexploit Int64.eq_spec. rewrite H21.
          i. subst. unfold Mem.valid_pointer in *.
          do 2 destruct Mem.perm_dec; ss; clarify.
          unfold Mem.perm, Mem.perm_order' in *. des_ifs.
          hexploit (mem_tgt.(Mem.weak_valid_address_range) b0); et.
          { apply Ptrofs.unsigned_range. }
          { unfold Mem._weak_valid_pointer, Mem._valid_pointer.
            pose proof (mem_tgt.(Mem.access_max) b0 (Ptrofs.unsigned i2)).
            rewrite Heq4 in H20. unfold Mem.perm_order'' in *.
            des_ifs. rewrite Heq6. left. econs. }
          i. inv H20; ss.
          rewrite Int64.unsigned_repr in *.
          2,3,4: change Int64.max_unsigned with (Ptrofs.modulus - 1); nia.
          pose proof (mem_tgt.(Mem.no_concrete_overlap) (z0 + Ptrofs.unsigned i2)).
          red in H20. hexploit (H20 b b0).
          { econs; et.
            - pose proof (mem_tgt.(Mem.access_max) b (z0 + Ptrofs.unsigned i2 - Ptrofs.unsigned base)).
              rewrite Heq2 in H22. unfold Mem.perm_order'' in *. des_ifs. et.
            - destruct base; destruct i2; ss.
              change Int64.modulus with (Ptrofs.max_unsigned + 1) in *.
              change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
          { econs; et.
            - pose proof (mem_tgt.(Mem.access_max) b0 (Ptrofs.unsigned i2)).
              rewrite Heq4 in H22. unfold Mem.perm_order'' in *. des_ifs.
              replace (_ + _ - _) with (Ptrofs.unsigned i2) by nia. et.
            - destruct i2; ss. nia. }
        i. clarify.
        * iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iDestruct "CONC" as "[CONC ?]".
          iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
          iSplit; ss. iFrame. iSplit; ss. iExists _. iFrame. ss.
      + iDestruct "P" as (a) "[CONC_PRE %]". des. clarify.
        iDestruct "A" as "%". des. clarify.
        iCombine "ALLOC ALLOC_PRE" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz.
        iDestruct "ALLOC" as "[ALLOC ALLOC_PRE]".
        iDestruct "SZ" as "[SZ SZ_PRE]".
        iCombine "ALLOC ALLOC0_PRE" as "ALLOC".
        iCombine "SZ SZ0_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc0.
        iOwnWf "SZ" as wfsz0.
        iDestruct "ALLOC" as "[ALLOC ALLOC0_PRE]".
        iDestruct "SZ" as "[SZ SZ0_PRE]".
        ur in wfalloc. ur in wfsz. rewrite URA.unit_idl in wfalloc. des.
        apply pw_extends in wfalloc. red in wfalloc.
        ur in wfalloc0. ur in wfsz0. rewrite URA.unit_idl in wfalloc0. des.
        apply pw_extends in wfalloc0. red in wfalloc0. ur in wfalloc1.
        specialize (wfsz (Some b)).
        specialize (wfsz0 (Some b0)).
        specialize (wfalloc b).
        specialize (wfalloc0 b0).
        hexploit (SIM_ALLOC (Some b)).
        hexploit (SIM_ALLOC (Some b0)).

        i. des. unfold __allocated_with in *. destruct dec; clarify.
        destruct dec; clarify.
        apply Consent.extends in wfalloc; et. red in wfalloc. des. rewrite wfalloc3 in *.
        apply Consent.extends in wfalloc0; et. red in wfalloc0. des. rewrite wfalloc4 in *.
        apply OneShot.oneshot_initialized in wfsz.
        apply OneShot.oneshot_initialized in wfsz0.
        destruct wfsz as [wfsz|wfsz]; rewrite wfsz in H10; inv H10; clarify.
        destruct wfsz0 as [wfsz0|wfsz0]; rewrite wfsz0 in H4; inv H4; clarify.
        destruct m, m0. unfold "#^", valid in *. ss. rewrite Heqo in *. rewrite Heqo0 in *.
        hexploit SZPOS; et. i.
        hexploit SZPOS0; et. i.
        pose proof (Int64.eq_spec i2 Int64.zero).
        destruct (Int64.eq i2 Int64.zero) eqn: ?.
        { subst. exfalso.
          unfold weak_valid, Ptrofs.sub, Ptrofs.of_int64 in *.
          change (Ptrofs.unsigned (Ptrofs.repr (Int64.unsigned _))) with 0 in *.
          change (0 - Ptrofs.unsigned a) with (- Ptrofs.unsigned a) in *.
          eapply weak_valid_nil_paddr_base; et. 2:{ ii. hexploit H8; clarify. } nia. }
        unfold cmp_ptr_join. ss.
        iCombine "CONC CONC_PRE" as "CONC".
        iOwnWf "CONC" as wfconc.
        ur in wfconc. specialize (wfconc (Some b0)). ss. destruct dec; clarify.
        hexploit (SIM_CONC (Some b0)). i.
        apply OneShot.oneshot_initialized in wfconc.
        des; rewrite wfconc in *; inv H15; clarify.
        hexploit paddr_no_overflow_cond_lt; et. i.
        assert (to_ptr_val mem_tgt (Vlong i2) = Vptr b0 (Ptrofs.repr (Int64.unsigned i2 - Ptrofs.unsigned base))).
        { unfold to_ptr_val, Mem.to_ptr.
          des_ifs; [apply Maps.PTree.gselectf in Heq1|apply Maps.PTree.gselectnf in Heq1]; des.
          - ss. unfold Mem.denormalize_aux, Mem.is_valid, Mem.addr_is_in_block in *.
            des_ifs; bsimpl; des; clarify.
            hexploit (PERMinrange0 (Int64.unsigned i2 - Ptrofs.unsigned base)).
            { unfold size_chunk in *. des_ifs. destruct tag0; (hexploit COMMON0 + hexploit DYNAMIC0); et; nia. }
            i. des.
            pose proof (mem_tgt.(Mem.no_concrete_overlap) (Int64.unsigned i2)).
            red in H20. hexploit (H20 b0 b1).
            { econs; et.
              - epose proof (mem_tgt.(Mem.access_max) b0 _).
                rewrite H17 in H21. unfold Mem.perm_order'' in *. des_ifs. et.
              - destruct base; destruct i2; ss.
                change Int64.modulus with (Ptrofs.max_unsigned + 1) in *.
                change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
            { econs; et. destruct i2; ss. nia. }
            i. subst. rewrite Heq3 in *. clarify.
          - exfalso. apply Heq1. esplits; et. unfold Mem.denormalize_aux.
            rewrite <- H18. unfold size_chunk in *. des_ifs. bsimpl.
            hexploit (PERMinrange0 (Int64.unsigned i2 - Ptrofs.unsigned base)); try solve [destruct tag0; (hexploit COMMON0 + hexploit DYNAMIC0); et; nia].
            i. unfold Mem.is_valid, Mem.addr_is_in_block in *. rewrite <- H18 in Heq2. des.
            { hexploit (mem_tgt.(Mem.nextblock_noaccess) b0); try solve [rewrite H13; et].
              apply Pos.ltb_ge in Heq2. unfold Coqlib.Plt. nia. rewrite H17. et. }
            { des_ifs; bsimpl; des.
              { rewrite PERMoutrange0 in H17; clarify. destruct tag0; (hexploit COMMON0 + hexploit DYNAMIC0); et; nia. }
              { destruct i2; destruct base; ss. change Int64.modulus with Ptrofs.modulus in *. nia. }
              { hexploit (mem_tgt.(Mem.access_max)). rewrite Heq4. rewrite H17. i. inv H20. } } }
        rewrite H16. unfold to_ptr_val at 1. unfold to_int_val at 2. ss.
        unfold cmp_ptr. des_ifs_safe. unfold Val.cmplu_bool at 2.
        rewrite Ptrofs.unsigned_repr; [|destruct base; ss; nia].
        assert (Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1) = true).
        { bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          unfold size_chunk in *. des_ifs. destruct i1; ss.
          hexploit (PERMinrange intval).
          { destruct tag; try solve [hexploit COMMON; et; nia| hexploit DYNAMIC; et; des; nia]. }
          i. des. unfold Mem.perm, Mem.perm_order' in *.
          rewrite H17 in *. apply n. econs. }
        assert (Mem.valid_pointer mem_tgt b0 (Int64.unsigned i2 - Ptrofs.unsigned base) = true).
        { clear H17. bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          unfold size_chunk in *. des_ifs. destruct i2; destruct base; ss.
          hexploit (PERMinrange0 (intval - intval0)).
          { destruct tag0; try solve [hexploit COMMON0; et; nia| hexploit DYNAMIC0; et; des; nia]. }
          i. des. unfold Mem.perm, Mem.perm_order' in *.
          rewrite H17 in *. apply n. econs. }
        rewrite H19. rewrite H17. ss. destruct eq_block; clarify.
        Local Opaque Val.cmplu_bool.
        des_ifs; hred_r; des_ifs; hred_r.
        Local Transparent Val.cmplu_bool.
        * iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iDestruct "CONC" as "[CONC ?]".
          iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
          iSplit; ss. iFrame. iSplit; ss. iSplit; ss. iExists _. iFrame. ss.
        * iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iDestruct "CONC" as "[CONC ?]".
          iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
          iSplit; ss. iFrame. iSplit; ss. iSplit; ss. iExists _. iFrame. ss.
        * unfold Val.cmplu_bool, to_int_val, Mem.to_int, Mem.ptr2int_v, Mem.ptr2int in *.
          des_ifs. ss. clarify. hexploit Int64.eq_spec. rewrite Heq5.
          i. subst. unfold Mem.valid_pointer in *.
          do 2 destruct Mem.perm_dec; ss; clarify.
          unfold Mem.perm, Mem.perm_order' in *. des_ifs.
          hexploit (mem_tgt.(Mem.weak_valid_address_range) b); et.
          { apply Ptrofs.unsigned_range. }
          { unfold Mem._weak_valid_pointer, Mem._valid_pointer.
            pose proof (mem_tgt.(Mem.access_max) b (Ptrofs.unsigned i1)).
            rewrite Heq3 in H20. unfold Mem.perm_order'' in *.
            des_ifs. rewrite Heq7. left. econs. }
          i. inv H20; ss.
          rewrite Int64.unsigned_repr in *.
          2,3,4: change Int64.max_unsigned with (Ptrofs.modulus - 1); nia.
          pose proof (mem_tgt.(Mem.no_concrete_overlap) (z0 + Ptrofs.unsigned i1)).
          red in H20. hexploit (H20 b0 b).
          { econs; et.
            - pose proof (mem_tgt.(Mem.access_max) b0 (z0 + Ptrofs.unsigned i1 - Ptrofs.unsigned base)).
              rewrite Heq1 in H21. unfold Mem.perm_order'' in *. des_ifs. et.
            - destruct base; destruct i1; ss.
              change Int64.modulus with (Ptrofs.max_unsigned + 1) in *.
              change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
          { econs; et.
            - pose proof (mem_tgt.(Mem.access_max) b (Ptrofs.unsigned i1)).
              rewrite Heq3 in H21. unfold Mem.perm_order'' in *. des_ifs.
              replace (_ + _ - _) with (Ptrofs.unsigned i1) by nia. et.
            - destruct i1; ss. nia. }
          i. clarify.
      + iDestruct "P" as "%". des. clarify.
        iDestruct "A" as "%". des. clarify.
        unfold cmp_ptr. des_ifs_safe. unfold Val.cmplu_bool.
        unfold "#^" in *. destruct eq_block. { clarify. rewrite <- Heqo in *. clarify. }
        hred_r.
        iCombine "ALLOC ALLOC_PRE" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz.
        iDestruct "ALLOC" as "[ALLOC ALLOC_PRE]".
        iDestruct "SZ" as "[SZ SZ_PRE]".
        iCombine "ALLOC ALLOC0_PRE" as "ALLOC".
        iCombine "SZ SZ0_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc0.
        iOwnWf "SZ" as wfsz0.
        iDestruct "ALLOC" as "[ALLOC ALLOC0_PRE]".
        iDestruct "SZ" as "[SZ SZ0_PRE]".
        ur in wfalloc. ur in wfsz. rewrite URA.unit_idl in wfalloc. des.
        apply pw_extends in wfalloc. red in wfalloc.
        ur in wfalloc0. ur in wfsz0. rewrite URA.unit_idl in wfalloc0. des.
        apply pw_extends in wfalloc0. red in wfalloc0. ur in wfalloc1.
        specialize (wfsz (Some b)).
        specialize (wfsz0 (Some b0)).
        specialize (wfalloc b).
        specialize (wfalloc0 b0).
        hexploit (SIM_ALLOC (Some b)).
        hexploit (SIM_ALLOC (Some b0)).
        i. des. unfold __allocated_with in *. destruct dec; clarify.
        destruct dec; clarify.
        apply Consent.extends in wfalloc; et. red in wfalloc. des. rewrite wfalloc3 in *.
        apply Consent.extends in wfalloc0; et. red in wfalloc0. des. rewrite wfalloc4 in *.
        apply OneShot.oneshot_initialized in wfsz.
        apply OneShot.oneshot_initialized in wfsz0.
        destruct wfsz as [wfsz|wfsz]; rewrite wfsz in H8; inv H8; clarify.
        destruct wfsz0 as [wfsz0|wfsz0]; rewrite wfsz0 in H4; inv H4; clarify.
        destruct m, m0. unfold "#^", valid in *. ss. rewrite Heqo in *. rewrite Heqo0 in *.
        hexploit SZPOS; et. i.
        hexploit SZPOS0; et. i.
        assert (Mem.valid_pointer mem_tgt b0 (Ptrofs.unsigned i2) = true).
        { bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          unfold size_chunk in *. des_ifs. destruct i2; ss.
          hexploit (PERMinrange0 intval).
          { destruct tag0; try solve [hexploit COMMON0; et; nia| hexploit DYNAMIC0; et; des; nia]. }
          i. des. unfold Mem.perm, Mem.perm_order' in *.
          rewrite H13 in *. apply n0. econs. }
        assert (Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1) = true).
        { bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          unfold size_chunk in *. des_ifs. destruct i1; ss.
          hexploit (PERMinrange intval).
          { destruct tag; try solve [hexploit COMMON; et; nia| hexploit DYNAMIC; et; des; nia]. }
          i. des. unfold Mem.perm, Mem.perm_order' in *.
          rewrite H14 in *. apply n0. econs. }
        rewrite H13. rewrite H14. des_ifs. hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. iSplit; ss.
    - unfold cmp_ptr_hoare7. des_ifs_safe. ss. clarify.
      iDestruct "PRE" as "[[[% P] A] %]".
      do 2 unfold has_offset, _has_offset.
      destruct (blk m) eqn:?; clarify.
      iDestruct "A" as "[ALLOC_PRE [SZ_PRE A]]".
      destruct (blk m0) eqn:?; clarify.
      iDestruct "P" as "[ALLOC0_PRE [SZ0_PRE P]]".
      des; clarify. hred_r.
      iApply isim_pget_tgt. hred_r.
      destruct v0; clarify; des_ifs_safe;
      destruct v; clarify; des_ifs_safe.
      + iDestruct "P" as (a) "[CONC_PRE %]". des. clarify.
        iDestruct "A" as (a0) "[CONC0_PRE %]". des. clarify.
        unfold cmp_ptr. unfold Val.cmplu_bool. des_ifs_safe. hred_r.
        iCombine "ALLOC ALLOC_PRE" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz.
        iDestruct "ALLOC" as "[ALLOC ALLOC_PRE]".
        iDestruct "SZ" as "[SZ SZ_PRE]".
        iCombine "ALLOC ALLOC0_PRE" as "ALLOC".
        iCombine "SZ SZ0_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc0.
        iOwnWf "SZ" as wfsz0.
        iDestruct "ALLOC" as "[ALLOC ALLOC0_PRE]".
        iDestruct "SZ" as "[SZ SZ0_PRE]".
        ur in wfalloc. ur in wfsz. rewrite URA.unit_idl in wfalloc. des.
        apply pw_extends in wfalloc. red in wfalloc.
        ur in wfalloc0. ur in wfsz0. rewrite URA.unit_idl in wfalloc0. des.
        apply pw_extends in wfalloc0. red in wfalloc0. ur in wfalloc1.
        specialize (wfsz (Some b)).
        specialize (wfsz0 (Some b0)).
        specialize (wfalloc b).
        specialize (wfalloc0 b0).
        hexploit (SIM_ALLOC (Some b)).
        hexploit (SIM_ALLOC (Some b0)).
        i. des. unfold __allocated_with in *. destruct dec; clarify.
        destruct dec; clarify.
        apply Consent.extends in wfalloc; et. red in wfalloc. des. rewrite wfalloc3 in *.
        apply Consent.extends in wfalloc0; et. red in wfalloc0. des. rewrite wfalloc4 in *.
        apply OneShot.oneshot_initialized in wfsz.
        apply OneShot.oneshot_initialized in wfsz0.
        destruct wfsz as [wfsz|wfsz]; rewrite wfsz in H12; inv H12; clarify.
        destruct wfsz0 as [wfsz0|wfsz0]; rewrite wfsz0 in H4; inv H4; clarify.
        iCombine "CONC CONC_PRE" as "CONC".
        iOwnWf "CONC" as wfconc.
        iDestruct "CONC" as "[CONC CONC_PRE]".
        iCombine "CONC CONC0_PRE" as "CONC".
        iOwnWf "CONC" as wfconc0.
        iDestruct "CONC" as "[CONC CONC0_PRE]".
        ur in wfconc. specialize (wfconc (Some b0)).
        ur in wfconc0. specialize (wfconc0 (Some b)).
        ss. destruct dec; clarify. destruct dec; clarify.
        apply OneShot.oneshot_initialized in wfconc.
        apply OneShot.oneshot_initialized in wfconc0.
        hexploit (SIM_CONC (Some b)). i.
        hexploit (SIM_CONC (Some b0)). i.
        destruct wfconc as [wfconc|wfconc]; rewrite wfconc in H12; inv H12; clarify.
        destruct wfconc0 as [wfconc0|wfconc0]; rewrite wfconc0 in H4; inv H4; clarify.

        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iApply isim_ret. iSplitL "CNT CONC ALLOC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. iSplitL "CONC_PRE"; cycle 1.
        { iExists _. iFrame. ss. }
        iSplit; ss. 2:{ iExists _. iFrame. ss. }
        iPureIntro. f_equal. pose proof (Int64.eq_spec i2 i1).
        destruct (Int64.eq i2 i1); et. subst. exfalso.
        hexploit paddr_no_overflow_cond_lt; et. i.
        unfold size_chunk in *. des_ifs.
        hexploit (paddr_no_overflow_cond_lt i1 base); et. i.
        assert (init ≤ 0) by now destruct tag; try solve [hexploit COMMON; et; nia|hexploit DYNAMIC; et; des; nia].
        hexploit (PERMinrange (Int64.unsigned i1 - Ptrofs.unsigned base0)); try nia.
        assert (init0 ≤ 0) by now destruct tag0; try solve [hexploit COMMON0; et; nia|hexploit DYNAMIC0; et; des; nia].
        hexploit (PERMinrange0 (Int64.unsigned i1 - Ptrofs.unsigned base)); try nia.
        i. des. pose proof (mem_tgt.(Mem.no_concrete_overlap) (Int64.unsigned i1)).
        red in H25. hexploit (H25 b b0).
        { econs; et.
          - pose proof (mem_tgt.(Mem.access_max) b (Int64.unsigned i1 - Ptrofs.unsigned base0)).
            rewrite H20 in H26. unfold Mem.perm_order'' in *. des_ifs. et.
          - destruct base0; destruct i1; ss.
            change Int64.modulus with (Ptrofs.max_unsigned + 1) in *.
            change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
        { econs; et.
          - pose proof (mem_tgt.(Mem.access_max) b0 (Int64.unsigned i1 - Ptrofs.unsigned base)).
            rewrite H19 in H26. unfold Mem.perm_order'' in *. des_ifs. et.
          - destruct base; destruct i1; ss.
            change Int64.modulus with (Ptrofs.max_unsigned + 1) in *.
            change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
        i. unfold "#^" in *. subst. rewrite <- Heqo in Heqo0. clarify.
      + iDestruct "P" as "%". des. clarify.
        iDestruct "A" as (a) "[CONC_PRE %]". des. clarify.
        iCombine "ALLOC ALLOC_PRE" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz.
        iDestruct "ALLOC" as "[ALLOC ALLOC_PRE]".
        iDestruct "SZ" as "[SZ SZ_PRE]".
        iCombine "ALLOC ALLOC0_PRE" as "ALLOC".
        iCombine "SZ SZ0_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc0.
        iOwnWf "SZ" as wfsz0.
        iDestruct "ALLOC" as "[ALLOC ALLOC0_PRE]".
        iDestruct "SZ" as "[SZ SZ0_PRE]".
        ur in wfalloc. ur in wfsz. rewrite URA.unit_idl in wfalloc. des.
        apply pw_extends in wfalloc. red in wfalloc.
        ur in wfalloc0. ur in wfsz0. rewrite URA.unit_idl in wfalloc0. des.
        apply pw_extends in wfalloc0. red in wfalloc0. ur in wfalloc1.
        specialize (wfsz (Some b)).
        specialize (wfsz0 (Some b0)).
        specialize (wfalloc b).
        specialize (wfalloc0 b0).
        hexploit (SIM_ALLOC (Some b)).
        hexploit (SIM_ALLOC (Some b0)).

        i. des. unfold __allocated_with in *. destruct dec; clarify.
        destruct dec; clarify.
        apply Consent.extends in wfalloc; et. red in wfalloc. des. rewrite wfalloc3 in *.
        apply Consent.extends in wfalloc0; et. red in wfalloc0. des. rewrite wfalloc4 in *.
        apply OneShot.oneshot_initialized in wfsz.
        apply OneShot.oneshot_initialized in wfsz0.
        destruct wfsz as [wfsz|wfsz]; rewrite wfsz in H11; inv H11; clarify.
        destruct wfsz0 as [wfsz0|wfsz0]; rewrite wfsz0 in H4; inv H4; clarify.
        destruct m, m0. unfold "#^", valid in *. ss. rewrite Heqo in *. rewrite Heqo0 in *.
        hexploit SZPOS; et. i.
        hexploit SZPOS0; et. i.
        pose proof (Int64.eq_spec i1 Int64.zero).
        destruct (Int64.eq i1 Int64.zero) eqn: ?.
        { subst. exfalso.
          unfold weak_valid, Ptrofs.sub, Ptrofs.of_int64 in *.
          change (Ptrofs.unsigned (Ptrofs.repr (Int64.unsigned _))) with 0 in *.
          change (0 - Ptrofs.unsigned a) with (- Ptrofs.unsigned a) in *.
          eapply weak_valid_nil_paddr_base; et. 2:{ ii. hexploit H8; clarify. } nia. }
        unfold cmp_ptr_join. ss.
        iCombine "CONC CONC_PRE" as "CONC".
        iOwnWf "CONC" as wfconc.
        ur in wfconc. specialize (wfconc (Some b)). ss. destruct dec; clarify.
        hexploit (SIM_CONC (Some b)). i.
        apply OneShot.oneshot_initialized in wfconc.
        des; rewrite wfconc in *; inv H15; clarify.
        hexploit paddr_no_overflow_cond_lt; et. i.
        assert (to_ptr_val mem_tgt (Vlong i1) = Vptr b (Ptrofs.repr (Int64.unsigned i1 - Ptrofs.unsigned base))).
        { unfold to_ptr_val, Mem.to_ptr.
          des_ifs; [apply Maps.PTree.gselectf in Heq1|apply Maps.PTree.gselectnf in Heq1]; des.
          - ss. unfold Mem.denormalize_aux, Mem.is_valid, Mem.addr_is_in_block in *.
            des_ifs; bsimpl; des; clarify.
            hexploit (PERMinrange (Int64.unsigned i1 - Ptrofs.unsigned base)).
            { unfold size_chunk in *. des_ifs. destruct tag; (hexploit COMMON + hexploit DYNAMIC); et; nia. }
            i. des.
            pose proof (mem_tgt.(Mem.no_concrete_overlap) (Int64.unsigned i1)).
            red in H20. hexploit (H20 b b1).
            { econs; et.
              - epose proof (mem_tgt.(Mem.access_max) b _).
                rewrite H17 in H21. unfold Mem.perm_order'' in *. des_ifs. et.
              - destruct base; destruct i1; ss.
                change Int64.modulus with (Ptrofs.max_unsigned + 1) in *.
                change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
            { econs; et. destruct i1; ss. nia. }
            i. subst. rewrite Heq3 in *. clarify.
          - exfalso. apply Heq1. esplits; et. unfold Mem.denormalize_aux.
            rewrite <- H18. unfold size_chunk in *. des_ifs. bsimpl.
            hexploit (PERMinrange (Int64.unsigned i1 - Ptrofs.unsigned base)); try solve [destruct tag; (hexploit COMMON + hexploit DYNAMIC); et; nia].
            i. unfold Mem.is_valid, Mem.addr_is_in_block in *. rewrite <- H18 in Heq2. des.
            { hexploit (mem_tgt.(Mem.nextblock_noaccess) b); try solve [rewrite H13; et].
              apply Pos.ltb_ge in Heq2. unfold Coqlib.Plt. nia. rewrite H17. et. }
            { des_ifs; bsimpl; des.
              { rewrite PERMoutrange in H17; clarify. destruct tag; (hexploit COMMON + hexploit DYNAMIC); et; nia. }
              { destruct i1; destruct base; ss. change Int64.modulus with Ptrofs.modulus in *. nia. }
              { hexploit (mem_tgt.(Mem.access_max)). rewrite Heq4. rewrite H17. i. inv H20. } } }
        rewrite H16. unfold to_ptr_val at 1. unfold to_int_val at 2. ss.
        unfold cmp_ptr. des_ifs_safe. unfold Val.cmplu_bool at 2.
        rewrite Ptrofs.unsigned_repr; [|destruct base; ss; nia].
        assert (Mem.valid_pointer mem_tgt b0 (Ptrofs.unsigned i2) = true).
        { bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          unfold size_chunk in *. des_ifs. destruct i2; ss.
          hexploit (PERMinrange0 intval).
          { destruct tag0; try solve [hexploit COMMON0; et; nia| hexploit DYNAMIC0; et; des; nia]. }
          i. des. unfold Mem.perm, Mem.perm_order' in *.
          rewrite H17 in *. apply n. econs. }
        assert (Mem.valid_pointer mem_tgt b (Int64.unsigned i1 - Ptrofs.unsigned base) = true).
        { clear H17. bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          unfold size_chunk in *. des_ifs. destruct i1; destruct base; ss.
          hexploit (PERMinrange (intval - intval0)).
          { destruct tag; try solve [hexploit COMMON; et; nia| hexploit DYNAMIC; et; des; nia]. }
          i. des. unfold Mem.perm, Mem.perm_order' in *.
          rewrite H17 in *. apply n. econs. }
        rewrite H19. rewrite H17. ss. destruct eq_block; clarify.
        Local Opaque Val.cmplu_bool.
        des_ifs; hred_r; des_ifs; hred_r.
        Local Transparent Val.cmplu_bool.
        * iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iDestruct "CONC" as "[CONC ?]".
          iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
          iSplit; ss. iFrame. iSplit; ss. iExists _. iFrame. ss.
        * unfold Val.cmplu_bool, to_int_val, Mem.to_int, Mem.ptr2int_v, Mem.ptr2int in *.
          des_ifs. ss. clarify. hexploit Int64.eq_spec.
          destruct (Int64.eq _ i1) eqn:H22; clarify. clear H21. rename H22 into H21.
          i. subst. unfold Mem.valid_pointer in *.
          do 2 destruct Mem.perm_dec; ss; clarify.
          unfold Mem.perm, Mem.perm_order' in *. des_ifs.
          hexploit (mem_tgt.(Mem.weak_valid_address_range) b0); et.
          { apply Ptrofs.unsigned_range. }
          { unfold Mem._weak_valid_pointer, Mem._valid_pointer.
            pose proof (mem_tgt.(Mem.access_max) b0 (Ptrofs.unsigned i2)).
            rewrite Heq4 in H20. unfold Mem.perm_order'' in *.
            des_ifs. rewrite Heq6. left. econs. }
          i. inv H20; ss.
          rewrite Int64.unsigned_repr in *.
          2,3,4: change Int64.max_unsigned with (Ptrofs.modulus - 1); nia.
          pose proof (mem_tgt.(Mem.no_concrete_overlap) (z0 + Ptrofs.unsigned i2)).
          red in H20. hexploit (H20 b b0).
          { econs; et.
            - pose proof (mem_tgt.(Mem.access_max) b (z0 + Ptrofs.unsigned i2 - Ptrofs.unsigned base)).
              rewrite Heq2 in H22. unfold Mem.perm_order'' in *. des_ifs. et.
            - destruct base; destruct i2; ss.
              change Int64.modulus with (Ptrofs.max_unsigned + 1) in *.
              change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
          { econs; et.
            - pose proof (mem_tgt.(Mem.access_max) b0 (Ptrofs.unsigned i2)).
              rewrite Heq4 in H22. unfold Mem.perm_order'' in *. des_ifs.
              replace (_ + _ - _) with (Ptrofs.unsigned i2) by nia. et.
            - destruct i2; ss. nia. }
        i. clarify.
        * iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iDestruct "CONC" as "[CONC ?]".
          iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
          iSplit; ss. iFrame. iSplit; ss. iExists _. iFrame. ss.
      + iDestruct "P" as (a) "[CONC_PRE %]". des. clarify.
        iDestruct "A" as "%". des. clarify.
        iCombine "ALLOC ALLOC_PRE" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz.
        iDestruct "ALLOC" as "[ALLOC ALLOC_PRE]".
        iDestruct "SZ" as "[SZ SZ_PRE]".
        iCombine "ALLOC ALLOC0_PRE" as "ALLOC".
        iCombine "SZ SZ0_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc0.
        iOwnWf "SZ" as wfsz0.
        iDestruct "ALLOC" as "[ALLOC ALLOC0_PRE]".
        iDestruct "SZ" as "[SZ SZ0_PRE]".
        ur in wfalloc. ur in wfsz. rewrite URA.unit_idl in wfalloc. des.
        apply pw_extends in wfalloc. red in wfalloc.
        ur in wfalloc0. ur in wfsz0. rewrite URA.unit_idl in wfalloc0. des.
        apply pw_extends in wfalloc0. red in wfalloc0. ur in wfalloc1.
        specialize (wfsz (Some b)).
        specialize (wfsz0 (Some b0)).
        specialize (wfalloc b).
        specialize (wfalloc0 b0).
        hexploit (SIM_ALLOC (Some b)).
        hexploit (SIM_ALLOC (Some b0)).

        i. des. unfold __allocated_with in *. destruct dec; clarify.
        destruct dec; clarify.
        apply Consent.extends in wfalloc; et. red in wfalloc. des. rewrite wfalloc3 in *.
        apply Consent.extends in wfalloc0; et. red in wfalloc0. des. rewrite wfalloc4 in *.
        apply OneShot.oneshot_initialized in wfsz.
        apply OneShot.oneshot_initialized in wfsz0.
        destruct wfsz as [wfsz|wfsz]; rewrite wfsz in H10; inv H10; clarify.
        destruct wfsz0 as [wfsz0|wfsz0]; rewrite wfsz0 in H4; inv H4; clarify.
        destruct m, m0. unfold "#^", valid in *. ss. rewrite Heqo in *. rewrite Heqo0 in *.
        hexploit SZPOS; et. i.
        hexploit SZPOS0; et. i.
        pose proof (Int64.eq_spec i2 Int64.zero).
        destruct (Int64.eq i2 Int64.zero) eqn: ?.
        { subst. exfalso.
          unfold weak_valid, Ptrofs.sub, Ptrofs.of_int64 in *.
          change (Ptrofs.unsigned (Ptrofs.repr (Int64.unsigned _))) with 0 in *.
          change (0 - Ptrofs.unsigned a) with (- Ptrofs.unsigned a) in *.
          eapply weak_valid_nil_paddr_base; et. 2:{ ii. hexploit H8; clarify. } nia. }
        unfold cmp_ptr_join. ss.
        iCombine "CONC CONC_PRE" as "CONC".
        iOwnWf "CONC" as wfconc.
        ur in wfconc. specialize (wfconc (Some b0)). ss. destruct dec; clarify.
        hexploit (SIM_CONC (Some b0)). i.
        apply OneShot.oneshot_initialized in wfconc.
        des; rewrite wfconc in *; inv H15; clarify.
        hexploit paddr_no_overflow_cond_lt; et. i.
        assert (to_ptr_val mem_tgt (Vlong i2) = Vptr b0 (Ptrofs.repr (Int64.unsigned i2 - Ptrofs.unsigned base))).
        { unfold to_ptr_val, Mem.to_ptr.
          des_ifs; [apply Maps.PTree.gselectf in Heq1|apply Maps.PTree.gselectnf in Heq1]; des.
          - ss. unfold Mem.denormalize_aux, Mem.is_valid, Mem.addr_is_in_block in *.
            des_ifs; bsimpl; des; clarify.
            hexploit (PERMinrange0 (Int64.unsigned i2 - Ptrofs.unsigned base)).
            { unfold size_chunk in *. des_ifs. destruct tag0; (hexploit COMMON0 + hexploit DYNAMIC0); et; nia. }
            i. des.
            pose proof (mem_tgt.(Mem.no_concrete_overlap) (Int64.unsigned i2)).
            red in H20. hexploit (H20 b0 b1).
            { econs; et.
              - epose proof (mem_tgt.(Mem.access_max) b0 _).
                rewrite H17 in H21. unfold Mem.perm_order'' in *. des_ifs. et.
              - destruct base; destruct i2; ss.
                change Int64.modulus with (Ptrofs.max_unsigned + 1) in *.
                change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
            { econs; et. destruct i2; ss. nia. }
            i. subst. rewrite Heq3 in *. clarify.
          - exfalso. apply Heq1. esplits; et. unfold Mem.denormalize_aux.
            rewrite <- H18. unfold size_chunk in *. des_ifs. bsimpl.
            hexploit (PERMinrange0 (Int64.unsigned i2 - Ptrofs.unsigned base)); try solve [destruct tag0; (hexploit COMMON0 + hexploit DYNAMIC0); et; nia].
            i. unfold Mem.is_valid, Mem.addr_is_in_block in *. rewrite <- H18 in Heq2. des.
            { hexploit (mem_tgt.(Mem.nextblock_noaccess) b0); try solve [rewrite H13; et].
              apply Pos.ltb_ge in Heq2. unfold Coqlib.Plt. nia. rewrite H17. et. }
            { des_ifs; bsimpl; des.
              { rewrite PERMoutrange0 in H17; clarify. destruct tag0; (hexploit COMMON0 + hexploit DYNAMIC0); et; nia. }
              { destruct i2; destruct base; ss. change Int64.modulus with Ptrofs.modulus in *. nia. }
              { hexploit (mem_tgt.(Mem.access_max)). rewrite Heq4. rewrite H17. i. inv H20. } } }
        rewrite H16. unfold to_ptr_val at 1. unfold to_int_val at 2. ss.
        unfold cmp_ptr. des_ifs_safe. unfold Val.cmplu_bool at 2.
        rewrite Ptrofs.unsigned_repr; [|destruct base; ss; nia].
        assert (Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1) = true).
        { bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          unfold size_chunk in *. des_ifs. destruct i1; ss.
          hexploit (PERMinrange intval).
          { destruct tag; try solve [hexploit COMMON; et; nia| hexploit DYNAMIC; et; des; nia]. }
          i. des. unfold Mem.perm, Mem.perm_order' in *.
          rewrite H17 in *. apply n. econs. }
        assert (Mem.valid_pointer mem_tgt b0 (Int64.unsigned i2 - Ptrofs.unsigned base) = true).
        { clear H17. bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          unfold size_chunk in *. des_ifs. destruct i2; destruct base; ss.
          hexploit (PERMinrange0 (intval - intval0)).
          { destruct tag0; try solve [hexploit COMMON0; et; nia| hexploit DYNAMIC0; et; des; nia]. }
          i. des. unfold Mem.perm, Mem.perm_order' in *.
          rewrite H17 in *. apply n. econs. }
        rewrite H19. rewrite H17. ss. destruct eq_block; clarify.
        Local Opaque Val.cmplu_bool.
        des_ifs; hred_r; des_ifs; hred_r.
        Local Transparent Val.cmplu_bool.
        * iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iDestruct "CONC" as "[CONC ?]".
          iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
          iSplit; ss. iFrame. iSplit; ss. iSplit; ss. iExists _. iFrame. ss.
        * iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iDestruct "CONC" as "[CONC ?]".
          iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
          iSplit; ss. iFrame. iSplit; ss. iSplit; ss. iExists _. iFrame. ss.
        * unfold Val.cmplu_bool, to_int_val, Mem.to_int, Mem.ptr2int_v, Mem.ptr2int in *.
          des_ifs. ss. clarify. hexploit Int64.eq_spec.
          destruct (Int64.eq i2 (Int64.repr _)) eqn: D; clarify.
          i. subst. unfold Mem.valid_pointer in *.
          do 2 destruct Mem.perm_dec; ss; clarify.
          unfold Mem.perm, Mem.perm_order' in *. des_ifs.
          hexploit (mem_tgt.(Mem.weak_valid_address_range) b); et.
          { apply Ptrofs.unsigned_range. }
          { unfold Mem._weak_valid_pointer, Mem._valid_pointer.
            pose proof (mem_tgt.(Mem.access_max) b (Ptrofs.unsigned i1)).
            rewrite Heq3 in H20. unfold Mem.perm_order'' in *.
            des_ifs. rewrite Heq7. left. econs. }
          i. inv H20; ss.
          rewrite Int64.unsigned_repr in *.
          2,3,4: change Int64.max_unsigned with (Ptrofs.modulus - 1); nia.
          pose proof (mem_tgt.(Mem.no_concrete_overlap) (z0 + Ptrofs.unsigned i1)).
          red in H20. hexploit (H20 b0 b).
          { econs; et.
            - pose proof (mem_tgt.(Mem.access_max) b0 (z0 + Ptrofs.unsigned i1 - Ptrofs.unsigned base)).
              rewrite Heq1 in H21. unfold Mem.perm_order'' in *. des_ifs. et.
            - destruct base; destruct i1; ss.
              change Int64.modulus with (Ptrofs.max_unsigned + 1) in *.
              change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
          { econs; et.
            - pose proof (mem_tgt.(Mem.access_max) b (Ptrofs.unsigned i1)).
              rewrite Heq3 in H21. unfold Mem.perm_order'' in *. des_ifs.
              replace (_ + _ - _) with (Ptrofs.unsigned i1) by nia. et.
            - destruct i1; ss. nia. }
          i. clarify.
      + iDestruct "P" as "%". des. clarify.
        iDestruct "A" as "%". des. clarify.
        unfold cmp_ptr. des_ifs_safe. unfold Val.cmplu_bool.
        unfold "#^" in *. destruct eq_block. { clarify. rewrite <- Heqo in *. clarify. }
        hred_r.
        iCombine "ALLOC ALLOC_PRE" as "ALLOC".
        iCombine "SZ SZ_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc.
        iOwnWf "SZ" as wfsz.
        iDestruct "ALLOC" as "[ALLOC ALLOC_PRE]".
        iDestruct "SZ" as "[SZ SZ_PRE]".
        iCombine "ALLOC ALLOC0_PRE" as "ALLOC".
        iCombine "SZ SZ0_PRE" as "SZ".
        iOwnWf "ALLOC" as wfalloc0.
        iOwnWf "SZ" as wfsz0.
        iDestruct "ALLOC" as "[ALLOC ALLOC0_PRE]".
        iDestruct "SZ" as "[SZ SZ0_PRE]".
        ur in wfalloc. ur in wfsz. rewrite URA.unit_idl in wfalloc. des.
        apply pw_extends in wfalloc. red in wfalloc.
        ur in wfalloc0. ur in wfsz0. rewrite URA.unit_idl in wfalloc0. des.
        apply pw_extends in wfalloc0. red in wfalloc0. ur in wfalloc1.
        specialize (wfsz (Some b)).
        specialize (wfsz0 (Some b0)).
        specialize (wfalloc b).
        specialize (wfalloc0 b0).
        hexploit (SIM_ALLOC (Some b)).
        hexploit (SIM_ALLOC (Some b0)).
        i. des. unfold __allocated_with in *. destruct dec; clarify.
        destruct dec; clarify.
        apply Consent.extends in wfalloc; et. red in wfalloc. des. rewrite wfalloc3 in *.
        apply Consent.extends in wfalloc0; et. red in wfalloc0. des. rewrite wfalloc4 in *.
        apply OneShot.oneshot_initialized in wfsz.
        apply OneShot.oneshot_initialized in wfsz0.
        destruct wfsz as [wfsz|wfsz]; rewrite wfsz in H8; inv H8; clarify.
        destruct wfsz0 as [wfsz0|wfsz0]; rewrite wfsz0 in H4; inv H4; clarify.
        destruct m, m0. unfold "#^", valid in *. ss. rewrite Heqo in *. rewrite Heqo0 in *.
        hexploit SZPOS; et. i.
        hexploit SZPOS0; et. i.
        assert (Mem.valid_pointer mem_tgt b0 (Ptrofs.unsigned i2) = true).
        { bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          unfold size_chunk in *. des_ifs. destruct i2; ss.
          hexploit (PERMinrange0 intval).
          { destruct tag0; try solve [hexploit COMMON0; et; nia| hexploit DYNAMIC0; et; des; nia]. }
          i. des. unfold Mem.perm, Mem.perm_order' in *.
          rewrite H13 in *. apply n0. econs. }
        assert (Mem.valid_pointer mem_tgt b (Ptrofs.unsigned i1) = true).
        { bsimpl. unfold Mem.valid_pointer.
          repeat destruct Mem.perm_dec; ss; clarify; et; exfalso.
          unfold size_chunk in *. des_ifs. destruct i1; ss.
          hexploit (PERMinrange intval).
          { destruct tag; try solve [hexploit COMMON; et; nia| hexploit DYNAMIC; et; des; nia]. }
          i. des. unfold Mem.perm, Mem.perm_order' in *.
          rewrite H14 in *. apply n0. econs. }
        rewrite H13. rewrite H14. des_ifs. hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iApply isim_ret. iSplitL "CNT ALLOC CONC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
        iSplit; ss. iFrame. iSplit; ss.
    Unshelve. all: et.
  Qed.

  Lemma sim_non_null :
    sim_fnsem wf top2
      ("non_null?", fun_to_tgt "Mem" (to_stb []) (mk_pure non_null_spec))
      ("non_null?", cfunU non_nullF).
  Proof.
    econs; ss. red; ss. apply isim_fun_to_tgt; ss.
    i. iIntros "[INV PRE]". des_ifs. ss.
    do 2 unfold has_offset, _has_offset, points_to, _points_to.
    iDestruct "PRE" as "[[% P] %]". des.
    destruct blk eqn:?; clarify.
    iDestruct "P" as "[ALLOC_PRE [SZ_PRE A]]".
    des; clarify. unfold inv_with.
    iDestruct "INV" as (tt) "[INV %]".
    iDestruct "INV" as (mem_tgt memcnt_src memalloc_src memsz_src memconc_src) "[[[[% CNT] ALLOC] CONC] SZ]".
    des; clarify.
    unfold non_nullF. hred_r.
    iApply isim_pget_tgt. hred_r.
    destruct v; destruct Archi.ptr64 eqn:?; ss; clarify.
    { iDestruct "A" as (a) "[CONC_PRE %]". des; clarify. hred_r.
      iApply isim_apc. iExists None.
      hred_l. iApply isim_choose_src. iExists _.
      iApply isim_ret. iSplitL "CNT CONC ALLOC SZ".
      { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
      iSplit; ss. iFrame. iSplit; [|iExists _; iFrame; ss].
      unfold Int64.eq. destruct Coqlib.zeq; et.
      change (Int64.unsigned Int64.zero) with 0 in *.
      unfold weak_valid, Ptrofs.sub, Ptrofs.of_int64 in H5.
      rewrite <- e in *.
      change (Ptrofs.unsigned (Ptrofs.repr 0)) with 0 in *. exfalso.
      eapply weak_valid_nil_paddr_base; et. ii. hexploit H6; clarify. }
    iDestruct "A" as "%". des. clarify.
    iAssert ⌜Mem.weak_valid_pointer mem_tgt b (Ptrofs.unsigned i0) = true⌝%I as "%"; cycle 1.
    { rewrite H4. hred_r.
      iApply isim_apc. iExists None.
      hred_l. iApply isim_choose_src. iExists _.
      iApply isim_ret. iSplitL "CNT CONC ALLOC SZ".
      { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
      iSplit; ss. iFrame. iSplit; ss. }
    unfold Mem.weak_valid_pointer. unfold Mem.valid_pointer.
    do 2 destruct Mem.perm_dec; clarify. ss.
    unfold Mem.perm in *. unfold weak_valid in *.
    iCombine "ALLOC ALLOC_PRE" as "ALLOC".
    iCombine "SZ SZ_PRE" as "SZ".
    iOwnWf "ALLOC" as wfalloc.
    iOwnWf "SZ" as wfsz.
    ur in wfalloc. des. rewrite URA.unit_idl in wfalloc.
    ur in wfalloc0. apply pw_extends in wfalloc. spc wfalloc.
    ur in wfsz. specialize (wfsz (Some b)). specialize (SIM_ALLOC (Some b)).
    unfold __allocated_with in *. ss.
    destruct dec; clarify. apply Consent.extends in wfalloc; et. red in wfalloc. des.
    rewrite wfalloc1 in *. apply OneShot.oneshot_initialized in wfsz.
    des; rewrite wfsz in *; inv SIM_ALLOC; clarify.
    destruct (Coqlib.zeq (Ptrofs.unsigned i0) (sz m)).
    { destruct m. ss. rewrite Heqo in *. hexploit SZPOS; et. i.
      hexploit (PERMinrange (Ptrofs.unsigned i0 - 1)).
      { split; try nia. destruct i0; ss. unfold size_chunk in *. des_ifs.
        destruct tag; try solve [hexploit COMMON; et; nia|hexploit DYNAMIC; et; des; nia]. }
      i. des. rewrite H6 in *. exfalso. apply n0. econs. }
    hexploit (PERMinrange (Ptrofs.unsigned i0)).
    { destruct i0; ss. unfold size_chunk in *. des_ifs.
      destruct tag; try solve [hexploit COMMON; et; nia|hexploit DYNAMIC; et; des; nia]. }
    i. des. rewrite H4 in *. exfalso. apply n. econs.
  Unshelve. all: et.
  Qed.

  Lemma sim_memcpy :
    sim_fnsem wf top2
      ("memcpy", fun_to_tgt "Mem" (to_stb []) (mk_pure memcpy_spec))
      ("memcpy", cfunU memcpyF).
  Proof.
    Local Transparent Mem.loadbytes.
    Local Transparent Mem.storebytes.
    econs; ss. red; ss. apply isim_fun_to_tgt; ss.
    i. unfold "@".
    iIntros "[INV PRE]".
    iDestruct "INV" as (tt) "[INV %]".
    iDestruct "INV" as (mem_tgt memcnt_src memalloc_src memsz_src memconc_src) "[[[[% CNT] ALLOC] CONC] SZ]".
    des; clarify. unfold memcpyF. do 2 (try destruct x as [?|x]).
    - unfold memcpy_hoare0. des_ifs_safe. ss. clarify.
      iDestruct "PRE" as "[PRE %]".
      iDestruct "PRE" as (al sz mvs_dst) "[[[[% F] D] P] A]".
      do 2 unfold has_offset, points_to, _has_offset, _points_to.
      destruct blk; clarify.
      destruct blk; clarify.
      iDestruct "P" as "[SZ_PRE P]".
      iDestruct "P" as (ofs) "[[[CNT_PRE [SZ0_PRE P]] %] LEN]".
      iDestruct "A" as "[SZ1_PRE A]".
      iDestruct "A" as (ofs0) "[[[CNT0_PRE [SZ2_PRE A]] %] LEN0]".
      iDestruct "D" as "[ALLOC_PRE [SZ3_PRE D]]".
      iDestruct "F" as "[ALLOC0_PRE [SZ4_PRE F]]".
      do 7 (destruct H5 as [? H5]). clarify. hred_r.

      iCombine "CNT CNT_PRE" as "CNT".
      iOwnWf "CNT" as wfcnt.
      iDestruct "CNT" as "[CNT CNT_PRE]".
      iCombine "CNT CNT0_PRE" as "CNT".
      iOwnWf "CNT" as wfcnt0.
      iDestruct "CNT" as "[CNT CNT0_PRE]".
      ur in wfcnt. rewrite URA.unit_idl in wfcnt. destruct wfcnt as [wfcnt wfcnt1].
      apply pw_extends in wfcnt. specialize (wfcnt b).
      apply pw_extends in wfcnt. do 2 ur in wfcnt1.
      ur in wfcnt0. rewrite URA.unit_idl in wfcnt0. destruct wfcnt0 as [wfcnt0 wfcnt2].
      apply pw_extends in wfcnt0. specialize (wfcnt0 b0).
      apply pw_extends in wfcnt0. do 2 ur in wfcnt2.
      dup SIM_CNT. dup SIM_CNT. specialize (SIM_CNT b). specialize (SIM_CNT0 b0).
      unfold __points_to in wfcnt, wfcnt0. destruct (dec b b); clarify. destruct (dec b0 b0); clarify.
      assert (Mem.loadbytes mem_tgt b (Ptrofs.unsigned ofs) sz = Some l).
      { unfold Mem.loadbytes. destruct Mem.range_perm_dec; cycle 1.
        - exfalso. apply n. unfold Mem.range_perm, Mem.perm. i.
          specialize (wfcnt ofs1). destruct Coqlib.zle; destruct Coqlib.zlt; try nia.
          ss. destruct nth_error eqn:?; cycle 1. { apply nth_error_None in Heqo. nia. }
          apply Consent.extends in wfcnt; et. clear H10. red in wfcnt. des.
          destruct ofs; ss. hexploit (SIM_CNT ofs1); try nia. i. rewrite wfcnt3 in *.
          inv H14. clarify. rewrite PERM. et.
        - f_equal. apply nth_error_ext. i. destruct (Coqlib.zlt i1 (Z.to_nat sz)); cycle 1.
          { edestruct nth_error_None. rewrite H14. 2:{ rewrite Mem.getN_length. nia. }
            edestruct nth_error_None. rewrite H16; et. nia. }
          rewrite nth_error_getN; try nia.
          specialize (wfcnt (Ptrofs.unsigned ofs + i1)). destruct Coqlib.zle; destruct Coqlib.zlt; try nia.
          ss. destruct nth_error eqn:?; cycle 1. { apply nth_error_None in Heqo. nia. }
          apply Consent.extends in wfcnt; et. clear H10. red in wfcnt. des.
          destruct ofs; ss. hexploit (SIM_CNT (intval + i1)); try nia. i. rewrite wfcnt3 in *.
          inv H7. clarify. rewrite <- Heqo. replace (Z.to_nat _) with i1 by nia. et. }
      assert (Mem.range_perm mem_tgt b0 (Ptrofs.unsigned ofs0) (Ptrofs.unsigned ofs0 + length mvs_dst) Cur Writable).
      { unfold Mem.range_perm, Mem.perm. i.
        specialize (wfcnt0 ofs1). destruct Coqlib.zle; destruct Coqlib.zlt; try nia.
        ss. destruct nth_error eqn:?; cycle 1. { apply nth_error_None in Heqo. nia. }
        apply Consent.extends in wfcnt0; et. clear H10. red in wfcnt0. des.
        destruct ofs0; ss. hexploit (SIM_CNT0 ofs1); try nia. i. rewrite wfcnt3 in *.
        inv H15. clarify. rewrite PERM. apply Qwrite. eapply antisymmetry; et. }
      iCombine "CNT CNT0_PRE" as "CNT".
      iPoseProof (OwnM_Upd with "CNT") as ">[CNT CNT0_POST]".
      + eapply Auth.auth_update.
        instantiate (1:= __points_to b0 (Ptrofs.unsigned ofs0) l 1).
        instantiate (1:= update memcnt_src b0
                          (fun _ofs =>
                            if Coqlib.zle (Ptrofs.unsigned ofs0) _ofs && Coqlib.zlt _ofs (Ptrofs.unsigned ofs0 + length l)
                            then
                              match nth_error l (Z.to_nat (_ofs - (Ptrofs.unsigned ofs0))) with
                              | Some mv => Consent.just Q1 mv
                              | None => Consent.unit
                              end
                            else memcnt_src b0 _ofs)).
        ii. destruct H15. split.
        { red. do 2 ur. i. unfold update. destruct dec; clarify. des_ifs; clarify; ur; ss. }
        red. extensionalities. rewrite H16. do 2 ur. unfold update.
        destruct dec; clarify; cycle 1.
        { unfold __points_to. destruct dec; clarify. }
        eassert (memcnt_src H17 H18 = _ H17 H18) by now rewrite H16; refl.
        do 2 ur in H19. unfold __points_to in H19. destruct dec; clarify; ss.
        case_points_to; clarify; ss.
        { destruct nth_error eqn: X; cycle 1. { apply nth_error_None in X. nia. }
          destruct Coqlib.zlt; try nia; ss.
          replace (ctx H17 H18) with (Consent.unit (X:=memval)); [ur; des_ifs|].
          specialize (wfcnt2 H17 H18). rewrite H19 in wfcnt2. ur in wfcnt2. des_ifs.
          apply Qp_not_add_le_l in wfcnt2. ss. }
        rewrite URA.unit_idl. destruct Coqlib.zlt; try nia; ss.
        rewrite URA.unit_idl. et.
      + destruct dec.
        { hred_r. subst. destruct mvs_dst; clarify. destruct l; clarify.
          iApply isim_apc. iExists None.
          hred_l. iApply isim_choose_src. iExists _.
          iApply isim_ret.
          iSplitL "CNT CONC ALLOC SZ".
          { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro.
            splits; et. i. unfold update. destruct dec; et. subst. des_ifs; et.
            { destruct (Z.to_nat (ofs1 - _)); clarify. } }
          iSplit; ss. iFrame. iSplitR "LEN0 A CNT_PRE".
          iSplit; ss. iExists _. iFrame. iSplit; ss. do 2 rewrite points_to_nil. iFrame.
          iExists _. iFrame. iSplit; ss. do 2 rewrite points_to_nil. iFrame. }
        hred_r. iApply isim_pget_tgt. hred_r.
        iAssert ⌜i0 = ofs /\ i = ofs0⌝%I as "%".
        { clear H10. des_ifs.
          - iDestruct "F" as (a) "[F %]".
            iDestruct "D" as (a0) "[D %]".
            iDestruct "P" as (a1) "[P %]".
            iDestruct "A" as (a2) "[A %]".
            iCombine "F P" as "B".
            iCombine "D A" as "B0".
            do 2 rewrite _has_base_unique.
            iDestruct "B" as "%".
            iDestruct "B0" as "%".
            des. iPureIntro. clarify.
          - iDestruct "F" as (a) "[F %]".
            iDestruct "D" as "%".
            iDestruct "P" as (a1) "[P %]".
            iDestruct "A" as "%".
            iCombine "F P" as "B".
            rewrite _has_base_unique.
            iDestruct "B" as "%".
            des. iPureIntro. clarify.
          - iDestruct "F" as "%".
            iDestruct "D" as (a0) "[D %]".
            iDestruct "P" as "%".
            iDestruct "A" as (a2) "[A %]".
            iCombine "D A" as "B0".
            rewrite _has_base_unique.
            iDestruct "B0" as "%".
            des. iPureIntro. clarify.
          - iDestruct "F" as "%".
            iDestruct "D" as "%".
            iDestruct "P" as "%".
            iDestruct "A" as "%".
            des. iPureIntro. clarify. }
        destruct H15. subst.
        iAssert ⌜Mem.to_ptr v mem_tgt = Some (Vptr b0 ofs0)⌝%I as "%".
        { clear H10. iClear "F P LEN".
          unfold Mem.to_ptr. destruct v; clarify; cycle 1.
          { iDestruct "A" as "%". des. clarify. }
          destruct Archi.ptr64; ss.
          iDestruct "A" as (a) "[A %]".
          iDestruct "D" as (a0) "[D %]".
          hexploit (SIM_CONC (Some b0)). i.
          iCombine "A D" as "CONC_PRE". iPoseProof (_has_base_unique with "CONC_PRE") as "%".
          subst. iDestruct "CONC_PRE" as "[_ CONC_PRE]".
          des. clarify.
          iCombine "CONC CONC_PRE" as "CONC".
          iOwnWf "CONC" as wfconc.
          ur in wfconc. specialize (wfconc (Some b0)). ss. destruct dec; clarify.
          apply OneShot.oneshot_initialized in wfconc.
          des; rewrite wfconc in *; inv H16; clarify.
          pose proof (Int64.eq_spec i Int64.zero).
          destruct (Int64.eq i Int64.zero).
          { subst. exfalso. eapply (weak_valid_nil_paddr_base base); et. 2:{ ii. hexploit H19; clarify. } unfold Ptrofs.sub, Ptrofs.of_int64 in *. change (Ptrofs.unsigned (Ptrofs.repr (Int64.unsigned Int64.zero))) with 0 in H6. rewrite Z.sub_0_l in H6. nia. }
          unfold Mem.denormalize.
          hexploit (paddr_no_overflow_cond i); et; try nia. i.
          unfold Ptrofs.sub, Ptrofs.of_int64 in *.
          rewrite (Ptrofs.unsigned_repr (Int64.unsigned i)) in *; try apply Int64.unsigned_range_2.
          destruct base; ss.
          rewrite Ptrofs.unsigned_repr in *; try nia.
          hexploit (SIM_CNT0 (Int64.unsigned i - intval)); try nia. i.
          specialize (wfcnt0 (Int64.unsigned i - intval)).
          destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia.
          destruct nth_error eqn:?. 2:{ rewrite nth_error_None in Heqo. nia. }
          apply Consent.extends in wfcnt0; et. red in wfcnt0. des. rewrite wfcnt3 in *.
          inv H21; clarify.
          hexploit mem_tgt.(Mem.access_max).
          rewrite PERM. i. unfold Mem.perm_order'' in *.
          des_ifs; cycle 1.
          { exfalso. apply Maps.PTree.gselectnf in Heq. apply Heq.
            eexists _,_. split; et. unfold Mem.denormalize_aux. rewrite <- H22.
            unfold Mem.addr_is_in_block. rewrite <- H22.
            des_ifs. unfold Mem.is_valid in Heq1. bsimpl.
            hexploit mem_tgt.(Mem.nextblock_noaccess); try rewrite PERM; i; clarify.
            des; try nia. { unfold Coqlib.Plt. apply Pos.ltb_ge in Heq1. nia. }
            change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
          apply Maps.PTree.gselectf in Heq. des.
          unfold Mem.denormalize_aux, Mem.addr_is_in_block in *. des_ifs; bsimpl; clarify.
          des. pose proof (mem_tgt.(Mem.no_concrete_overlap) (Int64.unsigned i)).
          red in H24. hexploit H24.
          { econs; et. nia. }
          { econs. 1: rewrite H22; et. { eexists. rewrite Heq0. et. }
            change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
          i. subst. iPureIntro. do 2 f_equal.
          rewrite <- H22 in Heq2. clarify. }
        iAssert ⌜Mem.to_ptr v0 mem_tgt = Some (Vptr b ofs)⌝%I as "%".
        { clear H10. iClear "A D LEN0".
          unfold Mem.to_ptr. destruct v0; clarify; cycle 1.
          { iDestruct "F" as "%". des. clarify. }
          destruct Archi.ptr64; ss.
          iDestruct "F" as (a) "[F %]".
          iDestruct "P" as (a0) "[P %]".
          hexploit (SIM_CONC (Some b)). i.
          iCombine "F P" as "CONC_PRE". iPoseProof (_has_base_unique with "CONC_PRE") as "%".
          subst. iDestruct "CONC_PRE" as "[_ CONC_PRE]".
          des. clarify.
          iCombine "CONC CONC_PRE" as "CONC".
          iOwnWf "CONC" as wfconc.
          ur in wfconc. specialize (wfconc (Some b)). ss. destruct dec; clarify.
          apply OneShot.oneshot_initialized in wfconc.
          des; rewrite wfconc in *; inv H17; clarify.
          pose proof (Int64.eq_spec i Int64.zero).
          destruct (Int64.eq i Int64.zero).
          { subst. exfalso. eapply (weak_valid_nil_paddr_base base); et. 2:{ ii. hexploit H18; clarify. } unfold Ptrofs.sub, Ptrofs.of_int64 in *. change (Ptrofs.unsigned (Ptrofs.repr (Int64.unsigned Int64.zero))) with 0 in H4. rewrite Z.sub_0_l in H4. nia. }
          unfold Mem.denormalize.
          hexploit (paddr_no_overflow_cond i); et; try nia. i.
          unfold Ptrofs.sub, Ptrofs.of_int64 in *.
          rewrite (Ptrofs.unsigned_repr (Int64.unsigned i)) in *; try apply Int64.unsigned_range_2.
          destruct base; ss.
          rewrite Ptrofs.unsigned_repr in *; try nia.
          hexploit (SIM_CNT (Int64.unsigned i - intval)); try nia. i.
          specialize (wfcnt (Int64.unsigned i - intval)).
          destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia.
          destruct nth_error eqn:?. 2:{ rewrite nth_error_None in Heqo. nia. }
          apply Consent.extends in wfcnt; et. red in wfcnt. des. rewrite wfcnt3 in *.
          inv H22; clarify.
          hexploit mem_tgt.(Mem.access_max).
          rewrite PERM. i. unfold Mem.perm_order'' in *.
          des_ifs; cycle 1.
          { exfalso. apply Maps.PTree.gselectnf in Heq. apply Heq.
            eexists _,_. split; et. unfold Mem.denormalize_aux. rewrite <- H23.
            unfold Mem.addr_is_in_block. rewrite <- H23.
            des_ifs. unfold Mem.is_valid in Heq1. bsimpl.
            hexploit mem_tgt.(Mem.nextblock_noaccess); try rewrite PERM; i; clarify.
            des; try nia. { unfold Coqlib.Plt. apply Pos.ltb_ge in Heq1. nia. }
            change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
          apply Maps.PTree.gselectf in Heq. des.
          unfold Mem.denormalize_aux, Mem.addr_is_in_block in *. des_ifs; bsimpl; clarify.
          des. pose proof (mem_tgt.(Mem.no_concrete_overlap) (Int64.unsigned i)).
          red in H25. hexploit H25.
          { econs; et. nia. }
          { econs. 1: rewrite H23; et. { eexists. rewrite Heq0. et. }
            change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
          i. subst. iPureIntro. do 2 f_equal.
          rewrite <- H23 in Heq2. clarify. }
        rewrite H15. rewrite H16. hred_r.
        set (_ && _) as chk1.
        assert (chk1 = true).
        { unfold chk1. bsimpl.
          repeat destruct dec; repeat destruct Zdivide_dec; destruct Coqlib.zle; ss; clarify; et; try tauto. }
        rewrite H17. ss. destruct Coqlib.zle; clarify.
        destruct Zdivide_dec; clarify. ss.
        set (_ || _) as chk4. clear H10.
        iAssert ⌜chk4 = true⌝%I as "%".
        { iCombine "CNT_PRE CNT0_POST" as "contra".
          iOwnWf "contra" as wfcontra. iPureIntro.
          unfold chk4. bsimpl. destruct (dec b b0); clarify; et.
          destruct Coqlib.zle; et.
          destruct Coqlib.zle; et.
          destruct (dec (Ptrofs.unsigned ofs0) _); et.
          exfalso. do 3 ur in wfcontra. spc wfcontra.
          unfold __points_to in wfcontra. destruct (dec b0 b0); clarify.
          ss. destruct (Coqlib.zlt (Ptrofs.unsigned ofs) (Ptrofs.unsigned ofs0)).
          - specialize (wfcontra (Ptrofs.unsigned ofs0)).
            do 2 destruct Coqlib.zle;
            do 2 destruct Coqlib.zlt; ss; try nia.
            destruct nth_error eqn:?; cycle 1. { rewrite nth_error_None in Heqo. nia. }
            destruct nth_error eqn:? in wfcontra; cycle 1. { rewrite nth_error_None in Heqo0. nia. }
            ur in wfcontra. des_ifs. eapply Qp_not_add_le_r; et.
          - specialize (wfcontra (Ptrofs.unsigned ofs)).
            do 2 destruct Coqlib.zle;
            do 2 destruct Coqlib.zlt; ss; try nia.
            destruct nth_error eqn:?; cycle 1. { rewrite nth_error_None in Heqo. nia. }
            destruct nth_error eqn:? in wfcontra; cycle 1. { rewrite nth_error_None in Heqo0. nia. }
            ur in wfcontra. des_ifs. eapply Qp_not_add_le_r; et. }
        rewrite H10. ss.
        rewrite H7. hred_r.
        unfold Mem.storebytes. rewrite <- H8 in H14.
        destruct Mem.range_perm_dec; clarify. hred_r.
        iApply isim_pput_tgt. hred_r.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iApply isim_ret. iSplitL "CNT CONC ALLOC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. splits; et; ss.
          2:{ i. specialize (SIM_ALLOC ob). des_ifs. clear H10. des. split; et.
              destruct (dec b1 b0); cycle 1. { rewrite Maps.PMap.gso; et. }
              subst. rewrite Maps.PMap.gss. inv SIM_ALLOC. 2:{ econs 2. }
              econs; et. i. rewrite Mem.getN_setN_outside; et.
              unfold size_chunk_nat, size_chunk. des_ifs. destruct ofs0; ss.
              nia. }
          i. unfold update. clear H10.
          destruct (dec b0 b1); subst. 2:{ rewrite Maps.PMap.gso; et. }
          rewrite Maps.PMap.gss. des_ifs.
          2:{ rewrite Mem.setN_outside; et.
              destruct Coqlib.zle in Heq; destruct Coqlib.zlt in Heq; ss; try nia. }
          { erewrite setN_inside; et. 2:{ destruct Coqlib.zle in Heq; destruct Coqlib.zlt in Heq; ss; try nia. }
            hexploit (SIM_CNT0 ofs1); try nia. i.
            specialize (wfcnt0 ofs1).
            destruct Coqlib.zle in Heq; destruct Coqlib.zlt in Heq; ss; try nia.
            destruct Coqlib.zle in wfcnt0; destruct Coqlib.zlt in wfcnt0; ss; try nia.
            destruct nth_error eqn:?. 2:{ rewrite nth_error_None in Heqo. nia. }
            apply Consent.extends in wfcnt0; et. red in wfcnt0. des. rewrite wfcnt3 in *.
            inv H10; clarify.
            econs; et. i. apply Qwrite. eapply antisymmetry; et. } }
        iSplit; ss. iFrame. iSplitL "F CNT_PRE LEN".
        { iSplit; ss. iExists _. iFrame. ss. }
        iExists _. iFrame. rewrite H8 in *. iSplit; ss.
    - unfold memcpy_hoare1. des_ifs_safe. ss. clarify.
      iDestruct "PRE" as "[PRE %]".
      iDestruct "PRE" as (al sz) "[[% P] A]".
      do 2 unfold has_offset, points_to, _has_offset, _points_to.
      destruct blk; clarify.
      iDestruct "A" as "[SZ_PRE A]".
      iDestruct "A" as (ofs) "[[[CNT_PRE [SZ0_PRE A]] %] LEN]".
      iDestruct "P" as "[ALLOC_PRE [SZ3_PRE P]]".
      do 5 (destruct H5 as [? H5]). clarify. hred_r.
      iCombine "CNT CNT_PRE" as "CNT".
      iOwnWf "CNT" as wfcnt.
      iDestruct "CNT" as "[CNT CNT_PRE]".
      ur in wfcnt. rewrite URA.unit_idl in wfcnt. destruct wfcnt as [wfcnt wfcnt1].
      apply pw_extends in wfcnt. specialize (wfcnt b).
      apply pw_extends in wfcnt. do 2 ur in wfcnt1.
      dup SIM_CNT. specialize (SIM_CNT b).
      unfold __points_to in wfcnt. destruct (dec b b); clarify. ss.
      assert (Mem.loadbytes mem_tgt b (Ptrofs.unsigned ofs) sz = Some l).
      { unfold Mem.loadbytes. destruct Mem.range_perm_dec; cycle 1.
        - exfalso. apply n. unfold Mem.range_perm, Mem.perm. i.
          specialize (wfcnt ofs0). destruct Coqlib.zle; destruct Coqlib.zlt; try nia.
          ss. destruct nth_error eqn:?; cycle 1. { apply nth_error_None in Heqo. nia. }
          apply Consent.extends in wfcnt; et. clear H8. red in wfcnt. des.
          destruct ofs; ss. hexploit (SIM_CNT ofs0); try nia. i. rewrite wfcnt0 in *.
          inv H11. clarify. rewrite PERM. et.
        - f_equal. apply nth_error_ext. i. destruct (Coqlib.zlt i0 (Z.to_nat sz)); cycle 1.
          { edestruct nth_error_None. rewrite H11. 2:{ rewrite Mem.getN_length. nia. }
            edestruct nth_error_None. rewrite H13; et. nia. }
          rewrite nth_error_getN; try nia.
          specialize (wfcnt (Ptrofs.unsigned ofs + i0)). destruct Coqlib.zle; destruct Coqlib.zlt; try nia.
          ss. destruct nth_error eqn:?; cycle 1. { apply nth_error_None in Heqo. nia. }
          apply Consent.extends in wfcnt; et. clear H10. red in wfcnt. clear H8. des.
          destruct ofs; ss. hexploit (SIM_CNT (intval + i0)); try nia. i. rewrite wfcnt0 in *.
          inv H6. clarify. rewrite <- Heqo. replace (Z.to_nat _) with i0 by nia. et. }
      assert (Mem.range_perm mem_tgt b (Ptrofs.unsigned ofs) (Ptrofs.unsigned ofs + length l) Cur Writable).
      { unfold Mem.range_perm, Mem.perm. i.
        specialize (wfcnt ofs0). destruct Coqlib.zle; destruct Coqlib.zlt; try nia.
        ss. destruct nth_error eqn:?; cycle 1. { apply nth_error_None in Heqo. nia. }
        apply Consent.extends in wfcnt; et. clear H8. red in wfcnt. des.
        destruct ofs; ss. hexploit (SIM_CNT ofs0); try nia. i. rewrite wfcnt0 in *.
        inv H12. clarify. rewrite PERM. apply Qwrite. eapply antisymmetry; et. }
      destruct dec.
      { hred_r. subst. destruct l; clarify.
        iApply isim_apc. iExists None.
        hred_l. iApply isim_choose_src. iExists _.
        iApply isim_ret.
        iSplitL "CNT CONC ALLOC SZ".
        { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. splits; et. }
        iSplit; ss. iFrame. iSplit; ss. iExists _. iFrame. ss. }
      hred_r. iApply isim_pget_tgt. hred_r.
      iAssert ⌜i = ofs⌝%I as "%".
      { clear H8. des_ifs.
        - iDestruct "P" as (a1) "[P %]".
          iDestruct "A" as (a2) "[A %]".
          iCombine "P A" as "B".
          rewrite _has_base_unique.
          iDestruct "B" as "%".
          des. iPureIntro. clarify.
        - iDestruct "P" as "%".
          iDestruct "A" as "%".
          des. iPureIntro. clarify. }
      subst.
      iAssert ⌜Mem.to_ptr v mem_tgt = Some (Vptr b ofs)⌝%I as "%".
      { clear H8.
        unfold Mem.to_ptr. destruct v; clarify; cycle 1.
        { iDestruct "A" as "%". des. clarify. }
        destruct Archi.ptr64; ss.
        iDestruct "A" as (a) "[A %]".
        iDestruct "P" as (a0) "[P %]".
        hexploit (SIM_CONC (Some b)). i.
        iCombine "A P" as "CONC_PRE". iPoseProof (_has_base_unique with "CONC_PRE") as "%".
        subst. iDestruct "CONC_PRE" as "[_ CONC_PRE]".
        des. clarify.
        iCombine "CONC CONC_PRE" as "CONC".
        iOwnWf "CONC" as wfconc.
        ur in wfconc. specialize (wfconc (Some b)). ss. destruct dec; clarify.
        apply OneShot.oneshot_initialized in wfconc.
        des; rewrite wfconc in *; inv H13; clarify.
        pose proof (Int64.eq_spec i Int64.zero).
        destruct (Int64.eq i Int64.zero).
        { subst. exfalso. eapply (weak_valid_nil_paddr_base base); et. 2:{ ii. hexploit H14; clarify. } unfold Ptrofs.sub, Ptrofs.of_int64 in *. change (Ptrofs.unsigned (Ptrofs.repr (Int64.unsigned Int64.zero))) with 0 in H4. rewrite Z.sub_0_l in H4. nia. }
        unfold Mem.denormalize.
        hexploit (paddr_no_overflow_cond i); et; try nia. i.
        unfold Ptrofs.sub, Ptrofs.of_int64 in *.
        rewrite (Ptrofs.unsigned_repr (Int64.unsigned i)) in *; try apply Int64.unsigned_range_2.
        destruct base; ss.
        rewrite Ptrofs.unsigned_repr in *; try nia.
        hexploit (SIM_CNT (Int64.unsigned i - intval)); try nia. i.
        specialize (wfcnt (Int64.unsigned i - intval)).
        destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia.
        destruct nth_error eqn:?. 2:{ rewrite nth_error_None in Heqo. nia. }
        apply Consent.extends in wfcnt; et. red in wfcnt. des. rewrite wfcnt0 in *.
        inv H18; clarify.
        hexploit mem_tgt.(Mem.access_max).
        rewrite PERM. i. unfold Mem.perm_order'' in *.
        des_ifs; cycle 1.
        { exfalso. apply Maps.PTree.gselectnf in Heq. apply Heq.
          eexists _,_. split; et. unfold Mem.denormalize_aux. rewrite <- H19.
          unfold Mem.addr_is_in_block. rewrite <- H19.
          des_ifs. unfold Mem.is_valid in Heq1. bsimpl.
          hexploit mem_tgt.(Mem.nextblock_noaccess); try rewrite PERM; i; clarify.
          des; try nia. { unfold Coqlib.Plt. apply Pos.ltb_ge in Heq1. nia. }
          change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
        apply Maps.PTree.gselectf in Heq. des.
        unfold Mem.denormalize_aux, Mem.addr_is_in_block in *. des_ifs; bsimpl; clarify.
        des. pose proof (mem_tgt.(Mem.no_concrete_overlap) (Int64.unsigned i)).
        red in H21. hexploit H21.
        { econs; et. nia. }
        { econs. 1: rewrite H19; et. { eexists. rewrite Heq0. et. }
          change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
        i. subst. iPureIntro. do 2 f_equal.
        rewrite <- H19 in Heq2. clarify. }
      rewrite H12. hred_r.
      set (_ && _) as chk1.
      assert (chk1 = true).
      { unfold chk1. bsimpl.
        repeat destruct dec; repeat destruct Zdivide_dec; destruct Coqlib.zle; ss; clarify; et; try tauto. }
      clear H8.
      rewrite H13. ss. destruct Coqlib.zle; clarify.
      destruct Zdivide_dec; clarify. ss.
      set (_ || _) as chk4.
      assert (chk4 = true).
      { unfold chk4. bsimpl. destruct (dec (Ptrofs.unsigned _) _); et. }
      rewrite H8. ss.
      rewrite H6. hred_r.
      unfold Mem.storebytes.
      destruct Mem.range_perm_dec; clarify. hred_r.
      iApply isim_pput_tgt. hred_r.
      iApply isim_apc. iExists None.
      hred_l. iApply isim_choose_src. iExists _.
      iApply isim_ret. iSplitL "CNT CONC ALLOC SZ".
      { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. splits; et; ss.
        2:{ i. specialize (SIM_ALLOC ob). des_ifs. des. split; et.
            destruct (dec b b0); cycle 1. { rewrite Maps.PMap.gso; et. }
            subst. rewrite Maps.PMap.gss. inv SIM_ALLOC. 2:{ econs 2. }
            econs; et. i. rewrite Mem.getN_setN_outside; et.
            unfold size_chunk_nat, size_chunk. des_ifs. destruct ofs; ss.
            nia. }
          i. unfold update.
        destruct (dec b b0); subst. 2:{ rewrite Maps.PMap.gso; et. }
        rewrite Maps.PMap.gss.
        specialize (wfcnt ofs0).
        des_ifs.
        2:{ apply nth_error_None in Heq0. destruct Coqlib.zlt; destruct Coqlib.zle; ss; nia. }
        { erewrite setN_inside; et. { destruct Coqlib.zle in Heq; destruct Coqlib.zlt in Heq; ss; try nia. }
          apply Consent.extends in wfcnt; et. red in wfcnt. des.
          specialize (SIM_CNT ofs0 POSOFS). rewrite wfcnt0 in SIM_CNT. inv SIM_CNT; clarify. }
        rewrite Mem.setN_outside; et.
        destruct Coqlib.zle in Heq; destruct Coqlib.zlt in Heq; ss; try nia. }
      iSplit; ss. iFrame. iSplit; ss. iExists _. iFrame. ss.
    Unshelve. all: et. all: try apply Eqsth; try apply Qp_le_po.
  Qed.

  Lemma sim_capture :
    sim_fnsem wf top2
      ("capture", fun_to_tgt "Mem" (to_stb []) (mk_pure capture_spec))
      ("capture", cfunU captureF).
  Proof.
    Local Transparent equiv_prov.
    econs; ss. red; ss. apply isim_fun_to_tgt; ss.
    i. unfold "@".
    iIntros "[INV PRE]".
    iDestruct "INV" as (tt) "[INV %]".
    iDestruct "INV" as (mem_tgt memcnt_src memalloc_src memsz_src memconc_src) "[[[[% CNT] ALLOC] CONC] SZ]".
    des; clarify. unfold captureF. do 2 (try destruct x as [?|x]).
    { unfold capture_hoare0. des_ifs_safe. ss. clarify.
      iDestruct "PRE" as "%". des. clarify. hred_r.
      iApply isim_pget_tgt. hred_r.
      change Mem.mem' with Mem.mem in *. hred_r.
      destruct Vnullptr eqn:?; clarify.
      rewrite <- Heqv. hred_r.
      iApply isim_apc. iExists None.
      hred_l. iApply isim_choose_src. iExists _.
      iApply isim_ret. iSplit; ss.
      iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
    unfold capture_hoare1. des_ifs_safe. ss. clarify.
    iDestruct "PRE" as "[[% P] %]". des. clarify. hred_r.
    unfold has_offset, _has_offset.
    destruct blk eqn:?; clarify.
    iDestruct "P" as "[ALLOC_PRE [SZ_PRE P]]".
    iApply isim_pget_tgt. hred_r.
    change Mem.mem' with Mem.mem in *. hred_r.
    iCombine "ALLOC ALLOC_PRE" as "ALLOC".
    iOwnWf "ALLOC" as wfalloc.
    iDestruct "ALLOC" as "[ALLOC ALLOC_PRE]".
    iCombine "SZ SZ_PRE" as "SZ".
    iOwnWf "SZ" as wfsz.
    iDestruct "SZ" as "[SZ SZ_PRE]".
    destruct v; clarify; hred_r; ss.
    { iDestruct "P" as (a) "[CONC_PRE %]".
      des. clarify.
      iCombine "CONC CONC_PRE" as "CONC".
      iOwnWf "CONC" as wfconc.
      iDestruct "CONC" as "[CONC CONC_PRE]".
      iApply isim_apc. iExists None.
      hred_l. iApply isim_choose_src. iExists _.
      iApply isim_ret. iSplitL "ALLOC CONC SZ CNT".
      { iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro. et. }
      rewrite _has_size_dup.
      rewrite _has_size_dup.
      iSplit; ss. iFrame. iExists _.
      unfold Vptrofs. des_ifs. rewrite Ptrofs.to_int64_of_int64; et.
      unfold equiv_prov. iDestruct "SZ_PRE" as "[[_ SZ_PRE] [? ?]]".
      rewrite _has_base_dup.
      rewrite _has_base_dup.
      iDestruct "CONC_PRE" as "[[_ CONC_PRE] [A ?]]".
      iSplitL "SZ_PRE CONC_PRE".
      { iSplit; ss. iFrame. iExists _. iFrame. ss. }
      unfold _has_offset. iExists _. rewrite Heqo. iFrame.
      des_ifs. iSplitL "A"; iExists _; iFrame; ss. }
    iDestruct "P" as "%". des. clarify.
    destruct Coqlib.plt; ss; cycle 1.
    { ur in wfalloc. rewrite URA.unit_idl in wfalloc. des.
      ur in wfalloc0. ur in wfsz. specialize (wfsz (Some b)).
      ss. destruct dec; clarify. apply OneShot.oneshot_initialized in wfsz.
      specialize (SIM_ALLOC (Some b)). ss. destruct SIM_ALLOC.
      unfold Coqlib.Plt in *. hexploit H5; try nia. i. rewrite H7 in *.
      des; clarify. }
    hred_r. iApply isim_choose_tgt.
    iIntros (x). destruct x. destruct x. ss. hred_r.
    iApply isim_pput_tgt. hred_r.
    iApply isim_apc. iExists None.
    hred_l. iApply isim_choose_src. iExists _.
    iPoseProof (OwnM_Upd with "CONC") as ">[CONC CONC_POST]".
    { instantiate (1:=_has_base (Some b) (Ptrofs.repr z)).
      instantiate (1:=update memconc_src (Some b) (OneShot.white (Ptrofs.repr z))).
      red. i. ur in H4. ur. i. spc H4.
      specialize (SIM_CONC k). inv c. des_ifs.
      - unfold update. destruct dec; clarify.
        inv SIM_CONC; rewrite RES in H4.
        + hexploit PREVADDR; et. i. des. subst.
          rewrite Ptrofs.repr_unsigned. ur. ur in H4. des_ifs.
        + ur. ur in H4. des_ifs.
      - rewrite URA.unit_id. unfold update. destruct dec; clarify.
      - rewrite URA.unit_id. unfold update. destruct dec; clarify. }
    inv c. dup SIM_ALLOC.
    ur in wfalloc. rewrite URA.unit_idl in wfalloc. des.
    ur in wfalloc0. ur in wfsz. specialize (wfsz (Some b)).
    ss. destruct dec; clarify. apply OneShot.oneshot_initialized in wfsz.
    specialize (SIM_ALLOC (Some b)). ss. destruct SIM_ALLOC.
    apply pw_extends in wfalloc. spc wfalloc. unfold __allocated_with in *.
    destruct dec; clarify. apply Consent.extends in wfalloc; et.
    red in wfalloc. des; rewrite wfalloc1 in *; rewrite wfsz in *; inv H4; clarify.
    hexploit (m0.(Mem.weak_valid_address_range) b z 0); ss.
    { destruct (Maps.PTree.get b mem_tgt.(Mem.mem_concrete)) eqn:?.
      { hexploit PREVADDR; et. i. des. clarify. rewrite <- H7. et. }
      hexploit CAPTURED; et. i.
      rewrite H4. rewrite Maps.PTree.gss. et. }
    { unfold Mem._weak_valid_pointer. left. unfold Mem._valid_pointer.
      hexploit (PERMinrange 0). { destruct m; ss. rewrite Heqo in SZPOS. hexploit SZPOS; et. i. unfold size_chunk in *. des_ifs. destruct tag; solve [hexploit COMMON; et; nia| hexploit DYNAMIC; et; des; nia]. }
      i. des. hexploit m0.(Mem.access_max). rewrite ACCESS in H4. rewrite H4. i. unfold Mem.perm_order'' in *. des_ifs.
      econs. }
    intro ZRANGE.
    iApply isim_ret. iSplitL "ALLOC CONC SZ CNT".
    { clear H6. iExists _. iSplit; ss. iExists _,_,_,_,_. iFrame. iPureIntro.
      split; et. rewrite <- CONTENTS. rewrite <- ACCESS. rewrite <- NEXTBLOCK.
      splits; et. i. hexploit (SIM_CONC ob). i. rename H4 into SIM_CONC0. des_ifs.
      unfold update. destruct dec; clarify.
      - inv SIM_CONC0.
        + hexploit PREVADDR; et. i. des. rewrite <- H4. rewrite <- H6. clarify.
          rewrite Ptrofs.repr_unsigned. rewrite <- H7. econs. et.
        + symmetry in H7. hexploit CAPTURED; et. i.
          rewrite H4. rewrite Maps.PTree.gss.
          rewrite CONTENTS in *. rewrite ACCESS in *. rewrite NEXTBLOCK in *.
          inv ZRANGE. ss. change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in SND.
          replace z with (Ptrofs.unsigned (Ptrofs.repr z)); try econs; rewrite Ptrofs.unsigned_repr; et; try nia.
      - specialize (SIM_CONC (Some b)). ss. inv SIM_CONC.
        + hexploit PREVADDR. { rewrite H7. et. } i. des. rewrite <- H6. et.
        + hexploit CAPTURED; et. i. rewrite H4. rewrite Maps.PTree.gso; et.
          ii. apply n. clarify. }
    rewrite _has_size_dup. rewrite _has_size_dup.
    rewrite _has_base_dup. rewrite _has_base_dup.
    iDestruct "CONC_POST" as "[[_ CONC_POST] [A ?]]".
    iDestruct "SZ_PRE" as "[[_ SZ_PRE] [? ?]]".
    iSplit; ss. iFrame. iExists _. iSplit; ss. unfold equiv_prov.
    iExists i0. unfold _has_offset. rewrite Heqo. iFrame. iSplit; ss.
    des_ifs. iExists _. iFrame. iPureIntro.
    hexploit (m0.(Mem.weak_valid_address_range) b z (sz m)).
    { destruct (Maps.PTree.get b mem_tgt.(Mem.mem_concrete)) eqn:?.
      { hexploit PREVADDR; et. i. des. clarify. rewrite <- H7. et. }
      hexploit CAPTURED; et. i.
      rewrite H4. rewrite Maps.PTree.gss. et. }
    { destruct m. ss. hexploit SZPOS. { rewrite Heqo. et. } i. change Ptrofs.modulus with (Ptrofs.max_unsigned + 1). nia. }
    { unfold Mem._weak_valid_pointer, Mem._valid_pointer.
      right. hexploit (PERMinrange (sz m - 1)).
      { split; try nia. destruct m; ss. hexploit SZPOS. { rewrite Heqo. et. } i.
        unfold size_chunk in *. des_ifs.
        destruct tag; solve [hexploit COMMON; et; nia| hexploit DYNAMIC; et; des; nia]. }
      i. des. hexploit m0.(Mem.access_max). rewrite ACCESS in H4. rewrite H4. i. unfold Mem.perm_order'' in *.
      des_ifs. econs. }
    intro SZRANGE. destruct m; ss. hexploit SZPOS. { rewrite Heqo; et. } i.
    change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *.
    inv ZRANGE. inv SZRANGE. ss.
    splits; try nia.
    { unfold Vptrofs in Heq. des_ifs. rewrite Ptrofs.of_int64_to_int64; et.
      unfold Ptrofs.sub. symmetry. apply Ptrofs.eqm_repr_eq.
      eapply Ptrofs.eqm_trans.
      { apply Ptrofs.eqm_sub;
        apply Ptrofs.eqm_sym; apply Ptrofs.eqm_unsigned_repr. }
      apply Ptrofs.eqm_refl2. nia. }
    all: rewrite Ptrofs.unsigned_repr; try nia.
  Unshelve. all: et.
  Qed.

  Lemma sim_malloc :
    sim_fnsem wf top2
      ("malloc", fun_to_tgt "Mem" (to_stb []) (mk_pure malloc_spec))
      ("malloc", cfunU mallocF).
  Proof.
    Local Opaque encode_val.
    econs; ss. red; ss. apply isim_fun_to_tgt; ss.
    i. iIntros "[INV PRE]".
    iDestruct "PRE" as "%"; des; clarify. rename x into sz. unfold inv_with.
    iDestruct "INV" as (tt) "[INV %]".
    iDestruct "INV" as (mem_tgt memcnt_src memalloc_src memsz_src memconc_src) "[[[[% CNT] ALLOC] CONC] SZ]".
    des; clarify.

    unfold mallocF. hred_r.
    iApply isim_pget_tgt. hred_r. des_ifs. hred_r.
    unfold Mem.store.
    destruct Mem.valid_access_dec; cycle 1.
    { exfalso. apply n.
      unfold Mem.valid_access in *. unfold Mem.range_perm, Mem.perm in *.
      ss. unfold align_chunk, size_chunk; des_ifs.
      split; cycle 1. { exists (- 1). ss. }
      i. rewrite Maps.PMap.gss. destruct i; ss.
      destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia.
      econs. }
    unfold Mem.valid_access in *. unfold Mem.range_perm, Mem.perm in *. ss.
    hred_r.
    iApply isim_pput_tgt. hred_r.
    iApply isim_apc. iExists None.
    hred_l. iApply isim_choose_src. iExists _.

    (* resource formation starts *)
    (* cnt *)
    iOwnWf "CNT" as wfcnt.
    iPoseProof (OwnM_Upd with "CNT") as ">[CNT CNT_POST]".
    { eapply Auth.auth_alloc2.
      instantiate (1:=(__points_to (Mem.nextblock mem_tgt) 0 (repeat (Undef) (Z.to_nat (Int64.unsigned i))) Q1)).
      do 2 ur. i. ur. specialize (SIM_CNT k k0).
      do 3 ur in wfcnt. des. specialize (wfcnt0 k k0).
      ur in wfcnt0. destruct (Coqlib.zle 0 k0); cycle 1.
      { case_points_to; des_ifs. }
      spc SIM_CNT. inv SIM_CNT; cycle 1.
      { des_ifs; unfold __points_to in *; des_ifs. }
      destruct __points_to eqn: ?; unfold __points_to in *; try solve [des_ifs].
      destruct dec; ss; clarify.
      rewrite mem_tgt.(Mem.nextblock_noaccess) in *; unfold Coqlib.Plt; try nia.
      rewrite Qp_le_lteq in Qwf. des; try spc Qwrite; try spc Qread; des; clarify. }

    (* alloc resource *)
    iOwnWf "ALLOC" as wfalloc.
    iPoseProof (OwnM_Upd with "ALLOC") as ">[ALLOC ALLOC_POST]".
    { eapply Auth.auth_alloc2.
      instantiate (1:=(__allocated_with (Mem.nextblock mem_tgt) Dynamic Q1)).
      do 2 ur. i. specialize (SIM_ALLOC (Some k)). ss. des.
      do 2 ur in wfalloc. des. specialize (wfalloc0 k).
      ur in wfalloc0. inv SIM_ALLOC; cycle 1.
      { des_ifs; unfold __allocated_with in *; des_ifs. }
      destruct __allocated_with eqn: ?; unfold __allocated_with in *; try solve [des_ifs]; cycle 1.
      destruct dec; ss; clarify. hexploit SIM_ALLOC0; try nia.
      i. rewrite SRES in *. clarify. }

    (* size *)
    iOwnWf "SZ" as wfsz.
    iPoseProof (OwnM_Upd with "SZ") as ">[SZ SZ_POST]".
    { instantiate (1:= _has_size (Some (mem_tgt.(Mem.nextblock))) (Int64.unsigned i)).
      instantiate (1:= update memsz_src (Some (mem_tgt.(Mem.nextblock))) (OneShot.white (Int64.unsigned i))).
      apply URA.pw_updatable. i. ur. unfold update, _has_size.
      destruct dec; clarify; try solve [des_ifs; ur; des_ifs].
      destruct dec; clarify. specialize (SIM_ALLOC (Some (mem_tgt.(Mem.nextblock)))).
      ss. des. hexploit SIM_ALLOC0; try nia.
      let X := fresh in intro X; rewrite X.
      ur. des_ifs. apply OneShot.oneshot_black_updatable. }

    (* start proving conditions *)
    do 2 unfold has_offset, _has_offset, points_to, _points_to.
    iApply isim_ret. iSplitR "CNT_POST ALLOC_POST SZ_POST"; cycle 1.
    (* post condition *)
    { iSplit; et. apply Z.gt_lt in H5.
      set {| blk := Some (mem_tgt.(Mem.nextblock)); sz := Ptrofs.unsigned sz; SZPOS := fun _ => H5 |} as m.
      iExists m, (Vptr (mem_tgt.(Mem.nextblock)) Ptrofs.zero).
      iSplits; et.
      unfold m, points_to, has_offset, _points_to, _has_offset; ss.
      iPoseProof (_has_size_dup with "SZ_POST") as "[? SZ_POST]".
      iPoseProof (_has_size_dup with "SZ_POST") as "[? ?]".
      unfold Vptrofs in *. des_ifs.
      replace (Int64.unsigned (Ptrofs.to_int64 sz)) with (Ptrofs.unsigned sz).
      2:{ unfold Ptrofs.to_int64. rewrite Int64.unsigned_repr; et. apply Ptrofs.unsigned_range_2. }
      iFrame. destruct sz; ss. change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *.
      iSplits; ss; et; iPureIntro.
      all: try rewrite repeat_length; change (Ptrofs.unsigned Ptrofs.zero) with 0; try nia. }

    (* invariant *)
    iExists _. iSplits; ss. iFrame.
    iPureIntro. splits; ss; ss.
    (* sim_cnt *)
    - i. hexploit (SIM_CNT b); et. intro SIM_CNT0.
      destruct (Pos.eq_dec b (mem_tgt.(Mem.nextblock))); clarify; cycle 1.
      { rewrite ! Maps.PMap.gso; et. do 2 ur. case_points_to; ss; rewrite URA.unit_id; et. }
      rewrite ! Maps.PMap.gss. inv SIM_CNT0.
      { rewrite Mem.nextblock_noaccess in PERM; unfold Coqlib.Plt; try nia; clarify. }
      do 2 ur. rewrite <- H6. rewrite URA.unit_idl.
      case_points_to; ss; cycle 1.
      destruct nth_error eqn: ?; cycle 1.
      { rewrite nth_error_None in Heqo. nia. }
      rewrite repeat_length in *. destruct Coqlib.zlt; ss; try nia.
      rewrite repeat_nth in *. des_ifs.
      2:{ destruct Coqlib.zle; clarify. unfold size_chunk in *. des_ifs. nia. }
      econs; ss.
      { rewrite Mem.setN_outside. { rewrite Maps.ZMap.gi. et. }
        rewrite encode_val_length. unfold size_chunk_nat. nia. }
      { econs. } i. econs.
    (* sim_alloc *)
    - i. des_ifs; cycle 1.
      { specialize (SIM_ALLOC None); ss. }
      destruct (Pos.eq_dec b (mem_tgt.(Mem.nextblock))); clarify; cycle 1.
      { specialize (SIM_ALLOC (Some b)); ss; des. rewrite ! Maps.PMap.gso; et. ur.
        unfold __allocated_with. destruct dec; clarify; rewrite URA.unit_id.
        unfold update. des_ifs. split; et. i. apply SIM_ALLOC0; nia. }
      rewrite ! Maps.PMap.gss. specialize (SIM_ALLOC (Some (mem_tgt.(Mem.nextblock)))); ss; des.
      split; i; try nia. hexploit SIM_ALLOC0; try nia. i. rewrite H4 in *. ur.
      inv SIM_ALLOC; clarify. rewrite URA.unit_idl. unfold __allocated_with.
      des_ifs. econs. 7: et. all: et. all: i; clarify.
      { unfold update. des_ifs. }
      { exists Freeable. i. destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia. split; econs. }
      { destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia. }
    Unshelve. et.
  Qed.

  Lemma sim_mfree :
    sim_fnsem wf top2
      ("free", fun_to_tgt "Mem" (to_stb []) (mk_pure mfree_spec))
      ("free", cfunU mfreeF).
  Proof.
    Local Transparent Mem.load.
    econs; ss. red; ss. apply isim_fun_to_tgt; ss.
    i. iIntros "[INV PRE]". des_ifs. ss.
    iDestruct "PRE" as "[PRE %]"; clarify.
    iDestruct "PRE" as (m mvs vaddr) "[[% P] A]"; des; clarify.
    iPoseProof (point_notnull with "P") as "%".
    do 2 unfold has_offset, _has_offset, points_to, _points_to.
    destruct blk eqn:?; clarify.
    iDestruct "A" as "[ALLOC_PRE [_ A]]".
    iDestruct "P" as "[_ P]".
    iDestruct "P" as (ofs) "[[[CNT_PRE [SZ_PRE A0]] %] LEN]".
    iDestruct "INV" as (tt) "[INV %]".
    iDestruct "INV" as (mem_tgt memcnt_src memalloc_src memsz_src memconc_src) "[[[[% CNT] ALLOC] CONC] SZ]".
    des; clarify.

    unfold mfreeF. hred_r.
    iApply isim_pget_tgt. hred_r.
    destruct Archi.ptr64 eqn:?; ss; clarify.
    iAssert ⌜ofs = Ptrofs.zero⌝%I as "%".
    { des_ifs.
      - iDestruct "A" as (a) "[CONC_PRE %]".
        iDestruct "A0" as (a0) "[CONC0_PRE %]".
        des. clarify.
        iCombine "CONC_PRE CONC0_PRE" as "D".
        rewrite _has_base_unique.
        iDestruct "D" as "%". clarify.
      - iDestruct "A" as "%".
        iDestruct "A0" as "%".
        des. clarify. }
    clarify.
    iAssert ⌜Mem.to_ptr vaddr mem_tgt = Some (Vptr b Ptrofs.zero)⌝%I as "%".
    { unfold Mem.to_ptr. destruct vaddr; clarify; cycle 1.
      { iDestruct "A" as "%". des. clarify. }
      pose proof (Int64.eq_spec i Int64.zero).
      destruct (Int64.eq i Int64.zero); clarify.
      iDestruct "A" as (a) "[A %]".
      iDestruct "A0" as (a0) "[A0 %]".
      hexploit (SIM_CONC (Some b)). i.
      iCombine "A A0" as "CONC_PRE".
      iPoseProof (_has_base_unique with "CONC_PRE") as "%".
      subst. iDestruct "CONC_PRE" as "[_ CONC_PRE]".
      des.
      iCombine "CONC CONC_PRE" as "CONC".
      iOwnWf "CONC" as wfconc.
      ur in wfconc. specialize (wfconc (Some b)). ss. destruct dec; clarify.
      apply OneShot.oneshot_initialized in wfconc.
      des; rewrite wfconc in *; inv H10; clarify.
      unfold Mem.denormalize.
      hexploit (paddr_no_overflow_cond i); et.
      { rewrite <- H9. nia. } i.
      unfold Ptrofs.sub, Ptrofs.of_int64 in *.
      rewrite (Ptrofs.unsigned_repr (Int64.unsigned i)) in *; try apply Int64.unsigned_range_2.
      hexploit (SIM_CNT b 0); try nia. i.
      iCombine "CNT CNT_PRE" as "CNT".
      iOwnWf "CNT" as wfcnt. ur in wfcnt. rewrite URA.unit_idl in wfcnt.
      des. do 2 ur in wfcnt0. apply pw_extends in wfcnt. red in wfcnt. spc wfcnt.
      apply pw_extends in wfcnt. red in wfcnt. specialize (wfcnt 0).
      unfold __points_to in wfcnt. case_points_to; ss; clarify.
      2:{ destruct mvs; ss. destruct m; ss. hexploit SZPOS. rewrite Heqo. et. i. nia. }
      destruct nth_error eqn:?; cycle 1. { apply nth_error_None in Heqo0. nia. }
      apply Consent.extends in wfcnt; et. red in wfcnt. des.
      rewrite wfcnt1 in H15. inv H15. clarify.
      hexploit mem_tgt.(Mem.access_max).
      rewrite PERM. i. unfold Mem.perm_order'' in *.
      assert (0 = Int64.unsigned i - Ptrofs.unsigned base).
      { apply (f_equal Ptrofs.unsigned) in H8.
        change (Ptrofs.unsigned Ptrofs.zero) with 0 in H8.
        rewrite H8. rewrite Ptrofs.unsigned_repr; et.
        destruct i; destruct base; ss; nia. }
      des_ifs; cycle 1.
      { exfalso. apply Maps.PTree.gselectnf in Heq. apply Heq.
        eexists _,_. split; et. unfold Mem.denormalize_aux. rewrite <- H17.
        unfold Mem.addr_is_in_block. rewrite <- H17. rewrite <- H18.
        rewrite Heq0.
        des_ifs. unfold Mem.is_valid in Heq1. bsimpl.
        hexploit mem_tgt.(Mem.nextblock_noaccess); try rewrite PERM; i; clarify.
        des; try nia. unfold Coqlib.Plt. apply Pos.ltb_ge in Heq1. nia. }
      apply Maps.PTree.gselectf in Heq. des.
      unfold Mem.denormalize_aux, Mem.addr_is_in_block in *. des_ifs; bsimpl; clarify.
      des. pose proof (mem_tgt.(Mem.no_concrete_overlap) (Int64.unsigned i)).
      red in H19. hexploit H19.
      { econs; et. nia. }
      { econs. 1: rewrite H17; et. { eexists. rewrite <- H18. rewrite Heq0. et. }
        change Ptrofs.modulus with (Ptrofs.max_unsigned + 1) in *. nia. }
      i. subst. iPureIntro. do 2 f_equal.
      rewrite <- H17 in Heq2. clarify. }
    (* prove load is safe *)
    iCombine "ALLOC ALLOC_PRE" as "ALLOC".
    iCombine "SZ SZ_PRE" as "SZ".
    iOwnWf "ALLOC" as wfalloc.
    iOwnWf "SZ" as wfsz.
    ur in wfalloc. rewrite URA.unit_idl in wfalloc. des. ur in wfalloc0.
    apply pw_extends in wfalloc. ur in wfsz.
    spc wfalloc. specialize (wfsz (Some b)). ss.
    unfold __allocated_with in *. destruct dec; clarify.
    apply Consent.extends in wfalloc; et.
    red in wfalloc. des. apply OneShot.oneshot_initialized in wfsz.
    dup SIM_ALLOC. specialize (SIM_ALLOC (Some b)). ss.
    des; rewrite wfalloc1 in SIM_ALLOC; rewrite wfsz in SIM_ALLOC; inv SIM_ALLOC; clarify.
    hexploit DYNAMIC; et. i. des. subst.
    iAssert ⌜Mem.load Mptr mem_tgt b (- size_chunk Mptr) = Some (Vlong (Int64.repr (sz m)))⌝%I as "%".
    { unfold Mem.load.
      destruct Mem.valid_access_dec; cycle 1.
      { exfalso. apply n. split; cycle 1.
        { unfold align_chunk, size_chunk. des_ifs. exists (- 1). ss. }
        replace (- _ + _) with 0 by nia.
        unfold Mem.range_perm, Mem.perm. i.
        destruct m. ss. hexploit SZPOS. rewrite Heqo. et.
        i. hexploit (PERMinrange ofs); try nia. i. des. rewrite H11.
        rewrite Qfree in H12. { inv H12; econs. }
        eapply antisymmetry; et. }
      iAssert ⌜sz m ≤ Ptrofs.max_unsigned⌝%I as "%".
      { des_ifs; cycle 1. { iDestruct "A" as "%". des. ss. }
        iDestruct "A" as (a) "[_ %]". des. destruct a; ss. iPureIntro. nia. }
      iPureIntro. f_equal. rewrite H8.
      rewrite pure_memval_good_decode; et.
      unfold decode_val. des_ifs.
      rewrite proj_inj_bytes in Heq. clarify.
      do 2 f_equal. rewrite decode_encode_int.
      change (two_p _) with Ptrofs.modulus.
      rewrite Z.mod_small; et. change Ptrofs.modulus with (Ptrofs.max_unsigned + 1).
      nia. }
    (* prove free is safe *)
    assert (Mem.range_perm mem_tgt b (- size_chunk Mptr) (sz m) Cur Freeable).
    { unfold Mem.range_perm, Mem.perm. i.
      hexploit PERMinrange; et. i. des. rewrite H11.
      rewrite Qfree in H12. { inv H12; econs. }
      eapply antisymmetry; et. }

    (* resource formation starts *)
    (* cnt *)
    iCombine "CNT CNT_PRE" as "CNT".
    iOwnWf "CNT" as wfcnt.
    iPoseProof (OwnM_Upd with "CNT") as ">CNT".
    { eapply Auth.auth_dealloc.
      instantiate (1:= update memcnt_src b
                        (fun _ofs =>
                          if Coqlib.zle 0 _ofs && Coqlib.zlt _ofs (sz m)
                          then Consent.unit
                          else memcnt_src b _ofs)).
      ii. des. rewrite URA.unit_idl. split.
      { do 2 ur in H11. do 2 ur. i. unfold update. destruct dec; et. des_ifs. ur. et. }
      rewrite H12 in *. red. extensionalities. do 2 ur. unfold update. destruct dec; clarify; cycle 1.
      { case_points_to; ss; try rewrite URA.unit_idl; et.
        edestruct nth_error_None. rewrite H16; try nia. }
      case_points_to; ss; try rewrite URA.unit_idl; et.
      2:{ destruct Coqlib.zlt; ss; try nia. rewrite URA.unit_idl. et. }
      do 2 ur in H11. do 2 spc H11. ur in H11.
      destruct ctx; et; try solve [des_ifs]. exfalso.
      unfold __points_to in H11; case_points_to; ss; try nia; des_ifs.
      { apply Qp_not_add_le_l in H11; clarify. }
      { rewrite nth_error_None in Heq. nia. }
      change (Ptrofs.unsigned Ptrofs.zero) with 0 in *. nia. }

    (* alloc resource *)
    iPoseProof (OwnM_Upd with "ALLOC") as ">ALLOC".
    { eapply Auth.auth_dealloc.
      instantiate (1:= update memalloc_src b Consent.unit).
      ii. des. rewrite URA.unit_idl. ur in H11. split.
      { ur. i. unfold update. destruct dec; et. ur. et. }
      rewrite H12 in *. red. extensionalities. do 2 ur. unfold update. destruct dec; clarify; cycle 1.
      { unfold __allocated_with. destruct dec; clarify. des_ifs. }
      spc H11. unfold __allocated_with in H11. ur in H11. destruct dec; clarify. ur in H11. des_ifs.
      apply Qp_not_add_le_l in H11. clarify. }

    destruct vaddr; clarify.
    - unfold Int64.eq. destruct Coqlib.zeq.
      { exfalso. apply H3. unfold Vnullptr. des_ifs. f_equal.
        apply Int64.same_if_eq. unfold Int64.eq. des_ifs. }
      hred_r. unfold Mem.to_ptr in H7.
      rewrite H7. change (Ptrofs.unsigned Ptrofs.zero) with 0.
      rewrite Z.sub_0_l. rewrite H9. hred_r.
      destruct m; ss. hexploit SZPOS. rewrite Heqo. et. i.
      iDestruct "A" as (a) "[A %]".
      iDestruct "A0" as (a0) "[A0 %]".
      des. clarify.
      rewrite Int64.unsigned_repr.
      2:{ change Int64.max_unsigned with Ptrofs.max_unsigned. destruct a; ss. nia. }
      destruct Coqlib.zlt; try nia.
      unfold Mem.free. rewrite Z.add_0_l.
      destruct Mem.range_perm_dec; clarify.
      hred_r.
      iApply isim_pput_tgt. hred_r.
      iApply isim_apc. iExists None.
      hred_l. iApply isim_choose_src. iExists _.
      (* start proving conditions *)
      iApply isim_ret. iSplit; et.
      (* invariant *)
      iExists _. iSplits; ss.
      iDestruct "SZ" as "[SZ _]". iClear "A0 A". iFrame.
      iPureIntro. splits; ss; ss.
      (* sim_cnt *)
      + i. hexploit (SIM_CNT b0); et. intro SIM_CNT0.
        unfold update. destruct dec; clarify; cycle 1.
        { rewrite ! Maps.PMap.gso; et. }
        rewrite ! Maps.PMap.gss.
        do 2 destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia.
      (* sim_alloc *)
      + i. des_ifs; cycle 1.
        { specialize (SIM_ALLOC0 None); ss. }
        unfold update. destruct dec; clarify; cycle 1.
        specialize (SIM_ALLOC0 (Some b0)); ss; des. rewrite ! Maps.PMap.gso; et.
    - hred_r. iDestruct "A" as "%". des. clarify.
      change (Ptrofs.unsigned Ptrofs.zero) with 0.
      rewrite Z.sub_0_l. rewrite H9. hred_r.
      destruct m; ss. hexploit SZPOS. rewrite Heqo. et. i.
      rewrite Int64.unsigned_repr.
      2:{ change Int64.max_unsigned with Ptrofs.max_unsigned. nia. }
      destruct Coqlib.zlt; try nia.
      unfold Mem.free. do 2 rewrite Z.add_0_l.
      destruct Mem.range_perm_dec; clarify. hred_r.
      iApply isim_pput_tgt. hred_r.
      iApply isim_apc. iExists None.
      hred_l. iApply isim_choose_src. iExists _.
      (* start proving conditions *)
      iApply isim_ret. iSplit; et.
      (* invariant *)
      iExists _. iSplits; ss.
      iDestruct "SZ" as "[SZ _]". iFrame.
      iPureIntro. splits; ss; ss.
      (* sim_cnt *)
      + i. hexploit (SIM_CNT b0); et. intro SIM_CNT0.
        unfold update. destruct dec; clarify; cycle 1.
        { rewrite ! Maps.PMap.gso; et. }
        rewrite ! Maps.PMap.gss.
        do 2 destruct Coqlib.zle; destruct Coqlib.zlt; ss; try nia.
      (* sim_alloc *)
      + i. des_ifs; cycle 1.
        { specialize (SIM_ALLOC0 None); ss. }
        unfold update. destruct dec; clarify; cycle 1.
        specialize (SIM_ALLOC0 (Some b0)); ss; des. rewrite ! Maps.PMap.gso; et.
    Unshelve. all: et. all: try apply Eqsth; try apply Qp_le_po.
  Qed.

  Theorem correct_mod sk: ModPair.sim (ClightPlusMem1.Mem sk) (ClightPlusMem0.Mem sk).
  Proof.
  Local Opaque Pos.add.
    econs; ss. i.
    econstructor 1 with (wf:=wf) (le:=top2); ss; cycle 1.
    { exists tt. unfold res_init. des_ifs.
      - econs. apply to_semantic. apply init_wf; et.
      - rewrite <- init_fail_iff in Heq0. clarify.
      - rewrite init_fail_iff in Heq. clarify.
      - econs; ss. eapply to_semantic.
        iIntros "A". iSplits; ss. iPureIntro.
        econs; ss.
        + i. rewrite Maps.PMap.gi. econs 2; ss.
        + i. des_ifs. rewrite Maps.PTree.gempty. econs. et.
        + i. destruct ob; et. split. { econs 2. }
          i. destruct Coqlib.plt; et. unfold Coqlib.Plt in *. nia. }
    repeat (match goal with |- Forall2 _ _ _ => econs end).
    - apply sim_salloc.
    - apply sim_sfree.
    - apply sim_load.
    - apply sim_store.
    - apply sim_sub_ptr.
    - apply sim_cmp_ptr.
    - apply sim_non_null.
    - apply sim_malloc.
    - apply sim_mfree.
    - apply sim_memcpy.
    - apply sim_capture.
  Qed.

End SIMMODSEM.
