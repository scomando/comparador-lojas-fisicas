<%-- 
    Document   : categoria
    Created on : Jun 28, 2020, 10:23:15 PM
    Author     : Sunil Comando
--%>

<%@page import="java.util.Collections"%>
<%@page import="java.math.BigInteger"%>
<%@page import="entidades.Estabelecimento"%>
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
    <%! List<Productos> P;%>

    <%
        String bar = (String) request.getAttribute("bar");
        List<BigInteger> precos = (List) request.getAttribute("precos");
        List<Productos> productos = (List) request.getAttribute("productos");

        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        ProductosJpaController pc = new ProductosJpaController(emf);
        P = pc.findProductosEntities();

        Collections.sort(precos);
    %> 

    <head>
        <meta charset="utf-8">
        <meta http-equiv="pragma" content="no-cache" />
        <meta http-equiv="cache-control" content="max-age=604800" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Comparador | <%=bar%></title>

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
        </header> <!-- section-header.// -->

        <!-- ========================= SECTION PAGETOP ========================= -->
        <section class="section-pagetop bg border-bottom">
            <div class="container">
                <div class="row">
                    <main class="col-md-12">
                        <%
                            for (BigInteger prc : precos) {
                                for (Productos prd : productos) {
                                    if (prd.getPrecoProducto().equals(prc)) {
                        %>
                        <article class="card card-product-list">
                            <div class="row no-gutters">
                                <aside class="col-md-3">
                                    <a href="#" class="img-wrap">
                                        <span class="badge badge-danger lead p-2">Mais barato</span>
                                        <img src="Imagem?id=<%=prd.getProductoId()%>">
                                    </a>
                                </aside> <!-- col.// -->
                                <div class="col-md-6">
                                    <div class="info-main">
                                        <a href="#" class="h5 title"><%=prd.getNomeProducto()%></a>
                                        <div class="rating-wrap mb-3">
                                            <div class="label-rating"><img width="24px" class="mr-2" src="icons/native/outline_store.png"><%=prd.getEstabelecimentoLocalId().getNomeEstabelecimento()%></div>
                                        </div> <!-- rating-wrap.// -->
                                        <hr>
                                        <h6>Descrição:</h6>
                                        <p><%=prd.getDescricaoProducto()%></p>
                                    </div> <!-- info-main.// -->
                                </div> <!-- col.// -->
                                <aside class="col-sm-3">
                                    <div class="info-aside">
                                        <div class="price-wrap">
                                            <span class="price h3"><%= new DecimalFormat("###,###,###").format(prd.getPrecoProducto())%>.00 MZN</span>	
                                        </div> <!-- info-price-detail // -->
                                        <p class="text-success"><img width="20px" class="mr-1" src="icons/native/outline_location.png"><%=prd.getEstabelecimentoLocalId().getCidadeEstabelecimento()%></p>
                                        <br>
                                        <p>
                                            <a href="loja.jsp?eid=<%=prd.getEstabelecimentoLocalId().getId()%>#<%=prd.getCodigoBarras()%>" class="btn btn-primary btn-block">Ver na loja</a>
                                            <a href="#" class="btn btn-light border-0 btn-block"> 
                                                <span class="text-center text-reset">REF:<%=prd.getCodigoBarras()%></span>
                                            </a>
                                        </p>
                                    </div> <!-- info-aside.// -->
                                </aside> <!-- col.// -->
                            </div> <!-- row.// -->
                        </article> <!-- card-product .// -->
                        <%}
                                }
                                break;
                            }%>
                    </main> <!-- col.// -->
                </div>

            </div> <!-- container //  -->
        </section>
        <!-- ========================= SECTION INTRO END// ========================= -->

        <section class="section-specials padding-y">
            <div class="container">
                <header class="section-heading">
                    <h3 class="section-title">Productos semelhantes</h3>
                </header><!-- sect-heading -->
                <table class="table table-sm bg-white">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Imagem</th>
                            <th scope="col">Codigo de barras</th>
                            <th scope="col">Nome do producto</th>
                            <th scope="col">Loja</th>
                            <th scope="col">Preco</th>
                            <th scope="col">Qnt. Disponivel</th>
                            <th scope="col">Categoria</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (BigInteger prc : precos) {
                                for (Productos prd : productos) {
                                    if (prd.getPrecoProducto().equals(prc)) {
                        %>
                        <tr class="small" >
                            <td><img class="img" style="max-width: 75px;" src="Imagem?id=<%=prd.getId()%>"></td>
                            <td style="vertical-align: middle;"><%=prd.getCodigoBarras()%></td>
                            <td class="text-truncate" style="vertical-align: middle;"><%=prd.getNomeProducto()%></td>
                            <td style="vertical-align: middle;"><%=prd.getEstabelecimentoLocalId().getNomeEstabelecimento()%></td>
                            <td style="vertical-align: middle;"><%= new DecimalFormat("MZN ###,###,###").format(prd.getPrecoProducto())%>.00</td>
                            <td style="vertical-align: middle;"><%=prd.getQuantidadeProducto()%></td>
                            <td style="vertical-align: middle;"><%=prd.getCategoriaLocalId().getDescricaoCategoria()%></td>
                        </tr>
                        <%}
                                }
                            }%>
                    </tbody>
                </table>
            </div> <!-- container.// -->
        </section>

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
