<%-- 
    Document   : index
    Created on : 09/03/2019, 22:56:57
    Author     : APHIED
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
<!DOCTYPE html>
<%! List<Categoria> C;%>
<%! List<Productos> P;%>
<%--<%! List<Productos> PR = new ArrayList<>();%>--%>
<%! List<Estabelecimento> E;%>
<%--<%! List<String> barcodesList = new ArrayList<>();%>--%>

<%
    EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");

    ProductosJpaController pc = new ProductosJpaController(emf);
    CategoriaJpaController cc = new CategoriaJpaController(emf);
    EstabelecimentoJpaController ec = new EstabelecimentoJpaController(emf);
    E = ec.findEstabelecimentoEntities();
    C = cc.findCategoriaEntities();
    P = pc.findProductosEntities();

//    for (int i = 0; i < P.size(); i++) {
//        barcodesList.add(P.get(i).getCodigoBarras());
//    }
//
//    Set<String> set = new HashSet<>(barcodesList);
//    barcodesList.clear();
//    barcodesList.addAll(set);
//
//    for (int j = 0; j < barcodesList.size(); j++) {
//        for (int i = 0; i < P.size(); i++) {
//            if (P.get(i).getCodigoBarras().trim().equalsIgnoreCase(barcodesList.get(j).trim())) {
//                PR.add(P.get(i));
//                break;
//            }
//        }
//    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comparador | Pagina Inicial</title>
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
    <%!List<String> LC;%>
    <%!List<String> LV;%>
    <%//        String cat = new String();
//        HashMap<String, String> todascategorias = new HashMap<>();
//        todascategorias.put("TELECOM", "Telefonia e Comunicação");
//        todascategorias.put("ELECDOM", "Eletrodomésticos");
//        todascategorias.put("ELECTRO", "Electrônicos");
//        todascategorias.put("AUTO", "Automóveis e Motorizadas");
//        todascategorias.put("FERR", "Ferramentas e Peças");
//        todascategorias.put("OFFICE", "Computadores e Material de Escritório");
//        todascategorias.put("ILUMI", "Luzes e Iluminação");
//        todascategorias.put("SECPROT", "Segurança e Proteção");
//        todascategorias.put("VEST", "Vestiario");
//        todascategorias.put("JOI", "Joias e Acessórios");
//        todascategorias.put("BELSAU", "Artigos de Beleza e Saúde");
//        todascategorias.put("MOV", "Móveis");
//        todascategorias.put("TELECOM", "Material de Desporto e Casa");
//        LC = new ArrayList(todascategorias.values());
//        LV = new ArrayList(todascategorias.values());
    %>
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
            <div class="jumbotron jumbotron-fluid">
                <div class="container">
                    <div class="row">
                        <div class="col">
                        </div>
                        <div class="col-10 mt-2 pt-2">
                            <h1 class="display-6 text-reset p-2">Comparador preços de lojas fisicas</h1>
                            <div class="p-2">
                                <p class="text-muted">Compare preços de productos de varios estabelecimentos comerciais.</p>
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
                    <div id="Lojas">
                        <div class="mt-3">
                            <p class="lead">Lojas registradas</p>
                        </div>
                        <div class="card-deck">
                            <div class="owl-carousel owl-theme">
                                <%for (int i = 0; i < E.size(); i++) {%>
                                <div class="card item p-0 m-1" style="max-width: 300px;">
                                    <div class="card-body">
                                        <a class="text-reset" href="estabelecimento.jsp?eid=<%=E.get(i).getId()%>"><h5><u><%=E.get(i).getNomeEstabelecimento()%></u></h5></a>
                                        <p class="card-text p-0 m-0"><%=E.get(i).getTipoEstabelecimento()%></p>
                                        <p class="card-text text-muted p-0 m-0"><%=E.get(i).getCidadeEstabelecimento()%></p>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                        </div>
                    </div>

                    <div id="Productos">
                        <div class="mt-3">
                            <h2>Productos adicionados recentemente</h2>
                        </div>
                        <div class="card-deck">
                            <div class="owl-carousel owl-theme">
                                <%if (!P.isEmpty()) {
                                        for (int i = P.size() - 1; i > 0; i--) {%>
                                <div class="card item p-1 m-1" style="max-width: 300px;">
                                    <img class="img p-3" style="max-width: 300px; max-height: 200px;" src="Imagem?id=<%=P.get(i).getId()%>">
                                    <div class="card-body">
                                        <a href="Item.jsp?pid=<%=P.get(i).getId()%>&ppid=<%=P.get(i).getCodigoBarras()%>">
                                            <div class="col text-muted d-inline-block text-truncate m-0 p-0"><u><%=P.get(i).getNomeProducto()%></u></div>
                                        </a>
                                        <p class="card-text text-success font-weight-bold mb-0 pb-0"><%= new DecimalFormat("###,###,###").format(P.get(i).getPrecoProducto())%>.00 MZN</p>
                                        <p class="font-weight-bold m-0 p-0"><%=P.get(i).getEstabelecimentoLocalId().getNomeEstabelecimento()%></p>
                                    </div>
                                </div>
                                <%}
                                } else {%>
                                <div>
                                    <h3>
                                        <p>Nao tem nenhum producto recente...</p>
                                    </h3>
                                </div>
                                <%}%>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </body>
</html>
