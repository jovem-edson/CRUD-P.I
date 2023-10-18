

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Armazenar animais</title>
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

                try {
                    //conexão com o BD
                    Connection conecta;
                    PreparedStatement st;
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "p@$$w0rd");

                    //inserindo os dados
                    st = conecta.prepareStatement("INSERT INTO animal VALUES(?,?,?,?,?,?,?,?)");
                    st.setInt(1, registro);
                    st.setString(2, nome);
                    st.setString(3, especie);
                    st.setString(4, raca);
                    st.setInt(5, idade);
                    st.setFloat(6, peso);
                    st.setDate(7, new java.sql.Date(data_registro.getTime()));
                    st.setString(8, status_animal);

                    //executa o comando INSERT
                    st.executeUpdate();
                    out.print("<p style='color:#212529;font-size:15px'>Animal cadastrado com sucesso</p>");
                } catch (Exception x) {
                    String erro = x.getMessage();
                    if (erro.contains("Duplicate entry")) {
                        out.print("<p style='color:#212529;font-size:15px'>Este produto já está cadastrado</p>");
                    } else {
                        out.print("<p style='color:#212529;font-size:15px'>Mensagem de erro:" + erro + "</p>");
                    }
                }
            %>   
        </main>
    </body>
</html>
