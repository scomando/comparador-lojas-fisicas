/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servicos;

import controladoras.CategoriaJpaController;
import controladoras.EstabelecimentoJpaController;
import entidades.Categoria;
import entidades.Estabelecimento;
import java.util.List;
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
@Path("categoria")
public class CategoriaFacadeREST extends AbstractFacade<Categoria> {

    @PersistenceContext(unitName = "ComparadorPU")
    private EntityManager em;

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("ComparadorPU");

    public CategoriaFacadeREST() {
        super(Categoria.class);
    }

    @POST
    @Override
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void create(Categoria categoria) {
        CategoriaJpaController cc = new CategoriaJpaController(emf);
        EstabelecimentoJpaController ec = new EstabelecimentoJpaController(emf);

        List<Estabelecimento> E = ec.findEstabelecimentoEntities();
        Estabelecimento e = null;
        List<Categoria> C = cc.findCategoriaEntities();

        for (int i = 0; i < E.size(); i++) {
            if (E.get(i).getCodigoEstabelecimento().trim().equalsIgnoreCase(categoria.getCodigoEstabelecimento().trim())) {
                e = E.get(i);
                break;
            }
        }

        try {
            categoria.setEstabelecimentoLocalId(e);
            cc.create(categoria);
            System.out.println("Created: " + categoria.getDescricaoCategoria());
        } catch (Exception ex) {
            System.out.println("Opsss: " + ex.getMessage());
        }
    }

    @PUT
    @Path("{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void edit(@PathParam("id") Integer id, Categoria entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        super.remove(super.find(id));
    }

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Categoria find(@PathParam("id") Integer id) {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Categoria> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Categoria> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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
