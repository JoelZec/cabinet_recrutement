package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.List;

// import javax.ejb.EJB;
// import javax.ejb.LocalBean;
// import javax.ejb.Stateless;
// import javax.jws.WebService;
import jakarta.ejb.EJB;
import jakarta.ejb.LocalBean;
import jakarta.ejb.Stateless;
import jakarta.jws.WebService;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.SecteuractiviteDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Secteuractivite;

/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceSecteuractivite implements IServiceSecteuractivite
{
  //-----------------------------------------------------------------------------
  @EJB private SecteuractiviteDAO         secteuractiviteDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceSecteuractivite()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public Secteuractivite getSecteuractivite(int id)
  {
    return secteuractiviteDAO.findById(id);
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<Secteuractivite> listeDesSecteuractivites()
  {
    return secteuractiviteDAO.findAll();
  }
  //-----------------------------------------------------------------------------
}
