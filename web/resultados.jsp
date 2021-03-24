<%-- 
    Document   : resultados
    Created on : 16/03/2019, 11:38:58
    Author     : APHIED
--%>

<%@page import="java.util.Collection"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="controladoras.ProductosJpaController"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="entidades.Productos"%>
<%@page import="entidades.Estabelecimento"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%
        String producto = (String) request.getAttribute("producto");
        List<Productos> productos = (List) request.getAttribute("productos");
//        List<BigInteger> precos = (List) request.getAttribute("precos");
//        List<String> barcodes = (List) request.getAttribute("barcodes");
    %> 

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Procurar <%=producto%></title>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="css/bootstrap/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/bootstrap/css/bootstrap.min.css">
    </head>

    <body class="bg-light">
        <nav class="navbar navbar-dark bg-dark">
            <div class="col">            
                <span class="navbar-brand mb-0 h1"><a class="navbar-brand" href="index.jsp">Comparador</a></span>
            </div>
            <div class="col-8">
                <form class="form-inline" name="searchForm" action="Search">
                    <input required="required" type="search" class="form-control w-75" placeholder="Producto ou codigo de barras" name="producto">
                    <button id="btnsearch" type="submit" class="btn btn-success">Procurar</button>
                </form>
            </div>
            <div class="col">

            </div>
        </nav>
        <div id="content" class="container mt-3">
            <%if (productos.isEmpty()) {%>
            <div class="jumbotron bg-light">
                <h1 class="display-4"> Opss...! :(</h1>
                <p class="lead">Nao encontramos nenhum producto correspondente a <%=producto%>.</p>
                <hr class="my-4">
                <p>Verifique se o mome do producto ou o codigo de barras esta corecto.</p>
            </div>
            <%} else {%>
            <%
//                Collections.sort(precos);
//                for (int i = 0; i < precos.size(); i++) {
                for (int j = 0; j < productos.size(); j++) {
//                        if (productos.get(j).getPrecoProducto().equals(precos.get(i))) {
%>
            <div class="card m-2">
                <div class="row no-gutters">
                    <div class="col-md-4">
                        <a href="Item.jsp?pid=<%=productos.get(j).getProductoId()%>&ppid=<%=productos.get(j).getCodigoBarras()%>">
                            <img class="card-img" style="max-width: 200px;" src="Imagem?id=<%=productos.get(j).getProductoId()%>">
                        </a>
                    </div>
                    <div class="col-md-8">
                        <div class="card-body row">
                            <div class=" col-6">
                                <a class="text-reset" href="Item.jsp?pid=<%=productos.get(j).getProductoId()%>&ppid=<%=productos.get(j).getCodigoBarras()%>">
                                    <h4 class="card-title text-wrap"><%=productos.get(j).getNomeProducto()%></h4>
                                </a>
                            </div>
                            <div class="col-6">
                                <div>
                                    <p class="small text-muted p-0 m-0">A partir de: </p>
                                    <h3 class="text-success"><%= new DecimalFormat("###,###,###").format(productos.get(j).getPrecoProducto())%>.00 MZN</h3>
                                    <p class="small text-muted">Loja : <Strong><%=productos.get(j).getEstabelecimentoLocalId().getNomeEstabelecimento()%></Strong></p>
                                </div>
                                <div>
                                    <a href="#" class="btn btn-success btn-block">Ver nesta loja</a>
                                    <a href="#" class="btn btn-success btn-block">Comparar Mais Precos</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%}
                }
                // }
//                }%>
        </div>
    </body>
</html>
