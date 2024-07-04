<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.*,
                eu.telecom_bretagne.cabinet_recrutement.data.model.*"%>
            
<%Object utilisateur = session.getAttribute("utilisateur");
if(utilisateur instanceof Entreprise)
{
  Entreprise entreprise = (Entreprise) utilisateur;
}
else if(utilisateur instanceof Candidature)
{
  Candidature candidature = (Candidature) utilisateur;  
}
%>
                

<div class="navbar-default sidebar" role="navigation">
  <div class="sidebar-nav navbar-collapse">
  
    <ul class="nav" id="side-menu">

      <!--
        MENU PRINCIPAL
      -->

      <li><a href="index.jsp"><i class="fa fa-home"></i> Accueil</a></li>
      <li>
        <a href="#"><i class="fa fa-th"></i> Gestion des entreprises<span class="fa arrow"></span></a>
        <ul class="nav nav-second-level">
          <li><a href="template.jsp?action=liste_entreprises">Liste des entreprises</a></li>
          <li><a href="template.jsp?action=nouvelle_entreprise">Nouvelle entreprise</a></li>
        </ul> <!-- /.nav-second-level -->
      </li>
      <li>
        <a href="#"><i class="fa fa-users"></i> Gestion des candidatures<span class="fa arrow"></span></a>
        <ul class="nav nav-second-level">
          <li><a href="template.jsp?action=liste_candidatures">Liste des candidatures</a></li>
          <%
          if(utilisateur instanceof Candidature){%>
          <li><a href="template.jsp?action=liste_offre_candidature">Liste des offres potentielles</a></li>
          <%}%>
          <li><a href="template.jsp?action=nouvelle_candidature">Nouvelle candidature</a></li>
        </ul> <!-- /.nav-second-level -->
      </li>
      <li>
        <a href="#"><i class="fa fa-th"></i> Gestion des offres d'emploi<span class="fa arrow"></span></a>
        <ul class="nav nav-second-level">
          <li><a href="template.jsp?action=liste_offres">Liste de toutes les offres d'emploi</a></li>
         <%
         if(utilisateur instanceof Entreprise){%>
              <li><a href="template.jsp?action=liste_offre_entreprise">Liste des offres d'emploi de notre entreprise</a></li>
              <li><a href="template.jsp?action=nouvelle_offreemploi">Nouvelle offre d'emploi</a></li>
          <%}%>
        </ul> <!-- /.nav-second-level -->
      </li>

      <!--
        MENU SECONDAIRE
      -->

      <li><h4>&nbsp;</h4></li>
      <li><a href="http://formations.telecom-bretagne.eu/fip_inf210_fil_rouge/" target="_blank"><i class="fa fa-question-circle"></i> Documentation du fil rouge</a></li>
      <li><a href="http://srv-labs-006.enst-bretagne.fr/CabinetRecrutement_Web/" target="_blank"><i class="fa fa-certificate"></i> Demonstration du prototype</a></li>
      <li><a href="bootstrap/pages/" target="_blank"><i class="fa fa-thumbs-up"></i> Demo du template SB Admin 2</a></li>
    </ul>
  </div> <!-- /.sidebar-collapse -->
</div> <!-- /.navbar-static-side -->
