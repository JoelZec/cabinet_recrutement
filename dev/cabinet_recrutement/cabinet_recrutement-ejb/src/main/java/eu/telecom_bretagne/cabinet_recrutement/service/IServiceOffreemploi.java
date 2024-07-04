package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;
import java.util.Set;
import java.util.Date;

// import javax.ejb.Remote;
import jakarta.ejb.Remote;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Niveauqualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Offreemploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Secteuractivite;

/**
 * Interface du service gérant les entreprises.
 * @author Samuel LE SAOUT
 */
@Remote
public interface IServiceOffreemploi
{
  //-----------------------------------------------------------------------------
  /**
   * Obtention d'une <{@link Offreemploi}.
   * 
   * @param id id de l'offre d'emploi à récupérer.
   * @return
   */
  public Offreemploi getOffreemploi(int id);
  /**
   * Obtention de la liste de toutes les offres d'emploi.
   * 
   * @return la liste des offres d'emploi dans une {@code List<Offreemploi>}.
   */
  public List<Offreemploi> listeDesOffreemplois();

  public List<Offreemploi> listeOffreEntreprise(Entreprise entreprise);

  public Offreemploi nouvelleOffreemploi(String titre, String descriptifMission, String profilrecherche, Date datedepot, Entreprise entreprise, Niveauqualification niveauqualification,Set<Secteuractivite> secteuractivites);
 
  //-----------------------------------------------------------------------------
}
