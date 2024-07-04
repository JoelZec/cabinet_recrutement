<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteuractivite,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Secteuractivite,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Offreemploi,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreemploi,
                java.util.List,
                java.util.Set
                "%>

<%
Object utilisateur = session.getAttribute("utilisateur");
Candidature candidat = (Candidature) utilisateur;
int idcandidat= candidat.getId();

IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
List<Candidature> candidatures = serviceCandidature.listeDesCandidatures();
IServiceSecteuractivite serviceSecteuractivite = (IServiceSecteuractivite) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteuractivite"); 
IServiceOffreemploi serviceOffreemploi = (IServiceOffreemploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreemploi");
List<Offreemploi> offresemploi = serviceOffreemploi.listeDesOffreemplois();

 
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Liste des candidatures potentielles </h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
          <table class="table table-striped table-bordered table-hover" id="dataTables-example">
            <!--
              Nom des colonnes
            -->
            <thead>
              <tr>
                <th>Identifiant</th>
                <th>Nom</th>
                <th>Prenom</th>
                <th>CV</th>
                <th>Niveau de qualification</th>
                <th>Date de naissance</th>
                <th>Adresse postale</th>
                <th>Adresse mail</th>
                <th>Date de depot</th>
                <th>Secteur Activites</th>
                <th>Offre Potentielle</th>
                <th>Informations</th>

              </tr>
            </thead>
            <!--
              Contenu du tableau
            -->
            <tbody>
              <%
              for(Candidature candidature : candidatures)
              {
                if(idcandidat == candidature.getId()){
                %>
                <tr>
                 <td>CAND_<%=candidature.getId()%></td>
                 <td><%=candidature.getNom()%></td>
                 <td><%=candidature.getPrenom()%></td>
                 <td><%=candidature.getCv()%></td>
                 <td><%=candidature.getNiveauqualification().getIntitule()%></td>
                 <td><%=candidature.getDatenaissance()%></td>
                 <td><%=candidature.getAdressepostale()%></td>
                 <td><%=candidature.getAdresseemail()%></td>
                 <td><%=candidature.getDatedepot()%></td>
                 <td>
                  <%
                    Set<Secteuractivite> liste_secteurs = candidature.getSecteuractivites();
                    for (Secteuractivite secteur : liste_secteurs) {
                        Secteuractivite secteur_selected = serviceSecteuractivite.getSecteuractivite(secteur.getId());
                      %>
                        <ul><%=secteur_selected.getIntitule()%></ul>
                      <%}%>
                </td>
                <td align="center">

                  <%
                  int find = 0;
                  for(Offreemploi offre : offresemploi){
                    if(!offre.getSecteuractivites().isEmpty() && offre.getNiveauqualification().getIntitule().equals(candidature.getNiveauqualification().getIntitule()) && offre.getSecteuractivites().equals(candidature.getSecteuractivites())){
                    find +=1;
                %> 
                <ul><a href="template.jsp?action=infos_offreemploi&id=<%=offre.getId()%>"><%=offre.getTitle()%></a></ul>
 
                <% } else {
                 
                
                
               }
              }
               if(find==0){%>
                 Aucune
 
                 <% }
               
               %>
               </td>

                  <td align="center"><a href="template.jsp?action=infos_candidatures&id=<%=candidature.getId()%>"><i class="fa fa-eye fa-lg"></i></a></td>
                </tr>
                <%
                }
              }
            
              %>
            </tbody>
          </table>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->