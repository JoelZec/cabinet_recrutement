<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.*,
                eu.telecom_bretagne.cabinet_recrutement.data.model.*"%>

<%
  String erreur = null;
  String identifiant = request.getParameter("identifiant");
%>

<!DOCTYPE html>
<html lang="en">
  <body>
    <div id="wrapper">
      <!-- Navigation -->
      <nav class="navbar
                  navbar-default
                  navbar-static-top"
           role="navigation"
           style="margin-bottom: 0">
      </nav>
      <div id="page-wrapper">
        <p style="font-size: 5">&nbsp;</p>
        <div class="row">
          <div class="col-lg-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3><i class="fa fa-sign-in"></i> Connexion</h3>
              </div> <!-- /.panel-heading -->
              <div class="panel-body">
                <%
                  if(identifiant == null) // Pas de paramètre "identifiant" => affichage du formulaire
                  {
                    %>
                    <div class="row col-xs-offset-2 col-xs-8">
                      <!-- Formulaire -->
                      <form role="form" action="connexion.jsp" method="get">
                        <fieldset>
                          <div class="form-group">
                            <input class="form-control" placeholder="Identifiant" name="identifiant" type="text" autofocus>
                          </div>
                          <button type="submit" class="btn btn-lg btn-success btn-block">Login</button>
                        </fieldset>
                      </form>
                      <p/>
                      <!-- Message -->
                      <div class="alert alert-info col-xs-offset-3 col-xs-6">
                         L'identifiant est la clé primaire préfixée de :
                         <ul>
                           <li>pour une entreprise : <code>ENT_</code> <em>(ENT_12 par exemple)</em></li>
                           <li>pour une candidature : <code>CAND_</code> <em>(CAND_7 par exemple)</em></li>
                         </ul>
                         <br/>
                         <em>Note : l'identification se fait sans mot de passe.</em>
                       </div>
                    </div>
                    <%
                  }
                  else                    // Paramètre "identifiant" existant => connexion
                  {
                    if(identifiant.equals(""))
                    {
                      %>
                      <p class="erreur">Veuillez renseignez votre numero d'identifiant pour pouvoir vous connecter</p>
                      <a href="index.jsp">Retour...</a>
                      <%
                    }
                    else if(identifiant.startsWith("CAND_"))
                    {
                      IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
                      int id = Integer.parseInt(identifiant.substring(5)); // On enl�ve le préfixe "CAND_";
                      Candidature candidature = serviceCandidature.getCandidature(id);
                      if(candidature == null)
                      {
                        %>
                        <p class="erreur">Erreur : il n'y a pas de candidature avec cet identifiant : <%=identifiant%></p>
                        <a href="index.jsp">Retour...</a>
                        <%
                      }
                      else
                      {
                        session.setAttribute("utilisateur",candidature);
                        response.sendRedirect("index.jsp");
                      }
                    }
                    else if(identifiant.startsWith("ENT_"))
                    {
                      IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
                      int id = Integer.parseInt(identifiant.substring(4)); // On enlève le préfixe "ENT_";
                      Entreprise entreprise = serviceEntreprise.getEntreprise(id);
                      if(entreprise == null)
                      {
                        %>
                        <p class="erreur">Erreur : il n'y a pas d'entreprise avec cet identifiant : <%=identifiant%></p>
                        <a href="index.jsp">Retour...</a>
                        <%
                      }
                      else
                      {
                        session.setAttribute("utilisateur",entreprise);
                        response.sendRedirect("index.jsp");
                      }
                    }

                  }
                
                
                %>