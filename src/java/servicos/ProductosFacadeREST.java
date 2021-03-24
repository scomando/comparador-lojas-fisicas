/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servicos;

import controladoras.CategoriaJpaController;
import controladoras.EstabelecimentoJpaController;
import controladoras.ProductosJpaController;
import entidades.Categoria;
import entidades.Estabelecimento;
import entidades.Productos;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.security.RolesAllowed;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author APHIED
 */
//@javax.ejb.Stateless
@Path("productos")
public class ProductosFacadeREST extends AbstractFacade<Productos> {

    @PersistenceContext(unitName = "ComparadorPU")
    private EntityManager em;

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("ComparadorPU");

    public ProductosFacadeREST() {
        super(Productos.class);
    }

    @POST
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public String create() {
        return "Entrou";
//        ProductosJpaController pc = new ProductosJpaController(emf);
//        CategoriaJpaController cc = new CategoriaJpaController(emf);
//        EstabelecimentoJpaController ec = new EstabelecimentoJpaController(emf);
//
//        List<Estabelecimento> E = ec.findEstabelecimentoEntities();
//        Estabelecimento e = null;
//        List<Categoria> C = cc.findCategoriaEntities();
//        Categoria c = null;
//
//        for (int i = 0; i < E.size(); i++) {
//            if (E.get(i).getCodigoEstabelecimento().trim().equalsIgnoreCase(producto.getEstabelecimentoCodigo().trim())) {
//                e = E.get(i);
//                break;
//            }
//        }
//
//        for (int i = 0; i < C.size(); i++) {
//            if (C.get(i).getCodigoCategoria().trim().equalsIgnoreCase(producto.getCategoriaCodigo().trim())) {
//                c = C.get(i);
//                break;
//            }
//        }
//
//        try {
//            producto.setCategoriaLocalId(c);
//            producto.setEstabelecimentoLocalId(e);
//            pc.create(producto);
//            System.out.println("Created: " + producto.getNomeProducto());
//        } catch (Exception ex) {
//            System.out.println("Opsss: " + ex.getMessage());
//        }
    }

    @PUT
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    @Override
    public void edit(Productos producto) {
        ProductosJpaController pc = new ProductosJpaController(emf);
        try {
            Productos p = pc.findProductos(producto.getProductoId());
           p.setQuantidadeProducto(producto.getQuantidadeProducto());
            pc.edit(p);
        } catch (Exception ex) {
            Logger.getLogger(ProductosFacadeREST.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        ProductosJpaController pc = new ProductosJpaController(emf);
        try {
            Productos p = pc.findProductos(id);
            pc.destroy(p.getId());
        } catch (Exception ex) {
            Logger.getLogger(ProductosFacadeREST.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Productos find(@PathParam("id") Integer id) {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Productos> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Productos> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

    @GET
    @Path("count")
    @Produces(MediaType.TEXT_PLAIN)
    public String countREST() {
        return String.valueOf(super.count());
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

}
