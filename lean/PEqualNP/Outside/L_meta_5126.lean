import Mathlib
import PEqualNP.Defs
import PEqualNP.Defs.SplitCount
import PEqualNP.Defs.EdgeOwnership
import PEqualNP.Defs.TopForm

open PEqualNP.CircuitLowerBounds
open PEqualNP.MetaComplexity
open PEqualNP.TopForm
open PEqualNP.SplitCount
open PEqualNP.EdgeOwnership

-- Rung two, one-hot-off dirt: if no least AND/OR fan-in-two 4-cycle-free bipartite edge circuit has one dirty AND,
-- none with one-hot-off dirt has two

theorem PEqualNP.Outside.L_meta_5126 :
    (∀ (n : ℕ) (G : SimpleGraph (Fin n)) [DecidableRel G.Adj] (C : Circuit) (s : Fin n → Bool),
      (∀ u v : Fin n, G.Adj u v → s u ≠ s v) →
      NoFourCycle G →
      IsLeastAO G C →
      (junk G C).card ≠ 1) →
    ∀ (n' : ℕ) (G' : SimpleGraph (Fin n')) [DecidableRel G'.Adj] (TheCircuit : Circuit) (s' : Fin n' → Bool),
      (∀ u v : Fin n', G'.Adj u v → s' u ≠ s' v) →
      NoFourCycle G' →
      IsLeastAO G' TheCircuit →
      (∀ k ∈ junk G' TheCircuit, ∀ v : Fin n', gateVal n' TheCircuit k (unitInput v) = false) →
      (junk G' TheCircuit).card ≠ 2 := by
  intro h_rung1
  -- Use a different approach to avoid variable binding issues
  have h_main : ∀ (n' : ℕ) (G' : SimpleGraph (Fin n')) [DecidableRel G'.Adj] (TheCircuit : Circuit) (s' : Fin n' → Bool),
      (∀ u v : Fin n', G'.Adj u v → s' u ≠ s' v) →
      NoFourCycle G' →
      IsLeastAO G' TheCircuit →
      (∀ k ∈ junk G' TheCircuit, ∀ v : Fin n', gateVal n' TheCircuit k (unitInput v) = false) →
      (junk G' TheCircuit).card ≠ 2 := by
    intro n' G' _ TheCircuit s' h_bip h_no4cycle h_leastAO h_oneHotOff
    intro h_card2
    -- Step 1: The circuit is in the IsAO2 model (fan-in exactly two AND/OR gates)
    have h_ao2 : IsAO2 n' TheCircuit := by sorry
    -- Step 2: The circuit computes the edge function of G'
    have h_computes : circuitFun n' TheCircuit = graphFun G' ∅ := by sorry
    -- Step 3: Extract the two junk AND gates (dirty AND gates not below F)
    have h_junk_card : (PEqualNP.TopForm.junk G' TheCircuit).card = 2 := by sorry
    -- Step 4: Get the two junk gates as a pair
    have h_junk_two : ∃ (k1 k2 : ℕ), k1 ≠ k2 ∧ PEqualNP.TopForm.junk G' TheCircuit = {k1, k2} := by sorry
    obtain ⟨k1, k2, hk12, hjunk⟩ := h_junk_two
    -- Step 5: Both junk gates are AND gates not below F (IsDirtyAnd)
    have h_k1_junk : k1 ∈ PEqualNP.TopForm.junk G' TheCircuit := by sorry
    have h_k2_junk : k2 ∈ PEqualNP.TopForm.junk G' TheCircuit := by sorry
    have h_k1_is_and : (gateAt TheCircuit k1).op = GateOp.and := by sorry
    have h_k2_is_and : (gateAt TheCircuit k2).op = GateOp.and := by sorry
    have h_k1_not_below : ¬BelowF G' TheCircuit k1 := by sorry
    have h_k2_not_below : ¬BelowF G' TheCircuit k2 := by sorry
    -- Step 6: Both junk gates are off at one-hot inputs (one-hot-off dirt condition)
    have h_k1_onehot : ∀ v : Fin n', PEqualNP.EdgeOwnership.gateVal n' TheCircuit k1 (PEqualNP.SplitCount.unitInput v) = false := by sorry
    have h_k2_onehot : ∀ v : Fin n', PEqualNP.EdgeOwnership.gateVal n' TheCircuit k2 (PEqualNP.SplitCount.unitInput v) = false := by sorry
    -- Step 7: Structural lemma - each junk AND gate has both inputs as OR gates (or variables)
    -- with disjoint sets of unit inputs where they are true
    have h_k1_structure : (gateAt TheCircuit k1).inputs.length = 2 := by sorry
    have h_k2_structure : (gateAt TheCircuit k2).inputs.length = 2 := by sorry
    -- Step 8: The two junk gates' input wires have specific structure
    -- Each junk gate g has inputs w1, w2 such that the sets {v | wireVal w1 (unitInput v) = true} and {v | wireVal w2 (unitInput v) = true} are disjoint
    -- Step 9: Case analysis on the interaction between the two junk gates
    -- This reduces to a finite number of cases (10 cases as mentioned in the sketch)
    -- Step 10: In each case, derive a contradiction either by:
    --   a) Constructing a smaller circuit (violating IsLeastAO)
    --   b) Showing the graph has a 4-cycle (violating NoFourCycle)
    --   c) Using the first rung hypothesis (h_rung1) to show junk.card ≠ 1 leads to contradiction
    have h_final_contradiction : False := by sorry
    exfalso
    exact h_final_contradiction
  -- Apply the main lemma to the current goal
  intro n' G' _ TheCircuit s' h_bip h_no4cycle h_leastAO h_oneHotOff h_card2
  have h₂ := h_main n' G' (by infer_instance) TheCircuit s' h_bip h_no4cycle h_leastAO h_oneHotOff h_card2
  exact h₂