<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreemploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Offreemploi,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceNiveauqualification,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteuractivite,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Niveauqualification,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Secteuractivite,
                java.util.Set,
                java.util.HashSet,
                java.util.Date,
                java.text.DateFormat,
                java.util.List,
                eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO,
                java.text.SimpleDateFormat"%>

<%
  IServiceNiveauqualification serviceNiveauqualification = (IServiceNiveauqualification) ServicesLocator.getInstance().getRemoteInterface("ServiceNiveauqualification");
  List<Niveauqualification> niveauqualifications = serviceNiveauqualification.listeDesNiveauqualifications();

  IServiceSecteuractivite serviceSecteuractivite = (IServiceSecteuractivite) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteuractivite");
  List<Secteuractivite> listSecteur = serviceSecteuractivite.listeDesSecteuractivites(); 

  IServiceOffreemploi serviceOffreemploi = (IServiceOffreemploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreemploi");

  Object utilisateur = session.getAttribute("utilisateur");
  Entreprise entreprise = (Entreprise) utilisateur;
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Référencer une nouvelle offre d'emploi</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <%
          String titre = request.getParameter("titre");
          if(titre == null) // Pas de param�tre "titre" => affichage du formulaire
          { 
            %>
            <div class="col-lg-offset-2 col-lg-8
                        col-xs-12">
              <form role="form" action="template.jsp" method="get">
                <input type="hidden" name="action" value="nouvelle_offreemploi" />
                <div class="form-group">
                  <input class="form-control" placeholder="Titre de l'offre d'emploi" name="titre" />
                </div>
                <div class="form-group">
                  <textarea class="form-control" placeholder="Descriptif de l'offre d'emploi" rows="5" name="descriptifMission"></textarea>
                </div>
                <div class="form-group">
                  <input class="form-control" placeholder="Profil recherche" name="profilrecherche" /></textarea>
                </div>
                <div class="form-group">
                  <select name="niveauqualification">
                      <option>Niveau de Qualification</option>
                      <%  for(Niveauqualification niveauqualification : niveauqualifications)
                      {
                          %>
                          <option value=<%=niveauqualification.getId()%>> <%=niveauqualification.getIntitule()%></option>
                      <%
                      }
                      %>
                  </select>
                    <div class="form-group">
                      <label>Secteur(s) d'activité</label>
                      <small>
                      <table border="0" width="100%">   
                          <%
                          for (Secteuractivite secteurActivite : listSecteur) {%>
                              <tr>
                                  <td>
                                    <input type="checkbox" name="secteur" value=<%=secteurActivite.getId()%> /> <%=secteurActivite.getIntitule()%>
                                  </td>
                              </tr>
                          <%}%> 
                          <td>&nbsp;</td>
                          </tr>
                        </table>                
                      </small>
                  </div>
                <div class="text-center">
                  <button type="submit" class="btn btn-success btn-circle btn-lg" name="submit-insertion"><i class="fa fa-check"></i></button>
                  <button type="reset"  class="btn btn-warning btn-circle btn-lg"><i class="fa fa-times"></i></button>
                </div>
              </form>
            </div>
            <%
          }
          else // Param�tre "titre" existant => stockage des données et affichage du résultat
          {
            if(titre.equals(""))
            {
              %>
              <div class="row col-xs-offset-1 col-xs-10">
                <div class="panel panel-red">
                  <div class="panel-heading ">
                    Impossible de traiter la demande
                  </div>
                  <div class="panel-body text-center">
                    <p class="text-danger"><strong>Il n'est pas possible de référencer une offre d'emploi qui ne poss�de pas de titre.</strong></p>
                  </div>
                </div>
              </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
              <%
            }
            else
            {
              // Récupération des autres paramètres
              
            try {
              String descriptifMission = request.getParameter("descriptifMission");
              String profilrecherche = request.getParameter("profilrecherche");
              SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
              Date today = new Date();
              Date todaydate = sdf.parse(sdf.format(today));
      
              int idniveauqualification = Integer.parseInt(request.getParameter("niveauqualification"));
              Niveauqualification niveauqualification = serviceNiveauqualification.getNiveauqualification(idniveauqualification);
              String[] secteur = request.getParameterValues("secteur");
              Set<Secteuractivite> liste_secteurs = new HashSet<Secteuractivite>();   

              for (int i=0; i<secteur.length; i++){
                liste_secteurs.add(serviceSecteuractivite.getSecteuractivite(Integer.parseInt(secteur[i])));
              }

              
              Offreemploi offreemploi = serviceOffreemploi.nouvelleOffreemploi(titre, descriptifMission, profilrecherche, todaydate, entreprise, niveauqualification, liste_secteurs);

              %>
              <div class="col-lg-offset-2 col-lg-8
                          col-xs-12">
                <div class="panel panel-success">
                  <div class="panel-heading">
                    Nouvelle offre d'emploi référencée
                  </div>
                  <div class="panel-body">
                    <small> 
                      <table class="table">
                        <tbody>
                          <tr class="success">
                            <td><strong>Identifiant (login)</strong></td>
                            <td>OFF_<%=offreemploi.getId()%></td>
                          </tr>
                          <tr class="warning">
                            <td><strong>Titre</strong></td>
                            <td><%=offreemploi.getTitle()%></td>
                          </tr>
                          <tr class="warning">
                            <td><strong>Descriptif</strong></td>
                            <td><%=offreemploi.getDescriptifmission()%></td>
                          </tr>
                          <tr class="warning">
                            <td><strong>Secteur(s) d'activite</strong></td>
                            <%
                            Set<Secteuractivite> liste_secteurs = offreemploi.getSecteuractivites();%>
                            <td>
                              <%
                            for (Secteuractivite sect : liste_secteurs) {
                                Secteuractivite secteur_selected = serviceSecteuractivite.getSecteuractivite(sect.getId());
                              %>
                            <li><%=secteur_selected.getIntitule()%></li>
                            <%}%>
                          </td>
                          <tr class="warning">
                            <td><strong>Profil recherche</strong></td>
                            <td><%=offreemploi.getProfilrecherche()%></td>
                          </tr>
                          <tr class="warning">
                            <td><strong>Date de depot</strong></td>
                            <td><%=offreemploi.getDatedepot()%></td>
                          </tr>
                          <tr class="warning">
                            <td><strong>Entreprise</strong></td>
                            <td><%=offreemploi.getEntreprise().getNom()%></td>
                          </tr>
                          <tr class="warning">
                            <td><strong>Niveau de Qualification</strong></td>
                            <td><%=offreemploi.getNiveauqualification().getIntitule()%></td>
                          </tr>
                        </tbody>
                      </table>
                    </small>
                  </div>
                </div>
              </div>
            <%   
            }
            catch(Exception e){
              out.println("<h1 style=\"color: red;text-align:center\"> ERREUR ! </h1>");
            }  

            }
          }
        %>
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
