package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.Date;

// import javax.ejb.EJB;
// import javax.ejb.LocalBean;
// import javax.ejb.Stateless;
// import javax.jws.WebService;
import jakarta.ejb.EJB;
import jakarta.ejb.LocalBean;
import jakarta.ejb.Stateless;
import jakarta.jws.WebService;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreemploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Offreemploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Secteuractivite;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Niveauqualification;


/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceOffreemploi implements IServiceOffreemploi
{
  //-----------------------------------------------------------------------------
  @EJB private OffreemploiDAO         offreemploiDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceOffreemploi()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public Offreemploi getOffreemploi(int id)
  {
    return offreemploiDAO.findById(id);
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<Offreemploi> listeDesOffreemplois()
  {
    return offreemploiDAO.findAll();
  }
  //-----------------------------------------------------------------------------
  @Override
  public Offreemploi nouvelleOffreemploi(String titre, String descriptifMission, String profilrecherche, Date datedepot, Entreprise entreprise, Niveauqualification niveauqualification,Set<Secteuractivite> secteuractivites)
  {
    Offreemploi offre = new Offreemploi();
    offre.setTitle(titre);
    offre.setDescriptifmission(descriptifMission);
    offre.setProfilrecherche(profilrecherche);
    offre.setDatedepot(datedepot);
    offre.setEntreprise(entreprise);
    offre.setNiveauqualification(niveauqualification);
    offre.setSecteuractivites(secteuractivites);
    offre = offreemploiDAO.persist(offre);
    return offre;
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<Offreemploi> listeOffreEntreprise(Entreprise entreprise) {
    return offreemploiDAO.findByEntreprise(entreprise);
  }


}
