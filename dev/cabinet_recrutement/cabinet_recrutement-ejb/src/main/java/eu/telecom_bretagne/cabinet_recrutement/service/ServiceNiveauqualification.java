package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Date;

// import javax.ejb.EJB;
// import javax.ejb.LocalBean;
// import javax.ejb.Stateless;
// import javax.jws.WebService;
import jakarta.ejb.EJB;
import jakarta.ejb.LocalBean;
import jakarta.ejb.Stateless;
import jakarta.jws.WebService;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.NiveauqualificationDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Offreemploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Niveauqualification;

/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceNiveauqualification implements IServiceNiveauqualification
{
  //-----------------------------------------------------------------------------
  @EJB private NiveauqualificationDAO         niveauqualificationDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceNiveauqualification()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public Niveauqualification getNiveauqualification(int id)
  {
    return niveauqualificationDAO.findById(id);
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<Niveauqualification> listeDesNiveauqualifications()
  {
    return niveauqualificationDAO.findAll();
  }
  //-----------------------------------------------------------------------------
}
