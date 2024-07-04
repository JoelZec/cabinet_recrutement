package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

// import javax.ejb.Remote;
import jakarta.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Secteuractivite;

/**
 * Interface du service gérant les entreprises.
 * @author Samuel LE SAOUT
 */
@Remote
public interface IServiceSecteuractivite
{
  //-----------------------------------------------------------------------------
  /**
   * Obtention d'une <{@link Secteuractivite}.
   * 
   * @param id id de l'entreprise à récupérer.
   * @return
   */
  public Secteuractivite getSecteuractivite(int id);
  /**
   * Obtention de la liste de toutes les entreprises.
   * 
   * @return la liste des entreprises dans une {@code List<Secteuractivite>}.
   */
  public List<Secteuractivite> listeDesSecteuractivites();

  //-----------------------------------------------------------------------------
}
