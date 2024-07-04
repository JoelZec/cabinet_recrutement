package eu.telecom_bretagne.cabinet_recrutement.front.controlesDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.NiveauqualificationDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreemploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.SecteuractiviteDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Niveauqualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Offreemploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Secteuractivite;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocatorException;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/ControlesDAO")
public class ControlesDAOServlet extends HttpServlet
{
  //-----------------------------------------------------------------------------
  private static final long serialVersionUID = 1L;
  //-----------------------------------------------------------------------------
  /**
   * @see HttpServlet#HttpServlet()
   */
  public ControlesDAOServlet()
  {
    super();
  }
  //-----------------------------------------------------------------------------
  /**
   * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
   */
  protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    // Flot de sortie pour écriture des résultats.
    PrintWriter out = response.getWriter();
    
    // Récupération de la réféence vers le(s) DAO(s)
    EntrepriseDAO entrepriseDAO = null;
    NiveauqualificationDAO niveauqualificationDAO = null;
    SecteuractiviteDAO secteuractiviteDAO = null;
    CandidatureDAO candidatureDAO = null;
    OffreemploiDAO offreemploiDAO = null;

    try
    {
      entrepriseDAO = (EntrepriseDAO) ServicesLocator.getInstance().getRemoteInterface("EntrepriseDAO");
      niveauqualificationDAO = (NiveauqualificationDAO) ServicesLocator.getInstance().getRemoteInterface("NiveauqualificationDAO");
      secteuractiviteDAO = (SecteuractiviteDAO) ServicesLocator.getInstance().getRemoteInterface("SecteuractiviteDAO");
      candidatureDAO = (CandidatureDAO) ServicesLocator.getInstance().getRemoteInterface("CandidatureDAO");
      offreemploiDAO = (OffreemploiDAO) ServicesLocator.getInstance().getRemoteInterface("OffreemploiDAO");
    }
    catch (ServicesLocatorException e)
    {
      e.printStackTrace();
    }
    
    out.println("<b>Contrôles de fonctionnement des classes DAO</b><br><br>");
    out.println();
    
