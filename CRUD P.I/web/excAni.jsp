<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remover Animal</title>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="imagens/">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="js/jquery-3.7.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
        <main class="container flex-column align-content-center justify-content-center">
            <%
                //recebe o numero do registro a ser excluido
                int reg;
                reg = Integer.parseInt(request.getParameter("registro"));

                try {
                    //conexão com o BD
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "p@$$w0rd");
                    //Excluindo os dados
                    PreparedStatement st = conecta.prepareStatement("DELETE FROM animal WHERE registro=?");
                    st.setInt(1, reg);

                    //executa o comando DELETE
                    int resultado = st.executeUpdate();

                    //verifica se o animal foi removido
                    if (resultado == 0) {
                        out.print("<p style='color:#212529;font-size:15px'>Animal não encotrado</p>");
                    } else {
                        out.print("<p style='color:#212529;font-size:15px'>O animal com o registro" + reg + " foi removido com sucesso</p>");
                    }

                } catch (Exception erro) {
                    out.print("<p style='color:#212529;font-size:15px'>O seguinte erro foi apresentado:" + erro.getMessage() + " Entre em contato com o suporte</p>");
                }


            %>    
        </main>
    </body>
</html>
