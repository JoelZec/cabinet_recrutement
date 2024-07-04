<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.*,
                eu.telecom_bretagne.cabinet_recrutement.data.model.*,
                java.util.Set"%>

<%
  String erreur = null;
  String idStringValue = request.getParameter("id");
  int id = -1;
  Offreemploi offreemploi = null;
  IServiceSecteuractivite serviceSecteuractivite = (IServiceSecteuractivite) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteuractivite");

  
  if(idStringValue == null)
  {
    erreur="Aucun identifiant d'offre d'emploi n'est fourni dans la demande.";
  }
  else
  {
    try
    {
      id = new Integer(idStringValue);
      // C'est OK : on a bien un id
      IServiceOffreemploi serviceOffreemploi = (IServiceOffreemploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreemploi");
      offreemploi = serviceOffreemploi.getOffreemploi(id);
      if(offreemploi == null)
      {
        erreur="Aucune offre d'emploi ne correspond a cet identifiant : " + id;
      }
    }
    catch(NumberFormatException e)
    {
      erreur = "La valeur de l'identifiant n'est pas numerique";
    }
  }
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Informations sur l'offre d'emploi</h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <%
        if(erreur != null) // Une erreur a ete detectee et est affichee.
        {
         %>
         <div class="row col-xs-offset-1 col-xs-10">
           <div class="panel panel-red">
             <div class="panel-heading ">
               Impossible de traiter la demande
             </div>
             <div class="panel-body text-center">
               <p class="text-danger"><strong><%=erreur%></strong></p>
             </div>
           </div>
         </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
         <%
         }
        else
        {
           %>
        <div class="table-responsive">
            <small>
            <table class="table">
              <tbody>
                <tr class="success">
                  <td width="200"><strong>Identifiant (login)</strong></td>
                  <td>OFF_<%=offreemploi.getId()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Titre</strong></td>
                  <td><%=offreemploi.getTitle()%></td>
                </tr>
                <tr class="warning">
                  <td><strong>Entreprise</strong></td>
                  <td><%=offreemploi.getEntreprise().getNom()%></td>
                </tr>
                <tr class="warning">
                    <td><strong>Descriptif de la mission</strong></td>
                    <td><%=offreemploi.getDescriptifmission()%></td>
                  </tr>
                  <tr class="warning">
                    <td><strong>Profil recherche</strong></td>
                    <td><%=offreemploi.getProfilrecherche()%></td>
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
                  </tr>
                  <tr class="warning">
                    <td><strong>Niveau de qualification</strong></td>
                    <td><%=offreemploi.getNiveauqualification().getIntitule()%></td>
                  </tr>
                  <tr class="warning">
                    <td><strong>Date de depot</strong></td>
                    <td><%=offreemploi.getDatedepot()%></td>
                  </tr>
              </tbody>
            </table>
            </small>      
        </div>
          <%
        }
        %>
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
