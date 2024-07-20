;;;  -*- lexical-binding: t; -*-

(defconst +tree-1+
  '(A (B1) (B2) (B3 (C1) (C2)) (B4)))

(defconst +parse-error-1+
  '(judgement-judgement_Ty
     (Ty-PatCheck
      (G)
      (te-Term_App (h-Application_Con (K)) (aps))
      (sg-PolyTypesKinds_Subst
       (btheta-Subst_Mapping
        (mapping-Mapping_Single (substCandid-SubstCandidateInternalTyVar (alpha)) (t)))
       (sg-PolyTypesKinds_PsyList (psystrick-PsisTrickP0 (psys-PsysList ([])) (T) (sgs))))
      (D))))
