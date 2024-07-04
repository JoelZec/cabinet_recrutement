<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.*,
                eu.telecom_bretagne.cabinet_recrutement.data.model.*,
                java.util.List"%>

<%
  Object utilisateur = session.getAttribute("utilisateur");
  Entreprise entreprise = (Entreprise) utilisateur;
  IServiceOffreemploi serviceOffreemploi = (IServiceOffreemploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreemploi");
  List<Offreemploi> offresemploi = serviceOffreemploi.listeOffreEntreprise(entreprise);
  IServiceSecteuractivite serviceSecteuractivite = (IServiceSecteuractivite) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteuractivite"); 
  IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  List<Candidature> candidatures = serviceCandidature.listeDesCandidatures();
    %>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Liste des offres d'emploi referencees </h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
          <table class="table table-striped table-bordered table-hover" id="dataTables-example">
            <!--
              Nom des colonnes
            -->
            <thead>
              <tr>
                <th>Identifiant</th>
                <th>Titre</th>
                <th>Descriptif de la mission</th>
                <th>Profil recherche</th>
                <th>Date de depot</th>
                <th>Niveau de qualification</th>
                <th>Candidatures potentielles</th>
                <th>Informations</th>
              </tr>
            </thead>
            <!--
              Contenu du tableau
            -->
            <tbody>
              <%
              for(Offreemploi offre : offresemploi)
              {
                %>
                <tr>
                 <td>OFF_<%=offre.getId()%></td>
                 <td><%=offre.getTitle()%></td>
                 <td><%=offre.getDescriptifmission()%></td>
                 <td><%=offre.getProfilrecherche()%></td>
                 <td><%=offre.getDatedepot()%></td>
                 <td><%=offre.getNiveauqualification().getIntitule()%></td>
                 <td align="center">
                  <%
                 int find = 0;
                 for(Candidature candidature : candidatures){
                 if(!offre.getSecteuractivites().isEmpty() && offre.getNiveauqualification().getIntitule().equals(candidature.getNiveauqualification().getIntitule()) && offre.getSecteuractivites().equals(candidature.getSecteuractivites())){
                    find +=1;
                  %> 
                    <ul><a href="template.jsp?action=infos_candidatures&id=<%=candidature.getId()%>"><%=candidature.getPrenom()%> <%=candidature.getNom()%></a></ul>
                  <% } 
                  else {
                  }
                  
                 }
                 if(find==0){%>
                   Aucune 
                  
                  <% }
   
                 %>
                </td>
                <td align="center"><a href="template.jsp?action=infos_offreemploi&id=<%=offre.getId()%>"><i class="fa fa-eye fa-lg"></i></a></td>
                </tr>
                <%
              }
            
              %>
            </tbody>
          </table>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
