package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

// import javax.ejb.EJB;
// import javax.ejb.LocalBean;
// import javax.ejb.Stateless;
// import javax.jws.WebService;
import jakarta.ejb.EJB;
import jakarta.ejb.LocalBean;
import jakarta.ejb.Stateless;
import jakarta.jws.WebService;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Niveauqualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Secteuractivite;

/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceCandidature implements IServiceCandidature
{
  //-----------------------------------------------------------------------------
  @EJB private CandidatureDAO         candidatureDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceCandidature()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public Candidature getCandidature(int id)
  {
    return candidatureDAO.findById(id);
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<Candidature> listeDesCandidatures()
  {
    return candidatureDAO.findAll();
  }
  //-----------------------------------------------------------------------------
  
  @Override
  public Candidature nouvelleCandidature(Niveauqualification niveauqualification, String nom, String prenom, Date datenaissance, String adressepostale, String adresseemail, String cv, Date datedepot,Set<Secteuractivite> secteuractivites)
  {
    Candidature cand = new Candidature();
    cand.setNiveauqualification(niveauqualification);
    cand.setNom(nom);
    cand.setPrenom(prenom);
    cand.setDatenaissance(datenaissance);
    cand.setAdressepostale(adressepostale);
    cand.setAdresseemail(adresseemail);
    cand.setCv(cv);
    cand.setDatedepot(datedepot);
    cand.setSecteuractivites(secteuractivites);
    cand = candidatureDAO.persist(cand);
    return cand;
  }
  //-----------------------------------------------------------------------------
  
}
