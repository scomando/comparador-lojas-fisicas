<%-- 
    Document   : Item
    Created on : Sep 10, 2019, 11:02:50 PM
    Author     : Sunil
--%>

<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
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
    <%! List<Estabelecimento> EE = new ArrayList<>();%>

    <%
        String ppid = request.getParameter("ppid");
        int pid = Integer.parseInt(request.getParameter("pid"));

        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        ProductosJpaController pc = new ProductosJpaController(emf);
        Productos producto = pc.findProductos(pid);
        P = pc.findProductosEntities();

     
    %> 

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=producto.getNomeProducto()%></title>
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
            <div class="card">
                <div class="row no-gutters">
                    <div class="col-md-4">
                        <img class="card-img" style="max-width: 300px; max-height: 250px;" src="Imagem?id=<%=producto.getId()%>">
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <div>
                                <h4 class="card-title text-wrap"><%=producto.getNomeProducto()%></h4>
                                <div>
                                    <p class="small text-muted p-0 m-0">A partir de: </p>
                                    <h3 class="text-success"><%= new DecimalFormat("###,###,###").format(producto.getPrecoProducto())%>.00 MZN</h3>
                                    <p class="small text-muted">Loja : <Strong><%=producto.getEstabelecimentoLocalId().getNomeEstabelecimento()%></Strong></p>
                                    <span class="small text-muted">Localizacao : <%=producto.getEstabelecimentoLocalId().getCidadeEstabelecimento()%></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <div class="mt-5">
                    <p class="lead">Mais precos de productos parecidos com "<%=producto.getNomeProducto()%>"</p>
                </div>
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
                            for (int i = 0; i < P.size(); i++) {
                                if (P.get(i).getCodigoBarras().equals(producto.getCodigoBarras())) {
                        %>
                        <tr class="small" >
                            <td><img class="img" style="max-width: 75px;" src="Imagem?id=<%=P.get(i).getId()%>"></td>
                            <td style="vertical-align: middle;"><%=P.get(i).getCodigoBarras()%></td>
                            <td style="vertical-align: middle;"><%=P.get(i).getNomeProducto()%></td>
                            <td style="vertical-align: middle;"><%=P.get(i).getEstabelecimentoLocalId().getNomeEstabelecimento()%></td>
                            <td style="vertical-align: middle;"><%= new DecimalFormat("MZN ###,###,###").format(P.get(i).getPrecoProducto())%>.00</td>
                            <td style="vertical-align: middle;"><%=P.get(i).getQuantidadeProducto()%></td>
                            <td style="vertical-align: middle;"><%=P.get(i).getCategoriaLocalId().getDescricaoCategoria()%></td>
                        </tr>
                        <%}
                            }%>
                    </tbody>
                </table>

            </div>
        </div>
    </body>
</html>
