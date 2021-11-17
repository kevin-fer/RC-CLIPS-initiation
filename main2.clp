
;---- 3. D�finition d'une structure sans programmation orient�e objet------------
(deftemplate client
    "represente un client, �quivalent des structures en C"
    (slot id) 
    (slot nom)
    (slot prenom)
    (slot adresse)
    (slot pays)
    (slot telephone)
    (slot rib)
)

(deftemplate entreprise
    "represente un entreprise, �quivalent des structures en C"
    (slot id) 
    (slot filiere)
)

(deftemplate intervention
    "represente une intervention, �quivalent des structures en C"

    (slot statut
        (type STRING)
        (default "pas commence")
    )
)


(deffacts base-de-faits-initial-processus-commercial-societe-plomberie-2
    "Base de fait initial pour notre SE processus commercial en societe de plomberie"
    
    (entreprise (filiere France))

    (client
        (id client1)
        (nom Simpson)
        (prenom Homer)
        (adresse rue-des-Simpsons)
        (pays USA)
        (telephone 555-555-5555)
        (rib 123456789012345678901234567)
    )

    (intervention (statut "pas commence"))

    (devis-ok)

    (sarra-rigole)
)

;----D�finition de la base de r�gles------------------------------------------
(defrule filiere-USA
    "R1 : Si Client vit aux USA ALORS Filiere USA"
    (client (pays USA))
    ?fentreprise <- (entreprise (filiere France))
    =>
    (assert(entreprise (filiere USA)))
    (retract ?fentreprise)
    (printout t "R1 satisfaite, fili�re USA" crlf)
)

(defrule devis-ok
    "R1 : Si devis valid� ALORS statut intervention pret"
    (devis-ok)
    (intervention (statut "pas commence"))
    ?f <- (intervention (statut "pas commence"))
    ?f2 <- (devis-ok)
    =>
    (modify ?f (statut "pret"))
    (retract ?f2)
    (printout t "R2 satisfaite, statut pret" crlf)
)

(defrule sarra-rigole
    "R1 : Si Sarra rigole ALORS Imane rigole"
    (sarra-rigole)
    =>
    (assert(imane-rigole))
    (printout t "R3 satisfaite" crlf)
)



