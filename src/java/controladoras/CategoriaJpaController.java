/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladoras;

import controladoras.exceptions.NonexistentEntityException;
import entidades.Categoria;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import entidades.Estabelecimento;
import entidades.Productos;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author Sunil Comando
 */
public class CategoriaJpaController implements Serializable {

    public CategoriaJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Categoria categoria) {
        if (categoria.getProductosList() == null) {
            categoria.setProductosList(new ArrayList<Productos>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Estabelecimento estabelecimentoLocalId = categoria.getEstabelecimentoLocalId();
            if (estabelecimentoLocalId != null) {
                estabelecimentoLocalId = em.getReference(estabelecimentoLocalId.getClass(), estabelecimentoLocalId.getId());
                categoria.setEstabelecimentoLocalId(estabelecimentoLocalId);
            }
            List<Productos> attachedProductosList = new ArrayList<Productos>();
            for (Productos productosListProductosToAttach : categoria.getProductosList()) {
                productosListProductosToAttach = em.getReference(productosListProductosToAttach.getClass(), productosListProductosToAttach.getId());
                attachedProductosList.add(productosListProductosToAttach);
            }
            categoria.setProductosList(attachedProductosList);
            em.persist(categoria);
            if (estabelecimentoLocalId != null) {
                estabelecimentoLocalId.getCategoriaList().add(categoria);
                estabelecimentoLocalId = em.merge(estabelecimentoLocalId);
            }
            for (Productos productosListProductos : categoria.getProductosList()) {
                Categoria oldCategoriaLocalIdOfProductosListProductos = productosListProductos.getCategoriaLocalId();
                productosListProductos.setCategoriaLocalId(categoria);
                productosListProductos = em.merge(productosListProductos);
                if (oldCategoriaLocalIdOfProductosListProductos != null) {
                    oldCategoriaLocalIdOfProductosListProductos.getProductosList().remove(productosListProductos);
                    oldCategoriaLocalIdOfProductosListProductos = em.merge(oldCategoriaLocalIdOfProductosListProductos);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Categoria categoria) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Categoria persistentCategoria = em.find(Categoria.class, categoria.getId());
            Estabelecimento estabelecimentoLocalIdOld = persistentCategoria.getEstabelecimentoLocalId();
            Estabelecimento estabelecimentoLocalIdNew = categoria.getEstabelecimentoLocalId();
            List<Productos> productosListOld = persistentCategoria.getProductosList();
            List<Productos> productosListNew = categoria.getProductosList();
            if (estabelecimentoLocalIdNew != null) {
                estabelecimentoLocalIdNew = em.getReference(estabelecimentoLocalIdNew.getClass(), estabelecimentoLocalIdNew.getId());
                categoria.setEstabelecimentoLocalId(estabelecimentoLocalIdNew);
            }
            List<Productos> attachedProductosListNew = new ArrayList<Productos>();
            for (Productos productosListNewProductosToAttach : productosListNew) {
                productosListNewProductosToAttach = em.getReference(productosListNewProductosToAttach.getClass(), productosListNewProductosToAttach.getId());
                attachedProductosListNew.add(productosListNewProductosToAttach);
            }
            productosListNew = attachedProductosListNew;
            categoria.setProductosList(productosListNew);
            categoria = em.merge(categoria);
            if (estabelecimentoLocalIdOld != null && !estabelecimentoLocalIdOld.equals(estabelecimentoLocalIdNew)) {
                estabelecimentoLocalIdOld.getCategoriaList().remove(categoria);
                estabelecimentoLocalIdOld = em.merge(estabelecimentoLocalIdOld);
            }
            if (estabelecimentoLocalIdNew != null && !estabelecimentoLocalIdNew.equals(estabelecimentoLocalIdOld)) {
                estabelecimentoLocalIdNew.getCategoriaList().add(categoria);
                estabelecimentoLocalIdNew = em.merge(estabelecimentoLocalIdNew);
            }
            for (Productos productosListOldProductos : productosListOld) {
                if (!productosListNew.contains(productosListOldProductos)) {
                    productosListOldProductos.setCategoriaLocalId(null);
                    productosListOldProductos = em.merge(productosListOldProductos);
                }
            }
            for (Productos productosListNewProductos : productosListNew) {
                if (!productosListOld.contains(productosListNewProductos)) {
                    Categoria oldCategoriaLocalIdOfProductosListNewProductos = productosListNewProductos.getCategoriaLocalId();
                    productosListNewProductos.setCategoriaLocalId(categoria);
                    productosListNewProductos = em.merge(productosListNewProductos);
                    if (oldCategoriaLocalIdOfProductosListNewProductos != null && !oldCategoriaLocalIdOfProductosListNewProductos.equals(categoria)) {
                        oldCategoriaLocalIdOfProductosListNewProductos.getProductosList().remove(productosListNewProductos);
                        oldCategoriaLocalIdOfProductosListNewProductos = em.merge(oldCategoriaLocalIdOfProductosListNewProductos);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = categoria.getId();
                if (findCategoria(id) == null) {
                    throw new NonexistentEntityException("The categoria with id " + id + " no longer exists.");
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
            Categoria categoria;
            try {
                categoria = em.getReference(Categoria.class, id);
                categoria.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The categoria with id " + id + " no longer exists.", enfe);
            }
            Estabelecimento estabelecimentoLocalId = categoria.getEstabelecimentoLocalId();
            if (estabelecimentoLocalId != null) {
                estabelecimentoLocalId.getCategoriaList().remove(categoria);
                estabelecimentoLocalId = em.merge(estabelecimentoLocalId);
            }
            List<Productos> productosList = categoria.getProductosList();
            for (Productos productosListProductos : productosList) {
                productosListProductos.setCategoriaLocalId(null);
                productosListProductos = em.merge(productosListProductos);
            }
            em.remove(categoria);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Categoria> findCategoriaEntities() {
        return findCategoriaEntities(true, -1, -1);
    }

    public List<Categoria> findCategoriaEntities(int maxResults, int firstResult) {
        return findCategoriaEntities(false, maxResults, firstResult);
    }

    private List<Categoria> findCategoriaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Categoria.class));
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

    public Categoria findCategoria(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Categoria.class, id);
        } finally {
            em.close();
        }
    }

    public int getCategoriaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Categoria> rt = cq.from(Categoria.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
