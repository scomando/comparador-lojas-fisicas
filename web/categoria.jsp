<%-- 
    Document   : categoria
    Created on : Jun 28, 2020, 10:23:15 PM
    Author     : Sunil Comando
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="entidades.Productos"%>
<%@page import="entidades.Categoria"%>
<%@page import="controladoras.CategoriaJpaController"%>
<%@page import="controladoras.ProductosJpaController"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html lang="en">
    <%! List<Categoria> C;%>
    <%! List<Productos> P;%>


    <%
        String k = request.getParameter("k");
        String value = "";
        int contP = 0;

        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        CategoriaJpaController cc = new CategoriaJpaController(emf);
        ProductosJpaController pc = new ProductosJpaController(emf);
        P = pc.findProductosEntities();
        C = cc.findCategoriaEntities();
        Categoria c = new Categoria();

        for (int i = 0; i < C.size(); i++) {
            if (C.get(i).getCodigoCategoria().equals(k)) {
                value = C.get(i).getDescricaoCategoria();
                c = C.get(i);
            }
        }
%>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="pragma" content="no-cache" />
        <meta http-equiv="cache-control" content="max-age=604800" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Comparador | <%=c.getDescricaoCategoria()%></title>

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
    <%!List<Productos> PP;%>
    <%!List<String> LC;%>
    <%!List<String> LV;%>
    <%
        String cat = new String();
        HashMap<String, String> todascategorias = new HashMap<>();
        todascategorias.put("TELECOM", "Telefonia e Comunicação");
        todascategorias.put("ELECDOM", "Eletrodomésticos");
        todascategorias.put("ELECTRO", "Electrônicos");
        todascategorias.put("AUTO", "Automóveis e Motorizadas");
        todascategorias.put("FERR", "Ferramentas e Peças");
        todascategorias.put("OFFICE", "Computadores e Material de Escritório");
        todascategorias.put("ILUMI", "Luzes e Iluminação");
        todascategorias.put("SECPROT", "Segurança e Proteção");
        todascategorias.put("VEST", "Vestiario");
        todascategorias.put("JOI", "Joias e Acessórios");
        todascategorias.put("BELSAU", "Artigos de Beleza e Saúde");
        todascategorias.put("MOV", "Móveis");
        todascategorias.put("TELECOM", "Material de Desporto e Casa");
        LC = new ArrayList(todascategorias.values());
        LV = new ArrayList(todascategorias.values());

        PP = new ArrayList<>();

        for (int j = 0; j < P.size(); j++) {
            if (P.get(j).getCategoriaCodigo().equals(c.getCodigoCategoria())) {
                contP++;
                PP.add(P.get(j));
            }
        }
    %>

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
        </header> <!-- section-header.// -->



        <!-- ========================= SECTION PAGETOP ========================= -->
        <section class="section-pagetop bg">
            <div class="container">
                <h2 class="title-page"><%=c.getDescricaoCategoria()%></h2>
            </div> <!-- container //  -->
        </section>
        <!-- ========================= SECTION INTRO END// ========================= -->

        <!-- ========================= SECTION CONTENT ========================= -->
        <section class="section-content padding-y">
            <div class="container">

                <div class="row">
                    <main class="col-md-10">
                        <header class="border-bottom mb-4 pb-3">
                            <div class="form-inline">
                                <span class="mr-md-auto"><%=PP.size()%> productos</span>
                            </div>
                        </header><!-- sect-heading -->
                        <%
                            if (!PP.isEmpty()) {
                        %>

                        <div class="row">
                            <%
                                for (Productos i : PP) {
                            %>
                            <div class="col-md-4">
                                <figure class="card card-product-grid">
                                    <div class="img-wrap"> 
                                        <img class="p-2" src="Imagem?id=<%=i.getId()%>">
                                    </div> <!-- img-wrap.// -->
                                    <figcaption class="info-wrap">
                                        <div class="fix-height">
                                            <a href="Barcode?bar=<%=i.getCodigoBarras()%>" class="title text-truncate"><%=i.getNomeProducto()%></a>
                                            <div class="price-wrap mt-2">
                                                <span class="price"><%= new DecimalFormat("###,###,###").format(i.getPrecoProducto())%>.00 MZN</span>
                                                <span class="price-old">EAN/UPC:<%=i.getCodigoBarras()%></span>
                                            </div> <!-- price-wrap.// -->
                                        </div>
                                        <a href="Barcode?bar=<%=i.getCodigoBarras()%>" class="btn btn-block btn-primary">Comparar</a>
                                    </figcaption>
                                </figure>
                            </div> <!-- col.// -->
                            <%}%>
                        </div>

                        <%} else {%>
                        <div class="jumbotron bg-light">
                            <h1 class="display-4"> Opss...! :(</h1>
                            <p class="lead">Ainda nao tem productos na categoria de "<%=c.getDescricaoCategoria()%>".</p>
                            <hr class="my-4">
                            <p>Verifique se o mome do producto ou o codigo de barras esta corecto.</p>
                        </div>
                        <%}%>
                    </main> <!-- col.// -->

                </div>

            </div> <!-- container .//  -->
        </section>
        <!-- ========================= SECTION CONTENT END// ========================= -->

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
