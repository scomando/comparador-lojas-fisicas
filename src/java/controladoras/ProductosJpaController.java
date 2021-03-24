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
import entidades.Productos;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author Sunil Comando
 */
public class ProductosJpaController implements Serializable {

    public ProductosJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Productos productos) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Categoria categoriaLocalId = productos.getCategoriaLocalId();
            if (categoriaLocalId != null) {
                categoriaLocalId = em.getReference(categoriaLocalId.getClass(), categoriaLocalId.getId());
                productos.setCategoriaLocalId(categoriaLocalId);
            }
            Estabelecimento estabelecimentoLocalId = productos.getEstabelecimentoLocalId();
            if (estabelecimentoLocalId != null) {
                estabelecimentoLocalId = em.getReference(estabelecimentoLocalId.getClass(), estabelecimentoLocalId.getId());
                productos.setEstabelecimentoLocalId(estabelecimentoLocalId);
            }
            em.persist(productos);
            if (categoriaLocalId != null) {
                categoriaLocalId.getProductosList().add(productos);
                categoriaLocalId = em.merge(categoriaLocalId);
            }
            if (estabelecimentoLocalId != null) {
                estabelecimentoLocalId.getProductosList().add(productos);
                estabelecimentoLocalId = em.merge(estabelecimentoLocalId);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Productos productos) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Productos persistentProductos = em.find(Productos.class, productos.getId());
            Categoria categoriaLocalIdOld = persistentProductos.getCategoriaLocalId();
            Categoria categoriaLocalIdNew = productos.getCategoriaLocalId();
            Estabelecimento estabelecimentoLocalIdOld = persistentProductos.getEstabelecimentoLocalId();
            Estabelecimento estabelecimentoLocalIdNew = productos.getEstabelecimentoLocalId();
            if (categoriaLocalIdNew != null) {
                categoriaLocalIdNew = em.getReference(categoriaLocalIdNew.getClass(), categoriaLocalIdNew.getId());
                productos.setCategoriaLocalId(categoriaLocalIdNew);
            }
            if (estabelecimentoLocalIdNew != null) {
                estabelecimentoLocalIdNew = em.getReference(estabelecimentoLocalIdNew.getClass(), estabelecimentoLocalIdNew.getId());
                productos.setEstabelecimentoLocalId(estabelecimentoLocalIdNew);
            }
            productos = em.merge(productos);
            if (categoriaLocalIdOld != null && !categoriaLocalIdOld.equals(categoriaLocalIdNew)) {
                categoriaLocalIdOld.getProductosList().remove(productos);
                categoriaLocalIdOld = em.merge(categoriaLocalIdOld);
            }
            if (categoriaLocalIdNew != null && !categoriaLocalIdNew.equals(categoriaLocalIdOld)) {
                categoriaLocalIdNew.getProductosList().add(productos);
                categoriaLocalIdNew = em.merge(categoriaLocalIdNew);
            }
            if (estabelecimentoLocalIdOld != null && !estabelecimentoLocalIdOld.equals(estabelecimentoLocalIdNew)) {
                estabelecimentoLocalIdOld.getProductosList().remove(productos);
                estabelecimentoLocalIdOld = em.merge(estabelecimentoLocalIdOld);
            }
            if (estabelecimentoLocalIdNew != null && !estabelecimentoLocalIdNew.equals(estabelecimentoLocalIdOld)) {
                estabelecimentoLocalIdNew.getProductosList().add(productos);
                estabelecimentoLocalIdNew = em.merge(estabelecimentoLocalIdNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = productos.getId();
                if (findProductos(id) == null) {
                    throw new NonexistentEntityException("The productos with id " + id + " no longer exists.");
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
            Productos productos;
            try {
                productos = em.getReference(Productos.class, id);
                productos.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The productos with id " + id + " no longer exists.", enfe);
            }
            Categoria categoriaLocalId = productos.getCategoriaLocalId();
            if (categoriaLocalId != null) {
                categoriaLocalId.getProductosList().remove(productos);
                categoriaLocalId = em.merge(categoriaLocalId);
            }
            Estabelecimento estabelecimentoLocalId = productos.getEstabelecimentoLocalId();
            if (estabelecimentoLocalId != null) {
                estabelecimentoLocalId.getProductosList().remove(productos);
                estabelecimentoLocalId = em.merge(estabelecimentoLocalId);
            }
            em.remove(productos);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Productos> findProductosEntities() {
        return findProductosEntities(true, -1, -1);
    }

    public List<Productos> findProductosEntities(int maxResults, int firstResult) {
        return findProductosEntities(false, maxResults, firstResult);
    }

    private List<Productos> findProductosEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Productos.class));
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

    public Productos findProductos(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Productos.class, id);
        } finally {
            em.close();
        }
    }

    public int getProductosCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Productos> rt = cq.from(Productos.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
