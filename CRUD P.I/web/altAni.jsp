<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <link rel="stylesheet" href="imagens/">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="js/jquery-3.7.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Animais</title>
    </head>
    <body>
        <main class="container flex-column align-content-center justify-content-center">
            <%
                //recebe o número do registro a ser alterado
                int registro;
                registro = Integer.parseInt(request.getParameter("registro"));
                //conexão com o BD
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "p@$$w0rd");
                //Selecionando os dados
                st = conecta.prepareStatement("SELECT * FROM animal WHERE registro = ?");
                st.setInt(1, registro);
                //executa o comando select
                ResultSet resultado = st.executeQuery();
                //verifica se o registro foi encontrado
                if (!resultado.next()) {
                    out.print("<p style='color:#212529;font-size:15px'>Registro não encotrado!</p>");
                } else {
            %>
            <form method="post" action="alterar_animais.jsp">
                <div class="mb-3 mt-5">
                    <label for="reg">Registro:*</label>
                    <input id="reg" type="number" name="Registro" value="<%= resultado.getString("registro")%>" class="form-control" min="1" readonly required>
                </div>
                <div class="mb-3">
                    <label for="nom">Nome do animal:*</label>
                    <input id="nom" type="text" name="Nome" size="35" maxlength="35" value="<%= resultado.getString("nome")%>" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="esp">Espécie:*</label>
                    <input id="esp" type="text" size="35" maxlength="35" name="Especie" value="<%= resultado.getString("especie")%>" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="rac">Raça:*</label>
                    <input id="rac" type="text" size="40" maxlength="40" name="Raca" value="<%= resultado.getString("raca")%>" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="ida">Idade (em anos):</label>
                    <input id="ida" type="number" name="Idade" value="<%= resultado.getString("idade")%>" min="1" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="pes">Peso (em Kg):*</label>
                    <input id="pes" type="number" step="0.01" name="Peso" value="<%= resultado.getString("peso")%>" min="0.1" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="dat">Data de registro:*</label>
                    <input id="dat" type="date" name="Data" value="<%= resultado.getString("data_registro")%>" class="form-control" readonly required>
                </div>
                <div class="mb-3">
                    <label for="stt">Status:*</label>
                    <input id="stt" type="text" size="50" maxlength="50" name="Status" value="<%= resultado.getString("status_animal")%>" class="form-control" required>
                </div>

                <div class="mb-5">
                    <button type="submit" class="btn btn-dark">Salvar Alterações</button>
                </div>
            </form>

            <%
                }
            %>

        </main>
    </body>
</html>
