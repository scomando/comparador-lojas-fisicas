/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controladoras.EstabelecimentoJpaController;
import controladoras.ProductosJpaController;
import entidades.Estabelecimento;
import entidades.Productos;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeMap;
import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author APHIED
 */
public class Search extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");

            ProductosJpaController pc = new ProductosJpaController(emf);
            EstabelecimentoJpaController ec = new EstabelecimentoJpaController(emf);

            List<Productos> P;
            List<Productos> PR = new ArrayList<>();
            List<Estabelecimento> E = new ArrayList<>();
//            List<String> barcodesList = new ArrayList<>();
//            List<BigInteger> priceList = new ArrayList<>();

            P = pc.findProductosEntities();
            String producto = request.getParameter("producto");

//Encontrar os estabelecimentos que contem o producto pesquisado
            for (int i = 0; i < P.size(); i++) {
                if (!producto.equals("")) {
                    if (P.get(i).getCodigoBarras().trim().contains(producto.trim()) || P.get(i).getNomeProducto().trim().toLowerCase().contains(producto.trim().toLowerCase())) {
                        PR.add(P.get(i));
//                        barcodesList.add(P.get(i).getCodigoBarras());
//                        priceList.add(P.get(i).getPrecoProducto());
                    }
                }
            }


//            request.setAttribute("barcodes", barcodesList);
//            request.setAttribute("precos", priceList);
            request.setAttribute("productos", PR);
            request.setAttribute("producto", producto);
            request.getRequestDispatcher("busca.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
