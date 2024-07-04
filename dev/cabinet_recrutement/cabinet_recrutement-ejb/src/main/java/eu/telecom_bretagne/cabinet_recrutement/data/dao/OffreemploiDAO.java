package eu.telecom_bretagne.cabinet_recrutement.data.dao;
// Generated Feb 7, 2023, 5:41:20 PM by Hibernate Tools 5.4.20.Final

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Offreemploi;

/**
 * Home object for domain model class Offreemploi.
 * 
 * @see eu.telecom_bretagne.cabinet_recrutement.data.model.Offreemploi
 * @author Hibernate Tools
 */
@Stateless
public class OffreemploiDAO {

    private static final Logger logger = Logger.getLogger(OffreemploiDAO.class.getName());

    @PersistenceContext
    private EntityManager entityManager;

    public Offreemploi persist(Offreemploi transientInstance) {
        logger.log(Level.INFO, "persisting Offreemploi instance");
        try {
            entityManager.persist(transientInstance);
            logger.log(Level.INFO, "persist successful");
        } catch (RuntimeException re) {
            logger.log(Level.SEVERE, "persist failed", re);
            throw re;
        }
        return transientInstance;
    }

    /*public void remove(Offreemploi persistentInstance) {
        logger.log(Level.INFO, "removing Offreemploi instance");
        try {
            entityManager.remove(persistentInstance);
            logger.log(Level.INFO, "remove successful");
        } catch (RuntimeException re) {
            logger.log(Level.SEVERE, "remove failed", re);
            throw re;
        }
    }*/
    public void remove(Offreemploi offreemploi){
        if(!entityManager.contains(offreemploi)) 
         {                                        
            offreemploi = entityManager.merge(offreemploi); 
         }
             entityManager.remove(offreemploi);  
      }


    public Offreemploi merge(Offreemploi detachedInstance) {
        logger.log(Level.INFO, "merging Offreemploi instance");
        try {
            Offreemploi result = entityManager.merge(detachedInstance);
            logger.log(Level.INFO, "merge successful");
            return result;
        } catch (RuntimeException re) {
            logger.log(Level.SEVERE, "merge failed", re);
            throw re;
        }
    }

    public Offreemploi findById(int id) {
        logger.log(Level.INFO, "getting Offreemploi instance with id: " + id);
        try {
            Offreemploi instance = entityManager.find(Offreemploi.class, id);
            logger.log(Level.INFO, "get successful");
            return instance;
        } catch (RuntimeException re) {
            logger.log(Level.SEVERE, "get failed", re);
            throw re;
        }
    }

    public List<Offreemploi> findByEntreprise(Entreprise entreprise) {
        Query query = entityManager.createQuery("select offreemploi from Offreemploi offreemploi " +
                "where offreemploi.entreprise.id = :idE " +
                "order by offreemploi.id desc");
        query.setParameter("idE", entreprise.getId());
        List<Offreemploi> l = query.getResultList();
        return l;
    }

    public List<Offreemploi> findBySecteurActiviteAndNiveauQualification(int idSecteurActivite,
            int idNiveauQualification) {
        Query query = entityManager.createQuery("select oe from Offreemploi oe join oe.secteursactivite sects " +
                "where sects.id = :idSA and oe.niveauqualification.id = :idNQ " +
                "order by oe.id desc");
        query.setParameter("idSA", idSecteurActivite);
        query.setParameter("idNQ", idNiveauQualification);
        List<Offreemploi> l = query.getResultList();
        return l;
    }

    public List<Offreemploi> findAll() {
        Query query = entityManager.createQuery("select offreemploi from Offreemploi offreemploi " +
                "order by offreemploi.id desc");
        List<Offreemploi> l = query.getResultList();
        return l;
    }

}
