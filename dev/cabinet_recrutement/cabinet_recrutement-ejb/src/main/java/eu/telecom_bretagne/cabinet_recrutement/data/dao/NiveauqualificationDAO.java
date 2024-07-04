package eu.telecom_bretagne.cabinet_recrutement.data.dao;
// Generated Feb 7, 2023, 5:41:20 PM by Hibernate Tools 5.4.20.Final

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Niveauqualification;

/**
 * Home object for domain model class Niveauqualification.
 * 
 * @see eu.telecom_bretagne.cabinet_recrutement.data.model.Niveauqualification
 * @author Hibernate Tools
 */
@Stateless
public class NiveauqualificationDAO {

    private static final Logger logger = Logger.getLogger(NiveauqualificationDAO.class.getName());

    @PersistenceContext
    private EntityManager entityManager;

    public Niveauqualification persist(Niveauqualification transientInstance) {
        logger.log(Level.INFO, "persisting Niveauqualification instance");
        try {
            entityManager.persist(transientInstance);
            logger.log(Level.INFO, "persist successful");
        } catch (RuntimeException re) {
            logger.log(Level.SEVERE, "persist failed", re);
            throw re;
        }
        return transientInstance;
    }

    /*public void remove(Niveauqualification persistentInstance) {
        logger.log(Level.INFO, "removing Niveauqualification instance");
        try {
            entityManager.remove(persistentInstance);
            logger.log(Level.INFO, "remove successful");
        } catch (RuntimeException re) {
            logger.log(Level.SEVERE, "remove failed", re);
            throw re;
        }
    }*/

    public void remove(Niveauqualification nq){
        if(!entityManager.contains(nq)) 
         {                                        
          nq = entityManager.merge(nq); 
         }
             entityManager.remove(nq);  
      }

    public Niveauqualification merge(Niveauqualification detachedInstance) {
        logger.log(Level.INFO, "merging Niveauqualification instance");
        try {
            Niveauqualification result = entityManager.merge(detachedInstance);
            logger.log(Level.INFO, "merge successful");
            return result;
        } catch (RuntimeException re) {
            logger.log(Level.SEVERE, "merge failed", re);
            throw re;
        }
    }

    public Niveauqualification findById(int id) {
        logger.log(Level.INFO, "getting Niveauqualification instance with id: " + id);
        try {
            Niveauqualification instance = entityManager.find(Niveauqualification.class, id);
            logger.log(Level.INFO, "get successful");
            return instance;
        } catch (RuntimeException re) {
            logger.log(Level.SEVERE, "get failed", re);
            throw re;
        }
    }

    public List<Niveauqualification> findAll() {
        Query query = entityManager.createQuery("select niveauQualif from Niveauqualification niveauQualif " +
                "order by niveauQualif.id");
        List<Niveauqualification> l = query.getResultList();
        return l;
    }
}
