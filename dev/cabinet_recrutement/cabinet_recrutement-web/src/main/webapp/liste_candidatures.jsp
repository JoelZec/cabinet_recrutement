<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                java.util.List"%>

<%
  IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  List<Candidature> candidatures = serviceCandidature.listeDesCandidatures();
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Liste des candidatures referencees </h3></div> <!-- /.panel-heading -->
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
                <th>Informations</th>
              </tr>
            </thead>
            <!--
              Contenu du tableau
            -->
            <tbody>
              <%
              for(Candidature cand : candidatures)
              {
                %>
                <tr>
                 <td>CAND_<%=cand.getId()%></td>
                 <td><%=cand.getNom()%></td>
                 <td><%=cand.getPrenom()%></td>
                 <td><%=cand.getCv()%></td>
                 <td><%=cand.getNiveauqualification().getIntitule()%></td>
                 <td><%=cand.getDatenaissance()%></td>
                 <td><%=cand.getAdressepostale()%></td>
                 <td><%=cand.getAdresseemail()%></td>
                 <td><%=cand.getDatedepot()%></td>
                 <td align="center"><a href="template.jsp?action=infos_candidatures&id=<%=cand.getId()%>"><i class="fa fa-eye fa-lg"></i></a></td>
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
