/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entidades;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Sunil Comando
 */
@Entity
@Table(catalog = "comparador", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Categoria.findAll", query = "SELECT c FROM Categoria c"),
    @NamedQuery(name = "Categoria.findByCategoriaId", query = "SELECT c FROM Categoria c WHERE c.categoriaId = :categoriaId"),
    @NamedQuery(name = "Categoria.findByCodigoCategoria", query = "SELECT c FROM Categoria c WHERE c.codigoCategoria = :codigoCategoria"),
    @NamedQuery(name = "Categoria.findByCodigoEstabelecimento", query = "SELECT c FROM Categoria c WHERE c.codigoEstabelecimento = :codigoEstabelecimento"),
    @NamedQuery(name = "Categoria.findByDescricaoCategoria", query = "SELECT c FROM Categoria c WHERE c.descricaoCategoria = :descricaoCategoria"),
    @NamedQuery(name = "Categoria.findById", query = "SELECT c FROM Categoria c WHERE c.id = :id")})
public class Categoria implements Serializable {

    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @NotNull
    @Column(name = "categoria_id")
    private int categoriaId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "codigo_categoria")
    private String codigoCategoria;
    @Size(max = 255)
    @Column(name = "codigo_estabelecimento")
    private String codigoEstabelecimento;
    @Size(max = 255)
    @Column(name = "descricao_categoria")
    private String descricaoCategoria;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    private Integer id;
    @JoinColumn(name = "estabelecimento_local_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private Estabelecimento estabelecimentoLocalId;
    @OneToMany(mappedBy = "categoriaLocalId", fetch = FetchType.EAGER)
    private List<Productos> productosList;

    public Categoria() {
    }

    public Categoria(Integer id) {
        this.id = id;
    }

    public Categoria(Integer id, int categoriaId, String codigoCategoria) {
        this.id = id;
        this.categoriaId = categoriaId;
        this.codigoCategoria = codigoCategoria;
    }

    public int getCategoriaId() {
        return categoriaId;
    }

    public void setCategoriaId(int categoriaId) {
        this.categoriaId = categoriaId;
    }

    public String getCodigoCategoria() {
        return codigoCategoria;
    }

    public void setCodigoCategoria(String codigoCategoria) {
        this.codigoCategoria = codigoCategoria;
    }

    public String getCodigoEstabelecimento() {
        return codigoEstabelecimento;
    }

    public void setCodigoEstabelecimento(String codigoEstabelecimento) {
        this.codigoEstabelecimento = codigoEstabelecimento;
    }

    public String getDescricaoCategoria() {
        return descricaoCategoria;
    }

    public void setDescricaoCategoria(String descricaoCategoria) {
        this.descricaoCategoria = descricaoCategoria;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Estabelecimento getEstabelecimentoLocalId() {
        return estabelecimentoLocalId;
    }

    public void setEstabelecimentoLocalId(Estabelecimento estabelecimentoLocalId) {
        this.estabelecimentoLocalId = estabelecimentoLocalId;
    }

    @XmlTransient
    public List<Productos> getProductosList() {
        return productosList;
    }

    public void setProductosList(List<Productos> productosList) {
        this.productosList = productosList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Categoria)) {
            return false;
        }
        Categoria other = (Categoria) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.Categoria[ id=" + id + " ]";
    }
    
}
