<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Listar Animais</title>
        <!--    <link rel="stylesheet" href="css/tabela.css"> -->
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="imagens/">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="js/jquery-3.7.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>

    <body>
        <main id="listMain" class="container flex-column align-content-center justify-content-center">
            <%
                try {
                    //conexão com o BD
                    Connection conecta;
                    PreparedStatement st;
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "p@$$w0rd");
                    //Listando os dados
                    st = conecta.prepareStatement("SELECT * FROM animal ORDER BY registro");

                    //executa o comando select
                    ResultSet rs = st.executeQuery();
            %>
            <!--Criando uma tabela para mostrar a listagem-->
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-dark text-center align-middle">
                        <tr>
                            <th scope="col">Registro</th>
                            <th scope="col">Nome</th>
                            <th scope="col">Espécie</th>
                            <th scope="col">Raça</th>
                            <th scope="col">Idade (anos)</th>
                            <th scope="col">Peso (Kg)</th>
                            <th scope="col">Data de Registro</th>
                            <th scope="col">Status</th>
                            <th scope="col">Alterar</th>
                            <th scope="col">Remover</th>   
                        </tr>
                    </thead>
                    <%
                        //laço para verificar se há itens na variável rs
                        while (rs.next()) {
                    %>
                    <tbody class="text-center align-middle">    
                        <tr>
                            <td><%=rs.getString("registro")%></td>
                            <td><%=rs.getString("nome")%></td>
                            <td><%=rs.getString("especie")%></td>
                            <td><%=rs.getString("raca")%></td>
                            <td><%=rs.getString("idade")%></td>
                            <td><%=rs.getString("peso")%></td>
                            <td><%=rs.getString("data_registro")%></td>
                            <td><%=rs.getString("status_animal")%></td>
                            <td><a class="alert-link" href="altAni.jsp?registro=<%=rs.getString("registro")%>">Alterar</a></td>
                            <td><a class="alert-link" href="excAni.jsp?registro=<%=rs.getString("registro")%>">Remover</a></td>
                        </tr>
                    <tbody>
                        <%
                            }
                        %>
                </table>
            </div>
            <%
                } catch (Exception x) {
                    out.print("<p style='color:#212529;font-size:15px'>Mensagem de erro:" + x.getMessage() + "</p>");
                }


            %>
        </main>
    </body>
</html>
