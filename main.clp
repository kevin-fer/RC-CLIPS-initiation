;----------------------------------------------------------------------------
;----Mini projet Représéntation des connaissances----------------------------
;----Auteur: kevin-fer-------------------------------------------------------
;----------------------------------------------------------------------------

;----Clips c'est quoi ?-------------------------------------------------------
;---- C'est un générateur de systèmes experts
;---- Un système expert est composé de : 
;---- - d'une base de connaissances
;---- ->>>> base de faits (code de la connaissance sur l'étude sur l'étude en cours) et evolution de son état en cours de l'expertise
;---- ->>>> base de règles (code de la connaissance sur le domaine)
;---- - Moteur d'inférences
;---- CLIPS pour C Language Integrated Production System (CLIPS) -------------
;---- C'est un langage de programmation et un générateur de systèmes experts--
;---- Créé par la NASA en 1985 au au Johnson Space Center, à Houston, Texas --
;---- Paradigmes : procédural, objet et règles----- --------------------------
;---- Flexible, extensible, portable, interactif via CLI, et vérification de contraintes
;----------------------------------------------------------------------------

;---- Pourquoi ? --------------------------------------------------------------
;---- A l'époque on utilisait LISP, et incompatible avec les contraintes de la NASA
;---- Intégration compliquée avec d'autres langages, perfommance et rapidité réduite
;---- donc utilisation du langage C pour des raisons de portabilité et de rapidité
;---- Section IA de la NASA qui a développé le langage CLIPS ------------------
;---- Controle de processus, diagnostic de panne et planification des missions spatiales
;---- Disponible en Java maintenant avec un IDE et langage reste proche de LISP
;---- Non monotone (faits rétractables), chainage avant --------------------------------
;------------------------------------------------------------------------------

;---- Quelques sources pour apprendre à utiliser CLIPS -----------------------
;---- http://www.clipsrules.net/ -------------------------------------------
;---- https://home.mis.u-picardie.fr/~furst/docs/CLIPS.pdf, cours de Frédéric Fürst, Labo MIS, Université de Picardie
;---- https://pageperso.lis-lab.fr/bernard.espinasse/Supports/IA-SEX/Exp-CLIPS-1-4P.pdf, cours de Bernard Espinasse, Université d'Aix-Marseille
;---- https://sites.google.com/site/iadescartes/4-notre-experience/4-2-presentation-de-clips
;---- https://www.csee.umbc.edu/portal/clips/usersguide/clipsusr.html
;---- https://kcir.pwr.edu.pl/~witold/ai/CLIPS_tutorial/CLIPS_tutorial_4.html

;------------------------------------------------------------------------------

;---- 1. Les faits -----------------------------------------------------------
;---- Des mots, une structure de données, ou un objet
;---- Dans le CLI :
;---- Ajouter des faits : (assert (dev-name "kevin-fer") (inscrit-option "Representation des connaissances"))
;---- Liste des faits : (facts)
;---- Retirer des faits : (retract (fait 1), ..., (fait n) ou * pour tous) // On peut indiquer l'indice au lieu de l'étiquette
;---- Effacer la base de faits : (clear)
;---- Modifier des faits par indice : (modify 0 (dev-name "cristiano-ronaldo"))
;------------------------------------------------------------------------------

;---- 2. Définition de la base de faits------------------------------------------
;----deffacts permet de définir des faits initialement connus par le systeme-
(deffacts base-de-faits-initial-processus-commercial-societe-plomberie 
    "Base de fait initial pour notre SE processus commercial en societe de plomberie"
    
    (client-paye)
    (plombier-fait-intervention)
    (intervention-terminee)
    (client-contacte-entreprise)
    (client-valide-devis)
)

;----Définition de la base de règles------------------------------------------
(defrule cloture-dossier
    "R1 : Si Intervention terminee ET Facture payee ALORS Cloture du dossier"
    (intervention-terminne)
    (facture-payee)
    =>
    (assert(cloture-du-dossier))
    (printout t "R1 satisfaite, cloture du dossier" crlf)
)

(defrule effectuer-paiement
    "R2 : Si intervention termine ET Facture remise ALORS Effectuer paiement"
    (intervention-termine)
    (facture-remise)
    =>
    (assert(effectuer-paiement))
    (printout t "R2 satisfaite, effectuer paiement" crlf)

)

(defrule plombier-commande-materiel
    "R3 : Si Payer acompte ALORS Plombier commande les matériels"
    (payer-acompte)
    =>
    (assert(plombier-commande-materiels))
    (printout t "R3 satisfaite, plombier commande materiels" crlf)
)

(defrule associer-plombier
    "R4 : Si client valide devis ET Secretariat fixe RDV alors Associer plombier"
    (client-valide-devis)
    (secretariat-fixe-rdv)
    =>
    (assert(associer-plombier))
    (printout t "R4 satisfaite, associer plombier" crlf)
)
(defrule devis-fourni
    "R5 : Si client contacte entreprise ALORS Devis fourni"
    (client-contacte-entreprise)
    =>
    (assert(devis-fourni))
    (printout t "R5 satisfaite, devis fourni" crlf)
)

(defrule payer-acompte-et-rdv-apres-acompte
    "R6 : Si client valide devis ALORS Secretariat fixe RDV ET Payer acompte"
    (client-valide-devis)
    =>
    (assert(secretariat-fixe-rdv))
    (assert(payer-acompte))
    (printout t "R6 satisfaite, secretariat fixe rdv et payer acompte" crlf)
)
(defrule demander-rib-client
    "R7 : Si Devis > 1000 ALORS Demander rib client"
    (devis > 1000)
    =>
    (assert(demander-rib-client))
    (printout t "R7 satisfaite, demander rib client" crlf) 
)

(defrule facture-remise
    "R8 : Si Plombier fait intervention ALORS Facture remise"
    (plombier-fait-intervention)
    =>
    (assert(facture-remise))
    (printout t "R8 satisfaite, facture remise" crlf)
)

(defrule facture-payee
    "R9 : Si Client paye ALORS Facture payee"
    (client-paye)
    =>
    (assert(facture-payee))
    (printout t "R9 satisfaite, facture payee" crlf)
)