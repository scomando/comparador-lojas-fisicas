/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entidades;

import java.io.Serializable;
import java.math.BigInteger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Sunil Comando
 */
@Entity
@Table(catalog = "comparador", schema = "public")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Productos.findAll", query = "SELECT p FROM Productos p"),
    @NamedQuery(name = "Productos.findByCategoriaCodigo", query = "SELECT p FROM Productos p WHERE p.categoriaCodigo = :categoriaCodigo"),
    @NamedQuery(name = "Productos.findByCodigoBarras", query = "SELECT p FROM Productos p WHERE p.codigoBarras = :codigoBarras"),
    @NamedQuery(name = "Productos.findByDescricaoProducto", query = "SELECT p FROM Productos p WHERE p.descricaoProducto = :descricaoProducto"),
    @NamedQuery(name = "Productos.findByEstabelecimentoCodigo", query = "SELECT p FROM Productos p WHERE p.estabelecimentoCodigo = :estabelecimentoCodigo"),
    @NamedQuery(name = "Productos.findByNomeProducto", query = "SELECT p FROM Productos p WHERE p.nomeProducto = :nomeProducto"),
    @NamedQuery(name = "Productos.findByPrecoProducto", query = "SELECT p FROM Productos p WHERE p.precoProducto = :precoProducto"),
    @NamedQuery(name = "Productos.findByProductoId", query = "SELECT p FROM Productos p WHERE p.productoId = :productoId"),
    @NamedQuery(name = "Productos.findByQuantidadeProducto", query = "SELECT p FROM Productos p WHERE p.quantidadeProducto = :quantidadeProducto"),
    @NamedQuery(name = "Productos.findById", query = "SELECT p FROM Productos p WHERE p.id = :id")})
public class Productos implements Serializable {

    private static final long serialVersionUID = 1L;
    @Size(max = 255)
    @Column(name = "categoria_codigo")
    private String categoriaCodigo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "codigo_barras")
    private String codigoBarras;
    @Size(max = 255)
    @Column(name = "descricao_producto")
    private String descricaoProducto;
    @Size(max = 255)
    @Column(name = "estabelecimento_codigo")
    private String estabelecimentoCodigo;
    @Size(max = 255)
    @Column(name = "nome_producto")
    private String nomeProducto;
    @Column(name = "preco_producto")
    private BigInteger precoProducto;
    @Basic(optional = false)
    @NotNull
    @Column(name = "producto_id")
    private int productoId;
    @Size(max = 255)
    @Column(name = "quantidade_producto")
    private String quantidadeProducto;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    private Integer id;
    @Lob
    private byte[] imagem;
    @JoinColumn(name = "categoria_local_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private Categoria categoriaLocalId;
    @JoinColumn(name = "estabelecimento_local_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private Estabelecimento estabelecimentoLocalId;

    public Productos() {
    }

    public Productos(Integer id) {
        this.id = id;
    }

    public Productos(Integer id, String codigoBarras, int productoId) {
        this.id = id;
        this.codigoBarras = codigoBarras;
        this.productoId = productoId;
    }

    public String getCategoriaCodigo() {
        return categoriaCodigo;
    }

    public void setCategoriaCodigo(String categoriaCodigo) {
        this.categoriaCodigo = categoriaCodigo;
    }

    public String getCodigoBarras() {
        return codigoBarras;
    }

    public void setCodigoBarras(String codigoBarras) {
        this.codigoBarras = codigoBarras;
    }

    public String getDescricaoProducto() {
        return descricaoProducto;
    }

    public void setDescricaoProducto(String descricaoProducto) {
        this.descricaoProducto = descricaoProducto;
    }

    public String getEstabelecimentoCodigo() {
        return estabelecimentoCodigo;
    }

    public void setEstabelecimentoCodigo(String estabelecimentoCodigo) {
        this.estabelecimentoCodigo = estabelecimentoCodigo;
    }

    public String getNomeProducto() {
        return nomeProducto;
    }

    public void setNomeProducto(String nomeProducto) {
        this.nomeProducto = nomeProducto;
    }

    public BigInteger getPrecoProducto() {
        return precoProducto;
    }

    public void setPrecoProducto(BigInteger precoProducto) {
        this.precoProducto = precoProducto;
    }

    public int getProductoId() {
        return productoId;
    }

    public void setProductoId(int productoId) {
        this.productoId = productoId;
    }

    public String getQuantidadeProducto() {
        return quantidadeProducto;
    }

    public void setQuantidadeProducto(String quantidadeProducto) {
        this.quantidadeProducto = quantidadeProducto;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public byte[] getImagem() {
        return imagem;
    }

    public void setImagem(byte[] imagem) {
        this.imagem = imagem;
    }

    public Categoria getCategoriaLocalId() {
        return categoriaLocalId;
    }

    public void setCategoriaLocalId(Categoria categoriaLocalId) {
        this.categoriaLocalId = categoriaLocalId;
    }

    public Estabelecimento getEstabelecimentoLocalId() {
        return estabelecimentoLocalId;
    }

    public void setEstabelecimentoLocalId(Estabelecimento estabelecimentoLocalId) {
        this.estabelecimentoLocalId = estabelecimentoLocalId;
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
        if (!(object instanceof Productos)) {
            return false;
        }
        Productos other = (Productos) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.Productos[ id=" + id + " ]";
    }
    
}
