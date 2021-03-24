<%-- 
    Document   : index1
    Created on : Jun 28, 2020, 6:19:27 PM
    Author     : Sunil Comando
--%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.HashSet"%>
<%@page import="controladoras.EstabelecimentoJpaController"%>
<%@page import="entidades.Estabelecimento"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="entidades.Categoria"%>
<%@page import="controladoras.CategoriaJpaController"%>
<%@page import="controladoras.ProductosJpaController"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="entidades.Productos"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<%! List<String> CC;%>
<%! List<Productos> P;%>

<%
    EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
    
    ProductosJpaController pc = new ProductosJpaController(emf);
    CategoriaJpaController cc = new CategoriaJpaController(emf);
    EstabelecimentoJpaController ec = new EstabelecimentoJpaController(emf);
    List<Estabelecimento> E = ec.findEstabelecimentoEntities();
    List<Categoria> C = cc.findCategoriaEntities();
    CC = new ArrayList<>();
    
    for (int i = 0; i < C.size(); i++) {
        CC.add(C.get(i).getCodigoCategoria());
    }
    
    P = pc.findProductosEntities();
%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="pragma" content="no-cache" />
        <meta http-equiv="cache-control" content="max-age=604800" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Comparador | Pagina Inicial</title>

        <link href="icons/boxicons/css/boxicons.min.css" rel="stylesheet">

        <!-- jQuery -->
        <script src="js/jquery-2.0.0.min.js" type="text/javascript"></script>

        <!-- Bootstrap4 files-->
        <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>

        <!-- Font awesome 5 -->
        <link href="fonts/fontawesome/css/all.min.css" type="text/css" rel="stylesheet">

        <!-- custom style -->
        <link href="css/ui.css" rel="stylesheet" type="text/css"/>
        <link href="css/responsive.css" rel="stylesheet" media="only screen and (max-width: 1200px)" />

        <!-- custom javascript -->
        <script src="js/script.js" type="text/javascript"></script>

        <script type="text/javascript">
            /// some script
            
            // jquery ready start
            $(document).ready(function () {
                // jQuery code
                
            });
            // jquery end
        </script>

    </head>
    <body>

        <header class="section-header">

            <section class="header-main border-bottom">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-3 col-4">
                            <a href="index.jsp" class="brand-wrap"><h3>Comparador</h3></a> <!-- brand-wrap.// -->
                        </div>
                        <div class="col-lg-9 col-sm-12">
                            <form action="Search" class="search">
                                <div class="input-group w-100">
                                    <input type="text" name="producto" class="form-control" placeholder="Search">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary" type="submit">
                                            <i class='bx bx-search' ></i>
                                        </button>
                                    </div>
                                </div>
                            </form> <!-- search-wrap .end// -->
                        </div> <!-- col.// -->
                    </div> <!-- row.// -->
                </div> <!-- container.// -->
            </section> <!-- header-main .// -->

            <section class="section-main bg padding-y">
                <div class="container">

                    <div class="row">
                        <aside class="col-md-3">
                            <nav class="card">
                                <div class="card-header text-white bg-primary">Categorias</div>
                                <ul class="menu-category">
                                    <%for (int i = 0; i < 8; i++) {
                                            if (C.get(i).getCodigoEstabelecimento().equalsIgnoreCase("DEMO")) {
                                    %>
                                    <li><a class="text-truncate" href="categoria.jsp?k=<%=C.get(i).getCodigoCategoria()%>"><%=C.get(i).getDescricaoCategoria()%></a></li>
                                        <%}
                                            }%>
                                    <li class="has-submenu"><a href="#">Mais categorias</a>

                                        <ul class="submenu">
                                            <%for (int i = 6; i < C.size(); i++) {
                                                    if (C.get(i).getCodigoEstabelecimento().equalsIgnoreCase("DEMO")) {
                                            %>
                                            <li><a class="text-truncate" href="categoria.jsp?k=<%=C.get(i).getCodigoCategoria()%>"><%=C.get(i).getDescricaoCategoria()%></a></li>
                                                <%}
                                                    }
                                                %>
                                        </ul>
                                    </li>
                                </ul>
                            </nav>
                        </aside> <!-- col.// -->
                        <div class="col-md-9">
                            <article class="banner-wrap">
                                <img src="images/benner.png" class="w-100 rounded">
                            </article>
                        </div> <!-- col.// -->
                    </div> <!-- row.// -->
                </div> <!-- container //  -->
            </section>

            <!-- ========================= SECTION SPECIAL ========================= -->
            <section class="section-specials padding-y">
                <div class="container">	
                    <header class="section-heading">
                        <a href="#" class="btn btn-outline-primary float-right">Ver mais</a>
                        <h3 class="section-title"><img width="32px" class="mr-2" src="icons/native/outline_store.png">Lojas Parceiras</h3>
                    </header><!-- sect-heading -->
                    <div class="row">
                        <%
                            if (!E.isEmpty()) {
                                for (int k = 0;
                                        k < E.size(); k++) {
                                    if (!E.get(k).getCodigoEstabelecimento().equalsIgnoreCase("DEMO")) {%>
                        <div class="col-md-3">
                            <div class="card item p-0 m-1" style="max-width: 300px;">
                                <div class="card-body">
                                    <a class="text-reset" href="loja.jsp?eid=<%=E.get(k).getId()%>"><h5><u><%=E.get(k).getNomeEstabelecimento()%></u></h5></a>
                                    <p class="card-text p-0 m-0"><%=E.get(k).getTipoEstabelecimento()%></p>
                                    <p class="card-text text-muted p-0 m-0"><img width="18px" class="mr-2" src="icons/native/outline_location.png"><%=E.get(k).getCidadeEstabelecimento()%></p>
                                </div>
                            </div>
                        </div>
                        <%}
                                }
                            }%>
                    </div> <!-- row.// -->
                    <hr>
                </div> <!-- container.// -->

            </section>
            <!-- ========================= SECTION SPECIAL END// ========================= -->




            <!-- ========================= SECTION  ========================= -->
            <section class="section-name  padding-y-sm">
                <div class="container">

                    <header class="section-heading">
                        <a href="#" class="btn btn-outline-primary float-right">Ver mais</a>
                        <h3 class="section-title"><img width="32px" class="mr-2" src="icons/native/outline_shopping_cart.png">Productos recentes</h3>
                    </header><!-- sect-heading -->


                    <div class="row">
                        <%if (!P.isEmpty()) {
                                for (int i = 0; i < P.size(); i++) {
                                    if (i > 0 && !P.get(i).equals(P.get(i - 1))) {%>
                        <div class="col-md-3">
                            <div href="#" class="card card-product-grid">

                                <a href="Barcode?bar=<%=P.get(i).getCodigoBarras()%>" class="img-wrap">
                                    <img class="img p-3" style="max-width: 300px; max-height: 200px;" src="Imagem?id=<%=P.get(i).getId()%>">
                                </a>
                                <figcaption class="info-wrap">
                                    <a href="Barcode?bar=<%=P.get(i).getCodigoBarras()%>" class="title text-truncate"><%=P.get(i).getNomeProducto()%></a>
                                    <div class="price mt-1"><%= new DecimalFormat("###,###,###").format(P.get(i).getPrecoProducto())%>.00 MZN</div> <!-- price-wrap.// -->
                                </figcaption>
                            </div>
                        </div> <!-- col.// -->
                        <%}}
                            }else {%>

                        <%}%>
                    </div> <!-- row.// -->

                </div><!-- container // -->
            </section>
            <!-- ========================= SECTION  END// ========================= -->


            <!-- ========================= FOOTER ========================= -->
            <footer class="section-footer">
                <div class="container">
                    <section class="footer-bottom border-top row">
                        <div class="col-md-4">
                            <p class="text-muted"> &copy 2020 Sunil Comando </p>
                        </div>
                        <div class="col-md-8 text-md-center">
                            <span  class="px-2">scomando@unilurio.ac.mz</span>
                            <span  class="px-2">+258 846580604</span>
                            <span  class="px-2">Av. Marginal, Bairro Cariaco, Pemba</span>
                        </div>
                    </section>
                </div><!-- //container -->
            </footer>
            <!-- ========================= FOOTER END // ========================= -->

    </body>
</html>