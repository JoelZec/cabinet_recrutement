<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.*,
                eu.telecom_bretagne.cabinet_recrutement.data.model.*,
                java.util.List"%>

<%
  IServiceOffreemploi serviceOffreemploi = (IServiceOffreemploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreemploi");
  List<Offreemploi> offresemploi = serviceOffreemploi.listeDesOffreemplois();
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
                <th>Entreprise</th>
                <th>Descriptif de la mission</th>
                <th>Profil recherche</th>
                <th>Date de depot</th>
                <th>Niveau de qualification</th>
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
                Entreprise e = offre.getEntreprise();

                String ne =  "Unknown";
                if(e != null){
                  ne = e.getNom();
                }
                %>
                <tr>
                 <td>OFF_<%=offre.getId()%></td>
                 <td><%=offre.getTitle()%></td>
                 <td>
                  <%= ne%>
                  </td>
                 <td><%=offre.getDescriptifmission()%></td>
                 <td><%=offre.getProfilrecherche()%></td>
                 <td><%=offre.getDatedepot()%></td>
                 <td><%=offre.getNiveauqualification().getIntitule()%></td>
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
