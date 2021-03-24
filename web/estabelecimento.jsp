<%-- 
    Document   : categoria
    Created on : Mar 3, 2020, 5:31:17 PM
    Author     : Sunil Comando
--%>

<%@page import="controladoras.CategoriaJpaController"%>
<%@page import="entidades.Categoria"%>
<%@page import="controladoras.EstabelecimentoJpaController"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jdk.nashorn.internal.runtime.arrays.ArrayLikeIterator"%>
<%@page import="entidades.Estabelecimento"%>
<%@page import="java.util.List"%>
<%@page import="entidades.Productos"%>
<%@page import="controladoras.ProductosJpaController"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%! List<Productos> P;%>
    <%! List<Estabelecimento> E;%>
    <%! List<Categoria> C;%>
    <%! List<Estabelecimento> EE = new ArrayList<>();%>

    <%
        int eid = Integer.parseInt(request.getParameter("eid"));

        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        EstabelecimentoJpaController ec = new EstabelecimentoJpaController(emf);
        E = ec.findEstabelecimentoEntities();
        Estabelecimento estabelecimento = ec.findEstabelecimento(eid);
        ProductosJpaController pc = new ProductosJpaController(emf);
        P = pc.findProductosEntities();
        CategoriaJpaController cc = new CategoriaJpaController(emf);
        C = cc.findCategoriaEntities();
    %> 

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=estabelecimento.getNomeEstabelecimento()%></title>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="css/bootstrap/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/bootstrap/css/bootstrap.min.css">
        <!-- Owl Stylesheets -->
        <link rel="stylesheet" href="https://owlcarousel2.github.io/OwlCarousel2/assets/owlcarousel/assets/owl.carousel.min.css">
        <link rel="stylesheet" href="https://owlcarousel2.github.io/OwlCarousel2/assets/owlcarousel/assets/owl.theme.default.min.css">
        <!-- javascript -->
        <script src="https://owlcarousel2.github.io/OwlCarousel2/assets/vendors/jquery.min.js"></script>
        <script src="https://owlcarousel2.github.io/OwlCarousel2/assets/owlcarousel/owl.carousel.js"></script>
    </head>
    <script>
        $(document).ready(function () {
            $('.owl-carousel').owlCarousel({
                loop: false,
                nav: true,
                responsive: {
                    0: {
                        items: 1
                    },
                    600: {
                        items: 3
                    },
                    1000: {
                        items: 5
                    }
                }
            });
        });

    </script>

    <body class="bg-light">
        <nav class="navbar navbar-dark bg-dark">
            <div class="col">            
                <span class="navbar-brand mb-0 h1"><a class="navbar-brand" href="index.jsp">Comparador</a></span>
            </div>
            <div class="col-8">
            </div>
            <div class="col">
            </div>
        </nav>
        <div id="content">
            <div class="jumbotron jumbotron-fluid mb-0">
                <div class="container">
                    <div class="row">
                        <div class="col">
                        </div>
                        <div class="col-10 mt-2 pt-2">
                            <h1 class="display-6 text-reset p-2"><%=estabelecimento.getNomeEstabelecimento()%> - <%=estabelecimento.getCidadeEstabelecimento()%></h1>
                            <div class="p-2">
                                <p class="text-muted">Pesquise productos na <%=estabelecimento.getNomeEstabelecimento()%> e compare com precos de outras lojas.</p>
                            </div>
                            <div id="search">
                                <form name="searchForm" action="Search">
                                    <div class="row">
                                        <div class="col-9">
                                            <input required="required" type="search" class="form-control form-control-lg" placeholder="Producto ou codigo de barras" name="producto">
                                        </div>
                                        <div class="col-3">
                                            <button id="btnsearch" type="submit" class="btn btn-lg btn-success">Procurar</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="col">
                        </div>
                    </div>
                </div>
            </div>
            <div class="bg-light">
                <div class="container">
                    <div id="Categorias" class="p-3 mt-0">
                    <%if (!estabelecimento.getCategoriaList().isEmpty()) {%>
                    <%for (int j = 0; j < estabelecimento.getCategoriaList().size(); j++) {%>
                    <div class="mt-5">
                        <p class="lead"><%=estabelecimento.getCategoriaList().get(j).getDescricaoCategoria()%></p>
                    </div>
                    <div id="productos">
                        <div class="owl-carousel owl-theme">
                            <%for (int i = 0; i < estabelecimento.getProductosList().size(); i++) {%>
                            <%if (!estabelecimento.getProductosList().isEmpty() && estabelecimento.getProductosList().get(i).getCategoriaCodigo().equalsIgnoreCase(estabelecimento.getCategoriaList().get(j).getCodigoCategoria())) {%>
                            <div class="card item p-1 m-1" style="max-width: 300px;">
                                <img class="img p-3" style="max-width: 300px; max-height: 200px;" src="Imagem?id=<%=estabelecimento.getProductosList().get(i).getId()%>">
                                <div class="card-body">
                                    <a href="Item.jsp?pid=<%=estabelecimento.getProductosList().get(i).getId()%>&ppid=<%=estabelecimento.getProductosList().get(i).getCodigoBarras()%>">
                                        <div class="col text-muted d-inline-block text-truncate m-0 p-0"><u><%=estabelecimento.getProductosList().get(i).getNomeProducto()%></u></div>
                                    </a>
                                    <p class="card-text text-success font-weight-bold mb-0 pb-0"><%= new DecimalFormat("###,###,###").format(estabelecimento.getProductosList().get(i).getPrecoProducto())%>.00 MZN</p>
                                </div>
                            </div>
                            <%}%>
                            <%}%>
                        </div>
                    </div>
                    <%}%>
                    <%}%>
                </div>
                </div>

            </div>
        </div>
    </div>

</body>
</html>
