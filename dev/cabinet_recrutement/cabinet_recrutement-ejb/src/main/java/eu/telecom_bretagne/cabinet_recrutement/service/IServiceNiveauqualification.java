package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

// import javax.ejb.Remote;
import jakarta.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Niveauqualification;

/**
 * Interface du service gérant les entreprises.
 * @author Samuel LE SAOUT
 */
@Remote
public interface IServiceNiveauqualification
{
  //-----------------------------------------------------------------------------
  /**
   * Obtention d'une <{@link Niveauqualification}.
   * 
   * @param id id de l'entreprise à récupérer.
   * @return
   */
  public Niveauqualification getNiveauqualification(int id);
  /**
   * Obtention de la liste de toutes les entreprises.
   * 
   * @return la liste des entreprises dans une {@code List<Entreprise>}.
   */
  public List<Niveauqualification> listeDesNiveauqualifications();

  //-----------------------------------------------------------------------------
}
