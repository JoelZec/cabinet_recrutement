package eu.telecom_bretagne.cabinet_recrutement.data.model;
// Generated Jan 17, 2023, 2:55:03 PM by Hibernate Tools 5.4.20.Final


import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;

/**
 * Secteuractivite generated by hbm2java
 */
@Entity
@Table(name="secteuractivite",schema="public")

public class Secteuractivite  implements java.io.Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String intitule;
    private Set<Offreemploi> offreemplois = new HashSet<Offreemploi>(0);
    private Set<Candidature> candidatures = new HashSet<Candidature>(0);

    public Secteuractivite() {
    }

	
    public Secteuractivite(int id, String intitule) {
        this.id = id;
        this.intitule = intitule;
    }
    public Secteuractivite(int id, String intitule, Set<Offreemploi> offreemplois, Set<Candidature> candidatures) {
       this.id = id;
       this.intitule = intitule;
       this.offreemplois = offreemplois;
       this.candidatures = candidatures;
    }
   

    @Id
    @SequenceGenerator(name="secteuractivite_ID_GENERATOR", sequenceName="secteuractivite_id_seq", allocationSize=1)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="secteuractivite_ID_GENERATOR")
    @Column(name="id", unique=true, nullable=false)
    public int getId() {
        return this.id;
    }
    
    public void setId(int id) {
        this.id = id;
    }

    
    @Column(name="intitule", nullable=false, length=50)
    public String getIntitule() {
        return this.intitule;
    }
    
    public void setIntitule(String intitule) {
        this.intitule = intitule;
    }

@ManyToMany(fetch=FetchType.LAZY)
    @JoinTable(name="offresecteur", schema="public", joinColumns = { 
        @JoinColumn(name="id_secteuractivite", nullable=false, updatable=false) }, inverseJoinColumns = { 
        @JoinColumn(name="id_offreemploi", nullable=false, updatable=false) })
    public Set<Offreemploi> getOffreemplois() {
        return this.offreemplois;
    }
    
    public void setOffreemplois(Set<Offreemploi> offreemplois) {
        this.offreemplois = offreemplois;
    }

@ManyToMany(fetch=FetchType.LAZY)
    @JoinTable(name="secteurcandidature", schema="public", joinColumns = { 
        @JoinColumn(name="id_secteuractivite", nullable=false, updatable=false) }, inverseJoinColumns = { 
        @JoinColumn(name="id_candidature", nullable=false, updatable=false) })
    public Set<Candidature> getCandidatures() {
        return this.candidatures;
    }
    
    public void setCandidatures(Set<Candidature> candidatures) {
        this.candidatures = candidatures;
    }

    @Override
    public int hashCode(){
        return Objects.hashCode(id);
    }
  
    @Override
    public boolean equals(Object o){
        return this.id == ((Secteuractivite)o).getId();
    }

}


