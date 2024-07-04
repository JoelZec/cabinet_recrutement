<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.*,
                eu.telecom_bretagne.cabinet_recrutement.data.model.*"%>

<%
  Object utilisateur = session.getAttribute("utilisateur");
%>



<style type="text/css">
  <!--
    /* CSS used here will be applied after bootstrap.css */
    h4 {
      color:#cb1515;
    }
    
</style>

<ul class="nav navbar-top-links navbar-right">

<div class="navbar-header">
  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
    <span class="sr-only">Toggle navigation</span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
  </button>
  <h4><a class="navbar-brand" href="template.jsp">Cabinet de recrutement <br> &nbsp;</a></h4><br>

  <!-- Menu connexion -->
  <li class="dropdown">
    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="true">
      <i class="fa fa-user fa-2x"></i>
      <i class="fa fa-caret-down fa-2x"></i>
    </a>
    <ul class="dropdown-menu dropdown-user">
      
        <li><a href="#"><i class="fa fa-user fa-fw"></i>
        <% if(utilisateur == null) out.println("Utilisateur non connecte"); 
        
        else {
  	  	if(utilisateur instanceof Entreprise)
  	  	{
  	  		Entreprise e = (Entreprise) utilisateur;
  	  		out.println(e.getNom());
  	  	}
  	  	else if(utilisateur instanceof Candidature)
  	  	{
  	  		Candidature c = (Candidature) utilisateur;
  	  		out.println(c.getNom());
  	  		
  	  	}

  	  }
        %>
        </a></li><li class="divider"></li>
        <% if(utilisateur == null){ %>
        	<li><a href="template.jsp?action=connexion"><i class="fa fa-sign-in fa-fw"></i> Login</a></li>
        <%} else { %>
        	<li><a href="deconnexion.jsp"><i class="fa fa-sign-in fa-fw"></i> Logout</a></li>
        <%} %>
        
      
    </ul> <!-- /.dropdown-user -->
  </li> <!-- /.dropdown -->
</div> <!-- /.navbar-header -->
</ul>