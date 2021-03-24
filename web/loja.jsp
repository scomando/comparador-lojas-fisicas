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
<%! List<Categoria> C;%>
<%! List<Productos> P;%>
<%! List<Estabelecimento> E;%>
<%! List<Estabelecimento> EE = new ArrayList<>();%>


<%
    EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");

    int eid = Integer.parseInt(request.getParameter("eid"));

    ProductosJpaController pc = new ProductosJpaController(emf);
    CategoriaJpaController cc = new CategoriaJpaController(emf);
    EstabelecimentoJpaController ec = new EstabelecimentoJpaController(emf);
    E = ec.findEstabelecimentoEntities();
    Estabelecimento estabelecimento = ec.findEstabelecimento(eid);
    C = cc.findCategoriaEntities();
    P = pc.findProductosEntities();
%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="pragma" content="no-cache" />
        <meta http-equiv="cache-control" content="max-age=604800" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Comparador | <%=estabelecimento.getNomeEstabelecimento()%></title>

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
        </header>

        <!-- ========================= SECTION PAGETOP ========================= -->
        <section class="section-pagetop bg-light">
            <div class="container">
                <h2 class="title-page"><img width="42px" class="mr-2" src="icons/native/outline_store.png"></img><%=estabelecimento.getNomeEstabelecimento()%></h2>
                <p class="card-text p-0 m-0"><img width="18px" class="mr-2" src="icons/native/outline_category.png"><%=estabelecimento.getTipoEstabelecimento()%></p>
                <p class="card-text text-muted p-0 m-0"><img width="18px" class="mr-2" src="icons/native/outline_location.png"><%=estabelecimento.getCidadeEstabelecimento() %></p>
            </div> <!-- container //  -->
        </section>
        <!-- ========================= SECTION INTRO END// ========================= -->

        <!-- ========================= SECTION  ========================= -->
        <section class="section-name  padding-y-sm">
            <div class="container">

                <%for (Categoria c : estabelecimento.getCategoriaList()) {
                        if (!estabelecimento.getCategoriaList().isEmpty() || !c.getProductosList().isEmpty()) {
                %>
                <header class="section-heading">
                    <a href="categoria.jsp?k=<%=c.getCodigoCategoria()%>"class="btn btn-outline-primary float-right">Ver mais</a>
                    <h3 class="section-title"><%=c.getDescricaoCategoria()%></h3>
                </header><!-- sect-heading -->


                <div class="row">
                    <%for (Productos p : estabelecimento.getProductosList()) {
                            if (!estabelecimento.getProductosList().isEmpty() && p.getCategoriaCodigo().equalsIgnoreCase(c.getCodigoCategoria())) {%>
                    <div class="col-md-3">
                        <div id="<%=p.getCodigoBarras()%>" class="card card-product-grid">
                            <a href="Barcode?bar=<%=p.getCodigoBarras()%>" class="img-wrap">
                                <img class="img p-3" style="max-width: 300px; max-height: 200px;" src="Imagem?id=<%=p.getId()%>">
                            </a>
                            <figcaption class="info-wrap">
                                <a href="#" class="title text-truncate"><%=p.getNomeProducto()%></a>
                                <div class="price mt-1"><%= new DecimalFormat("###,###,###").format(p.getPrecoProducto())%>.00 MZN</div> <!-- price-wrap.// -->
                            </figcaption>
                        </div>
                    </div> <!-- col.// -->
                    <%}
                        }%>
                </div> <!-- row.// -->
                <%
                } else if (c.getProductosList().isEmpty()){%>
                <div class="jumbotron bg-light">
                    <h1 class="display-4"> Opss...! :(</h1>
                    <p class="lead">Nao encontramos nenhuma categoria neste estabelecimento comercial.</p>
                    <hr class="my-4">
                    <p>Verifique se o mome do producto ou o codigo de barras esta corecto.</p>
                </div>
                <%}
                    }%>


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