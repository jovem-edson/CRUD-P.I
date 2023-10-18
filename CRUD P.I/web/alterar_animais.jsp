<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Animais</title>
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
                //receber dados
                int registro;
                String nome;
                String especie;
                String raca;
                int idade;
                float peso;
                String data_; //mudar para string se der erro
                String status_animal;

                registro = Integer.parseInt(request.getParameter("Registro"));
                nome = request.getParameter("Nome");
                especie = request.getParameter("Especie");
                raca = request.getParameter("Raca");
                idade = Integer.parseInt(request.getParameter("Idade"));
                peso = Float.parseFloat(request.getParameter("Peso"));

                //aplicar este código após mudar para String
                data_ = request.getParameter("Data"); // Recupere a data do formulário
                SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
                Date data_registro = formato.parse(data_);

                status_animal = request.getParameter("Status");

                //conexão com o BD
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "p@$$w0rd");

                //alterar os dados no BD
                st = conecta.prepareStatement("UPDATE animal SET nome=?, especie=?, raca=?, idade=?, peso=?, status_animal=? WHERE registro = ?");
                st.setString(1, nome);
                st.setString(2, especie);
                st.setString(3, raca);
                st.setInt(4, idade);
                st.setFloat(5, peso);
                st.setString(6, status_animal);
                st.setInt(7, registro);

                //executa o comando UPDATE
                st.executeUpdate();
                out.print("<p style='color:#212529;font-size:15px'>Os dados do animal de registro " + registro + " foram alterados</p>");

            %>
        </main>
    </body>
</html>
