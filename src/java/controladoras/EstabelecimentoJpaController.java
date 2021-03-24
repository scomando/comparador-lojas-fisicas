/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladoras;

import controladoras.exceptions.NonexistentEntityException;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import entidades.Categoria;
import entidades.Estabelecimento;
import java.util.ArrayList;
import java.util.List;
import entidades.Productos;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author Sunil Comando
 */
public class EstabelecimentoJpaController implements Serializable {

    public EstabelecimentoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Estabelecimento estabelecimento) {
        if (estabelecimento.getCategoriaList() == null) {
            estabelecimento.setCategoriaList(new ArrayList<Categoria>());
        }
        if (estabelecimento.getProductosList() == null) {
            estabelecimento.setProductosList(new ArrayList<Productos>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Categoria> attachedCategoriaList = new ArrayList<Categoria>();
            for (Categoria categoriaListCategoriaToAttach : estabelecimento.getCategoriaList()) {
                categoriaListCategoriaToAttach = em.getReference(categoriaListCategoriaToAttach.getClass(), categoriaListCategoriaToAttach.getId());
                attachedCategoriaList.add(categoriaListCategoriaToAttach);
            }
            estabelecimento.setCategoriaList(attachedCategoriaList);
            List<Productos> attachedProductosList = new ArrayList<Productos>();
            for (Productos productosListProductosToAttach : estabelecimento.getProductosList()) {
                productosListProductosToAttach = em.getReference(productosListProductosToAttach.getClass(), productosListProductosToAttach.getId());
                attachedProductosList.add(productosListProductosToAttach);
            }
            estabelecimento.setProductosList(attachedProductosList);
            em.persist(estabelecimento);
            for (Categoria categoriaListCategoria : estabelecimento.getCategoriaList()) {
                Estabelecimento oldEstabelecimentoLocalIdOfCategoriaListCategoria = categoriaListCategoria.getEstabelecimentoLocalId();
                categoriaListCategoria.setEstabelecimentoLocalId(estabelecimento);
                categoriaListCategoria = em.merge(categoriaListCategoria);
                if (oldEstabelecimentoLocalIdOfCategoriaListCategoria != null) {
                    oldEstabelecimentoLocalIdOfCategoriaListCategoria.getCategoriaList().remove(categoriaListCategoria);
                    oldEstabelecimentoLocalIdOfCategoriaListCategoria = em.merge(oldEstabelecimentoLocalIdOfCategoriaListCategoria);
                }
            }
            for (Productos productosListProductos : estabelecimento.getProductosList()) {
                Estabelecimento oldEstabelecimentoLocalIdOfProductosListProductos = productosListProductos.getEstabelecimentoLocalId();
                productosListProductos.setEstabelecimentoLocalId(estabelecimento);
                productosListProductos = em.merge(productosListProductos);
                if (oldEstabelecimentoLocalIdOfProductosListProductos != null) {
                    oldEstabelecimentoLocalIdOfProductosListProductos.getProductosList().remove(productosListProductos);
                    oldEstabelecimentoLocalIdOfProductosListProductos = em.merge(oldEstabelecimentoLocalIdOfProductosListProductos);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Estabelecimento estabelecimento) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Estabelecimento persistentEstabelecimento = em.find(Estabelecimento.class, estabelecimento.getId());
            List<Categoria> categoriaListOld = persistentEstabelecimento.getCategoriaList();
            List<Categoria> categoriaListNew = estabelecimento.getCategoriaList();
            List<Productos> productosListOld = persistentEstabelecimento.getProductosList();
            List<Productos> productosListNew = estabelecimento.getProductosList();
            List<Categoria> attachedCategoriaListNew = new ArrayList<Categoria>();
            for (Categoria categoriaListNewCategoriaToAttach : categoriaListNew) {
                categoriaListNewCategoriaToAttach = em.getReference(categoriaListNewCategoriaToAttach.getClass(), categoriaListNewCategoriaToAttach.getId());
                attachedCategoriaListNew.add(categoriaListNewCategoriaToAttach);
            }
            categoriaListNew = attachedCategoriaListNew;
            estabelecimento.setCategoriaList(categoriaListNew);
            List<Productos> attachedProductosListNew = new ArrayList<Productos>();
            for (Productos productosListNewProductosToAttach : productosListNew) {
                productosListNewProductosToAttach = em.getReference(productosListNewProductosToAttach.getClass(), productosListNewProductosToAttach.getId());
                attachedProductosListNew.add(productosListNewProductosToAttach);
            }
            productosListNew = attachedProductosListNew;
            estabelecimento.setProductosList(productosListNew);
            estabelecimento = em.merge(estabelecimento);
            for (Categoria categoriaListOldCategoria : categoriaListOld) {
                if (!categoriaListNew.contains(categoriaListOldCategoria)) {
                    categoriaListOldCategoria.setEstabelecimentoLocalId(null);
                    categoriaListOldCategoria = em.merge(categoriaListOldCategoria);
                }
            }
            for (Categoria categoriaListNewCategoria : categoriaListNew) {
                if (!categoriaListOld.contains(categoriaListNewCategoria)) {
                    Estabelecimento oldEstabelecimentoLocalIdOfCategoriaListNewCategoria = categoriaListNewCategoria.getEstabelecimentoLocalId();
                    categoriaListNewCategoria.setEstabelecimentoLocalId(estabelecimento);
                    categoriaListNewCategoria = em.merge(categoriaListNewCategoria);
                    if (oldEstabelecimentoLocalIdOfCategoriaListNewCategoria != null && !oldEstabelecimentoLocalIdOfCategoriaListNewCategoria.equals(estabelecimento)) {
                        oldEstabelecimentoLocalIdOfCategoriaListNewCategoria.getCategoriaList().remove(categoriaListNewCategoria);
                        oldEstabelecimentoLocalIdOfCategoriaListNewCategoria = em.merge(oldEstabelecimentoLocalIdOfCategoriaListNewCategoria);
                    }
                }
            }
            for (Productos productosListOldProductos : productosListOld) {
                if (!productosListNew.contains(productosListOldProductos)) {
                    productosListOldProductos.setEstabelecimentoLocalId(null);
                    productosListOldProductos = em.merge(productosListOldProductos);
                }
            }
            for (Productos productosListNewProductos : productosListNew) {
                if (!productosListOld.contains(productosListNewProductos)) {
                    Estabelecimento oldEstabelecimentoLocalIdOfProductosListNewProductos = productosListNewProductos.getEstabelecimentoLocalId();
                    productosListNewProductos.setEstabelecimentoLocalId(estabelecimento);
                    productosListNewProductos = em.merge(productosListNewProductos);
                    if (oldEstabelecimentoLocalIdOfProductosListNewProductos != null && !oldEstabelecimentoLocalIdOfProductosListNewProductos.equals(estabelecimento)) {
                        oldEstabelecimentoLocalIdOfProductosListNewProductos.getProductosList().remove(productosListNewProductos);
                        oldEstabelecimentoLocalIdOfProductosListNewProductos = em.merge(oldEstabelecimentoLocalIdOfProductosListNewProductos);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = estabelecimento.getId();
                if (findEstabelecimento(id) == null) {
                    throw new NonexistentEntityException("The estabelecimento with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Estabelecimento estabelecimento;
            try {
                estabelecimento = em.getReference(Estabelecimento.class, id);
                estabelecimento.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The estabelecimento with id " + id + " no longer exists.", enfe);
            }
            List<Categoria> categoriaList = estabelecimento.getCategoriaList();
            for (Categoria categoriaListCategoria : categoriaList) {
                categoriaListCategoria.setEstabelecimentoLocalId(null);
                categoriaListCategoria = em.merge(categoriaListCategoria);
            }
            List<Productos> productosList = estabelecimento.getProductosList();
            for (Productos productosListProductos : productosList) {
                productosListProductos.setEstabelecimentoLocalId(null);
                productosListProductos = em.merge(productosListProductos);
            }
            em.remove(estabelecimento);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Estabelecimento> findEstabelecimentoEntities() {
        return findEstabelecimentoEntities(true, -1, -1);
    }

    public List<Estabelecimento> findEstabelecimentoEntities(int maxResults, int firstResult) {
        return findEstabelecimentoEntities(false, maxResults, firstResult);
    }

    private List<Estabelecimento> findEstabelecimentoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Estabelecimento.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Estabelecimento findEstabelecimento(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Estabelecimento.class, id);
        } finally {
            em.close();
        }
    }

    public int getEstabelecimentoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Estabelecimento> rt = cq.from(Estabelecimento.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
