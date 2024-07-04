package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

// import javax.persistence.*;
import jakarta.persistence.*;


/**
 * The persistent class for the entreprise database table.
 * 
 */
@Entity
@NamedQuery(name="Entreprise.findAll", query="SELECT e FROM Entreprise e")
public class Entreprise implements Serializable {
  private static final long serialVersionUID = 1L;

  private Integer id;

  private String adressePostale;

  private String descriptif;

  private String nom;

  private Set<Offreemploi> Offreemploi = new HashSet<Offreemploi>(0);

  public Entreprise() {
  }

  @Id
  @SequenceGenerator(name="ENTREPRISE_ID_GENERATOR", sequenceName="ENTREPRISE_ID_SEQ", allocationSize=1)
  @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="ENTREPRISE_ID_GENERATOR")
  public Integer getId() {
    return this.id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  @Column(name="adresse_postale")
  public String getAdressePostale() {
    return this.adressePostale;
  }

  public void setAdressePostale(String adressePostale) {
    this.adressePostale = adressePostale;
  }

  public String getDescriptif() {
    return this.descriptif;
  }

  public void setDescriptif(String descriptif) {
    this.descriptif = descriptif;
  }

  public String getNom() {
    return this.nom;
  }

  public void setNom(String nom) {
    this.nom = nom;
  }

  @Override
  public String toString()
  {
    return "Entreprise [id=" + id + ", nom=" + nom + ", adressePostale=" + adressePostale + "]";
  }

  @OneToMany(fetch=FetchType.EAGER, mappedBy="entreprise")
    public Set<Offreemploi> getOffreemplois() {
        return this.Offreemploi;
    }
    
    public void setOffreemplois(Set<Offreemploi> offreemplois) {
        this.Offreemploi = offreemplois;
    }

}