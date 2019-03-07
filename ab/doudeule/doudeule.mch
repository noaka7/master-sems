/* doudeule
 * Author: 
 * Creation date: 3/7/19
 */
MACHINE
    doudeule
SETS
    UTILISATEUR; DATE
CONSTANTS
    inconnu
PROPERTIES
    inconnu : UTILISATEUR
VARIABLES
    organisateur,
    participants,
    dates,
    choix_participant
INVARIANT    // prédicat: propriété invariante
    organisateur : UTILISATEUR
    & participants <: UTILISATEUR                   // équivalent à participants : POW(UTILISATEUR)
    & dates : POW(DATE)
    //& choix_participant : UTILISATEUR <-> DATE      // relation UTILISATEUR-DATE
    & choix_participant : DATE +-> POW(UTILISATEUR) // fonction
    & inconnu /: participants
    & organisateur : participants \/ {inconnu}
    & dom(choix_participant) <: participants        // dom: domaine d'une relation
    & ran(choix_participant) <: dates               // ran: co-domaine d'une relation
INITIALISATION
    organisateur := inconnu
    || participants := {}
    || dates := {}
    || choix_participant := {}
OPERATIONS
    creer_reunion(p_organisateur, p_dates, p_participants) =
        PRE
            organisateur = inconnu
            & p_organisateur : UTILISATEUR
            & p_organisateur /= inconnu
            & p_dates : POW(DATE)
            & p_dates /= {}
            & p_participants : POW(UTILISATEUR)
            & p_participants /= {}
        THEN
            organisateur := p_organisateur
            || dates := p_dates
            || participants := p_participants
        END;

    choix_date(p_dates) =
        PRE
            organisateur /= inconnu
            & p_dates : DATE
            & p_dates /: {}
        THEN
            dates := {p_dates}
        END;

    indiquer_disponibilites(p_participant, p_dates) =
        PRE
            organisateur /= inconnu
            & p_participant : UTILISATEUR
            & p_participant : participants
            & p_dates : DATE
            & p_dates : dates
        THEN
            //choix_participant := choix_participant \/ {p_participant |-> p_dates}    // |-> : relation d'association
            choix_participant := choix_participant <<| {p_dates |-> choix_participant(p_dates) \/ {p_participant}}    // surcharge
        END;
END
