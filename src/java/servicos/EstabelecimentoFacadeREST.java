/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servicos;

import controladoras.EstabelecimentoJpaController;
import entidades.Estabelecimento;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@Path("estabelecimento")
public class EstabelecimentoFacadeREST extends AbstractFacade<Estabelecimento> {

    @PersistenceContext(unitName = "ComparadorPU")
    private EntityManager em;

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("ComparadorPU");

    public EstabelecimentoFacadeREST() {
        super(Estabelecimento.class);
    }

    @POST
    @Override
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void create(Estabelecimento estabelecimento) {
        EstabelecimentoJpaController ec = new EstabelecimentoJpaController(emf);
        try {
            ec.create(estabelecimento);
            System.out.println("Criado com sucesso: " + estabelecimento.getNomeEstabelecimento());
        } catch (Exception e) {
            System.out.println("Falha no registro do estabelecimento: " + e.getMessage());
        }
    }

    @PUT
//    @Path("{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    @Override
    public void edit(Estabelecimento estabelecimento) {
        EstabelecimentoJpaController ec = new EstabelecimentoJpaController(emf);
        Estabelecimento e = new Estabelecimento();
        List<Estabelecimento> E = ec.findEstabelecimentoEntities();
        System.out.println("Falha na actualizacao do estabelecimento: " + estabelecimento.getEstabelecimentoId());
        try {
            for (Estabelecimento i : E) {
                if (i.getEstabelecimentoId() == estabelecimento.getEstabelecimentoId()) {
                    e = ec.findEstabelecimento(i.getId());
                    System.out.println("i: " +i.getId());

                    e.setActivo(true);
                    e.setEstabelecimentoId(estabelecimento.getEstabelecimentoId());
//                    e.setCategoriaList(estabelecimento.getCategoriaList());
                    e.setCidadeEstabelecimento(estabelecimento.getCidadeEstabelecimento());
                    e.setCodigoEstabelecimento(estabelecimento.getCodigoEstabelecimento());
                    e.setCodigoPostal(estabelecimento.getCodigoPostal());
                    e.setNomeEstabelecimento(estabelecimento.getNomeEstabelecimento());
                    e.setEmailEstabelecimento(estabelecimento.getEmailEstabelecimento());
                    e.setTelefoneEstabelecimento(estabelecimento.getTelefoneEstabelecimento());
                    e.setIvaEstabelecimento(estabelecimento.getIvaEstabelecimento());
                    e.setTipoEstabelecimento(estabelecimento.getTipoEstabelecimento());
                    ec.edit(e);
                    break;
                }
            }

            System.out.println("Falha na actualizacao do estabelecimento: " + e.getEstabelecimentoId());

            System.out.println("Actualizado com sucesso: " + estabelecimento.getNomeEstabelecimento());
        } catch (Exception ex) {
            System.out.println("Falha na actualizacao do estabelecimento: " + estabelecimento.getNomeEstabelecimento());
            Logger.getLogger(EstabelecimentoFacadeREST.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        super.remove(super.find(id));
    }

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Estabelecimento find(@PathParam("id") Integer id) {
        EstabelecimentoJpaController ec = new EstabelecimentoJpaController(emf);
        return ec.findEstabelecimento(id);
    }

    @GET
    @Override
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Estabelecimento> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Estabelecimento> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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
