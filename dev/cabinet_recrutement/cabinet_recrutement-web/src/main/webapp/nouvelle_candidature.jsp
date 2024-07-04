<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>



<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Niveauqualification,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Secteuractivite,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceNiveauqualification,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteuractivite,
                java.util.HashSet,
                java.util.Set,
                java.util.List,
                java.text.SimpleDateFormat,
                java.util.Date,
                java.text.DateFormat"%>
                
<%IServiceSecteuractivite serviceSecteuractivite = (IServiceSecteuractivite) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteuractivite"); 
IServiceNiveauqualification serviceNiveauqualification = (IServiceNiveauqualification) ServicesLocator.getInstance().getRemoteInterface("ServiceNiveauqualification");
IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Referencer une nouvelle candidature</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <%
          String nom = request.getParameter("nom");
          if(nom == null) // Pas de parametre "nom" => affichage du formulaire
          {
            

            %>
            <div class="col-lg-offset-2 col-lg-8
                        col-xs-12">
              <form role="form" action="template.jsp" method="get">
                <input type="hidden" name="action" value="nouvelle_candidature" />
                <div class="form-group">
                  <input class="form-control" placeholder="Nom" name="nom" />
                </div>
                <div class="form-group">
                    <input class="form-control" placeholder="Prenom" name="prenom" />
                </div>
                <div class="form-group">
                    <input class="form-control" placeholder="Adresse postale (ville)" name="adresse_postale" />
                </div>
                <div class="form-group">
                    <input class="form-control" placeholder="Adresse email" name="adresse_email" />
                </div>
                <div class="form-group">
                  <textarea class="form-control" placeholder="Curriculum Vitae" rows="5" name="cv"></textarea>
                </div>
                <div class="form-group">
                  <input type ="text" onfocus = "(this.type='date')" class="form-control" placeholder="Date de naissance" name="dateNaissance" />
              </div>
                <div class="col-lg-3">
                    <div class="form-group">
                      <label>Niveau de Qualification</label>
                        <select name="niveau">
                            <option>Sélectionnez</option>
                            <%  
                            List<Niveauqualification> listLvl = serviceNiveauqualification.listeDesNiveauqualifications();
                            for(Niveauqualification niveauQualif : listLvl)
                            {
                                %>
                                <option value=<%=niveauQualif.getId()%>> <%=niveauQualif.getIntitule()%></option>
                            <%
                            }
                            %>
                        </select>
                    </div>
                  </div>
                  <div class="col-lg-9">
                  <div class="form-group">
                    <label>Secteur(s) d'activité</label>
                    <small>
                    <table border="0" width="100%">   
                        <%
                        List<Secteuractivite> listSecteur = serviceSecteuractivite.listeDesSecteuractivites();
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
            </div>
                <div class="text-center">
                  <button type="submit" class="btn btn-success btn-circle btn-lg" name="submit-insertion"><i class="fa fa-check"></i></button>
                  <button type="reset"  class="btn btn-warning btn-circle btn-lg"><i class="fa fa-times"></i></button>
                </div>
              </form>
            </div>
            <%
          }
          

          else // Param�tre "nom" existant => stockage des donnees et affichage du resultat
          {
            if(nom.equals(""))
            {
              %>
              <div class="row col-xs-offset-1 col-xs-10">
                <div class="panel panel-red">
                  <div class="panel-heading ">
                    Impossible de traiter la demande
                  </div>
                  <div class="panel-body text-center">
                    <p class="text-danger"><strong>Il n'est pas possible de referencer une candidature qui ne possède pas de nom.</strong></p>
                  </div>
                </div>
              </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
              <%
            }
            else
            {
            // R�cup�ration des autres param�tres
            String[] secteur = request.getParameterValues("secteur");
            Set<Secteuractivite> liste_secteurs = new HashSet<Secteuractivite>();   
            for (int i=0; i<secteur.length; i++){
                
              liste_secteurs.add(serviceSecteuractivite.getSecteuractivite(Integer.parseInt(secteur[i])));
            }
              
            int niveau = Integer.parseInt(request.getParameter("niveau"));
            Niveauqualification niveauQualif = serviceNiveauqualification.getNiveauqualification(niveau);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date today = new Date();
            Date todaydate = sdf.parse(sdf.format(today));
            Candidature candidature = serviceCandidature.nouvelleCandidature(niveauQualif, request.getParameter("nom"), request.getParameter("prenom"), sdf.parse(request.getParameter("dateNaissance")), request.getParameter("adresse_postale"), request.getParameter("adresse_email"), request.getParameter("cv"),  todaydate, liste_secteurs);
            %>
              <div class="col-lg-offset-2 col-lg-8
                          col-xs-12">
                <div class="panel panel-success">
                  <div class="panel-heading">
                    Nouvelle candidature référencée
                  </div>
                  <div class="panel-body">
                    <small>
                      <table class="table">
                        <tbody>
                          <tr class="success">
                            <td><strong>Identifiant Candidature</strong></td>
                            <td>CAND_<%=candidature.getId()%></td>
                          </tr>
                          <tr class="warning">
                            <td><strong>Nom</strong></td>
                            <td><%=candidature.getNom()%></td>
                          </tr>
                          <tr class="warning">
                            <td><strong>Prénom</strong></td>
                            <td><%=candidature.getPrenom()%></td>
                          </tr>
                          <tr class="warning">
                            <td><strong>Date de depot</strong></td>
                            <td><%=candidature.getDatedepot()%></td>
                          </tr>
                          <tr class="warning">
                            <td><strong>Secteur(s) d'activite</strong></td>
                            <%
                            liste_secteurs = candidature.getSecteuractivites();%>
                            <td>
                              <%
                            for (Secteuractivite sect : liste_secteurs) {
                                Secteuractivite secteur_selected = serviceSecteuractivite.getSecteuractivite(sect.getId());
                              %>
                            <li><%=secteur_selected.getIntitule()%></li>
                            <%}%>
                            </td>
                          </tr>
                          </tr>
                        </tbody>
                      </table>
                    </small>
                  </div>
                </div>
              </div>
              <%
            }
          }
        %>
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
