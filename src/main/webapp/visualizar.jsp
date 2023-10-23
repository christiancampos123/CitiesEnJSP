<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.proyecto.clases.Consulta" %>
<%@ page import="com.proyecto.clases.ConexionBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>



<html>
<title>Ciudades Christian</title>
<body>
    <h2>Hello World!</h2>
    <h1>Lista de Países</h1>

     <%
         Consulta consulta = new Consulta();

         consulta.consultaPais();

         //PrintWriter p_out = response.getWriter();
         //consulta.imprimirPaises(consulta.getPaises(), p_out);
     %>

    <%
    List<List<Object>> paises = new ArrayList<>();
    paises = consulta.getPaises();
    for (List<Object> pais : paises) {
        int id = (int) pais.get(0);
        String nombre = (String) pais.get(1);
        out.println("<h3>Id: " + id + ", País: " + nombre +"</h3>");
    }
    %>


</body>
</html>