    try {
      /*---------------------ENTREPRISES--------------------*/
      Entreprise e1 = new Entreprise();
      e1.setAdressePostale("1 rue E1");
      e1.setDescriptif("Télécommunications");
      e1.setNom("Orange");
      e1 = entrepriseDAO.persist(e1);
      e1.setId(e1.getId());

      Entreprise e2 = new Entreprise();
      e2.setAdressePostale("1 rue E2");
      e2.setDescriptif("Réseaux");
      e2.setNom("NXO");
      e2 = entrepriseDAO.persist(e2);
      e2.setId(e2.getId());

      Entreprise e3 = new Entreprise();
      e3.setAdressePostale("1 rue E3");
      e3.setDescriptif("TestDescriptif");
      e3.setNom("Test");
      e3 = entrepriseDAO.persist(e3);
      e3.setId(e3.getId());

      out.println("<b>Liste des entreprises :</b><br>");
      List<Entreprise> entreprises = entrepriseDAO.findAll();
      for(Entreprise entreprise : entreprises)
      {
        out.println("<li>"+entreprise.getNom()+"</li>");
      }
      out.println();

      e3.setNom("TestMerge");
      entrepriseDAO.update(e3);
      out.println("<br><b>Liste des entreprises modifiées (Test vers TestMerge):</b>");
      List<Entreprise> entreprisesMerge = entrepriseDAO.findAll();
      for(Entreprise entreprise : entreprisesMerge)
      {
        out.println("<li>"+entreprise.getNom()+"</li>");
      }
      out.println();

      entrepriseDAO.remove(e3);
      out.println("<br><b>Liste des entreprises supprimées (TestMerge supprimé):</b>");
      List<Entreprise> entreprisesRemove = entrepriseDAO.findAll();
      for(Entreprise entreprise : entreprisesRemove){
        out.println("<li>"+entreprise.getNom()+"</li>");}
      out.println();

      /*---------------------NIVEAUX DE QUALIFICATIONS--------------------*/
      Niveauqualification Licence = new Niveauqualification();
      Licence.setIntitule("Licence");
      Licence = niveauqualificationDAO.persist(Licence);
      //Licence.setId(Licence.getId());

      Niveauqualification Master = new Niveauqualification();
      Master.setIntitule("Master");
      Master = niveauqualificationDAO.persist(Master);
      //Master.setId(Master.getId());

      Niveauqualification Doctorat = new Niveauqualification();
      Doctorat.setIntitule("Doctorat");
      Doctorat = niveauqualificationDAO.persist(Doctorat);
      //Doctorat.setId(Doctorat.getId());

      Niveauqualification Test = new Niveauqualification();
      Test.setIntitule("Test");
      Test = niveauqualificationDAO.persist(Test);

      out.println("<br><b>Liste des niveaux de qualification initiaux :</b>");
      List<Niveauqualification> nqs = niveauqualificationDAO.findAll();
      for(Niveauqualification nq1 : nqs){
        out.println("<li>"+nq1.getIntitule()+"</li>");}
      out.println();

      Test.setIntitule("TestMerge");
      niveauqualificationDAO.merge(Test);

      out.println("<br><b>Liste des niveaux de qualification modifiés (Test vers TestMerge):</b>");
      List<Niveauqualification> nqMerge = niveauqualificationDAO.findAll();
      for(Niveauqualification nq1 : nqMerge){
        out.println("<li>"+nq1.getIntitule()+"</li>");}
      out.println();

      niveauqualificationDAO.remove(Test);
      out.println("<br><b>Liste des niveaux de qualification supprimés (TestMerge supprimé):</b>");
      List<Niveauqualification> nqRemove = niveauqualificationDAO.findAll();
      for(Niveauqualification nq1 : nqRemove){
        out.println("<li>"+nq1.getIntitule()+"</li>");}
      out.println();


      /*---------------------SECTEURS ACTIVITÉ--------------------*/
      Secteuractivite Recherche = new Secteuractivite();
      Recherche.setIntitule("Recherche");
      System.out.println("Persistence du secteur d'activité 1");
      Recherche = secteuractiviteDAO.persist(Recherche);

      Secteuractivite Developpement = new Secteuractivite();
      Developpement.setIntitule("Développement");
      System.out.println("Persistence du secteur d'activité 2");
      Developpement = secteuractiviteDAO.persist(Developpement);
      
      Secteuractivite TestSA = new Secteuractivite();
      TestSA.setIntitule("Test");
      TestSA = secteuractiviteDAO.persist(TestSA);

      out.println("<br><b>Liste des secteurs d'activité initiaux :</b>");
      List<Secteuractivite> sas = secteuractiviteDAO.findAll();
      for(Secteuractivite sa : sas){
        out.println("<li>"+sa.getIntitule()+"</li>");}
      out.println();

      TestSA.setIntitule("TestMerge");
      secteuractiviteDAO.merge(TestSA);

      out.println("<br><b>Liste des secteurs d'activité modifiés (Test vers TestMerge):</b>");
      List<Secteuractivite> saMerge = secteuractiviteDAO.findAll();
      for(Secteuractivite sa : saMerge){
        out.println("<li>"+sa.getIntitule()+"</li>");}
      out.println();

      secteuractiviteDAO.remove(TestSA);
      out.println("<br><b>Liste des secteurs d'activité supprimés (Test supprimé):</b>");
      List<Secteuractivite> saRemove = secteuractiviteDAO.findAll();
      for(Secteuractivite sa : saRemove){
        out.println("<li>"+sa.getIntitule()+"</li>");}
      out.println();

      /*---------------------DATE--------------------*/
      DateFormat df1 = new SimpleDateFormat("dd-MM-yyyy"); 
      Date date1=df1.parse("25-12-2023");


      /*---------------------CANDIDATURES--------------------*/
      Candidature c1 = new Candidature();
      c1.setNom("Abitbol");
      c1.setPrenom("Georges");
      c1.setAdresseemail("g.a@classe.com");
      c1.setNiveauqualification(Licence);
      c1.setAdressepostale("2 rue XXX");
      c1.setCv("CV1");
      c1.setDatedepot(date1);
      c1.setDatenaissance(date1);
      c1.getSecteuractivites().add(secteuractiviteDAO.findById(Developpement.getId()));
      c1.getSecteuractivites().add(secteuractiviteDAO.findById(Recherche.getId()));
      System.out.println("Persistence du secteur d'activité 1");
      c1 = candidatureDAO.persist(c1);
      
      Candidature c2 = new Candidature();
      c2.setNom("Wayne");
      c2.setPrenom("Bruce");
      c2.setAdresseemail("bruce@wayne.corp");
      c2.setNiveauqualification(Licence);
      c2.setAdressepostale("2 rue XXX");
      c2.setCv("CV2");
      DateFormat df2 = new SimpleDateFormat("dd-MM-yyyy"); 
      Date date2=df2.parse("25-12-2022");
      c2.setDatedepot(date2);
      c2.setDatenaissance(date2);
      c2.getSecteuractivites().add(secteuractiviteDAO.findById(Recherche.getId()));
      System.out.println("Persistence de la candidature 2");
      c2 = candidatureDAO.persist(c2);

      /*-----------------INFO CANDIDATURE----------------------- */
      out.println("<br><b>Obtention des informations de Georges Abitbol :</b>");
      Candidature c = candidatureDAO.findById(1);
      out.println("<li>"+c.getId()+"</li>");
      out.println("<li>"+c.getNom()+"</li>");
      out.println("<li>"+c.getPrenom()+"</li>");
      out.println("<li>"+c.getAdresseemail()+"</li>");
      out.println("<li>"+c.getAdressepostale()+"</li>");
      out.println("<li>"+c.getDatedepot()+"</li>");
      out.println("<li>"+c.getDatenaissance()+"</li>");
      out.println("<li>"+c.getCv()+"</li>");
      out.println("<li>"+niveauqualificationDAO.findById(c.getNiveauqualification().getId()).getIntitule()+"</li>");
      Set<Secteuractivite> lesS = candidatureDAO.findById(1).getSecteuractivites();
      for(Secteuractivite s : lesS)
      {
        out.println("<li>"+secteuractiviteDAO.findById(s.getId()).getIntitule()+"</li>");
      }
      out.println();

      /*-----------------SUPPRESSION SECTEUR ACTIVITÉ ASSOCIÉ À UNE CANDIDATURE----------------------- */
      out.println("<br><b>Obtention des informations de Georges Abitbol après la suppression du secteur d'activité 'Recherche':</b>");
      Candidature c6 = candidatureDAO.findById(1);
      c6.getSecteuractivites().remove(secteuractiviteDAO.findById(Recherche.getId()));
      candidatureDAO.merge(c6);
      out.println("<li>"+c.getNom()+"</li>");
      out.println("<li>"+c.getPrenom()+"</li>");
      Set<Secteuractivite> S6 = candidatureDAO.findById(c6.getId()).getSecteuractivites();
      for(Secteuractivite s : S6)
      {
        out.println("<li>"+secteuractiviteDAO.findById(s.getId()).getIntitule()+"</li>");
      }
      out.println();

      /*-----------------LISTE SETEUR ACTIVITÉ / CANDIDATURE----------------------- */
      out.println("<br><b>Liste des secteurs d'activité avec les candidatures associées:</b><br>");
      List<Secteuractivite> sac = secteuractiviteDAO.findAll();
      for(Secteuractivite sa : sac){
        out.println(sa.getIntitule()+"<br>");
        Set<Candidature> lesC = sa.getCandidatures();
        for(Candidature cand : lesC){
          out.print("<li>"+(candidatureDAO.findById(cand.getId())).getNom()+"</li>");
        }
      }



      /*---------------------OFFRE D'EMPLOI--------------------*/
      Offreemploi o1 = new Offreemploi();
      o1.setDatedepot(date1);
      o1.setDescriptifmission("Mission1");
      o1.setEntreprise(e1);
      o1.getSecteuractivites().add(secteuractiviteDAO.findById(Recherche.getId()));
      o1.setNiveauqualification(Licence);
      o1.setTitle("TitreOE1");
      o1.setProfilrecherche("ProfilRecherché1");
      o1 = offreemploiDAO.persist(o1);


      Offreemploi o2 = new Offreemploi();
      o2.setDatedepot(date1);
      o2.setDescriptifmission("MissionTest");
      o2.setEntreprise(e1);
      o2.getSecteuractivites().add(secteuractiviteDAO.findById(Recherche.getId()));
      o2.setNiveauqualification(Licence);
      o2.setTitle("TitreTest");
      o2.setProfilrecherche("ProfilRecherchéTest");
      o2 = offreemploiDAO.persist(o2);


      out.println("<br><b>Liste des offres d'emploi initiales :</b>");
      List<Offreemploi> oes = offreemploiDAO.findAll();
      for(Offreemploi oe : oes){
        out.println("<li>"+oe.getTitle()+"</li>");}
      out.println();

      o2.setTitle("TitreTestMerge");
      offreemploiDAO.merge(o2);

      out.println("<br><b>Liste des offres d'emploi modifiées (TitreTest vers TitreTestMerge) :</b>");
      List<Offreemploi> oeMerge = offreemploiDAO.findAll();
      for(Offreemploi oe : oeMerge){
        out.println("<li>"+oe.getTitle()+"</li>");}
      out.println();

      offreemploiDAO.remove(o2);

      out.println("<br><b>Liste des offres d'emploi supprimées (TitreTest supprimée) :</b>");
      List<Offreemploi> oeRemove = offreemploiDAO.findAll();
      for(Offreemploi oe : oeRemove){
        out.println("<li>"+oe.getTitle()+"</li>");}
      out.println();
    }
    catch (Exception e) {
        e.printStackTrace();
    }
       
  }
  
}

//----------------------------------------------------------------------