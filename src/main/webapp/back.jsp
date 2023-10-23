<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.proyecto.clases.Consulta" %>
<%@ page import="com.proyecto.clases.ConexionBD" %>


<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %> <!-- Importa la clase ArrayList -->
<%@ page import="org.json.*" %>





<%
    String idsMarcados = request.getParameter("idsMarcadosInputBorrar");
    String idsMarcadosRev = request.getParameter("idsMarcadosInputRevisar");
    String id = request.getParameter("id");
    String instalacion = request.getParameter("instalacion");
    String ciudad = request.getParameter("ciudad");
    String espacio = request.getParameter("espacio");
    String idsMarcadosPen = request.getParameter("idsMarcadosInputPendiente");
    int espacioNum = 0;
    int idNum = 0;
    int ciudadNum = 0;
    String codigo = request.getParameter("codigo");


    try {
        espacioNum = Integer.parseInt(espacio);
        idNum = Integer.parseInt(id);
        ciudadNum = Integer.parseInt(ciudad);
    } catch (Exception e) {
        // Manejar cualquier excepción que ocurra
        // Puedes mostrar un mensaje de error o tomar otra acción apropiada aquí
    }

%>

<!DOCTYPE html>
<html>
<title>Ciudades Christian</title>
<head>
    <title>Resultado</title>
</head>
<body>

    <style>
        /* Estilos CSS para la barra de navegación */
        ul.navbar {
            list-style-type: none;
            margin: 0;
            padding: 0;
            background-color: #333; /* Color de fondo de la barra de navegación */
            overflow: hidden;
        }

        ul.navbar li {
            float: left;
        }

        ul.navbar li a {
            display: block;
            color: white; /* Color del texto en los enlaces */
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        ul.navbar li a:hover {
            background-color: #555; /* Cambiar el color de fondo al pasar el ratón por encima */
        }
    </style>

        <script>
            // Obtenemos el valor de "codigo" desde la página JSP
            var codigo = <%= codigo %>;

            // Función para mostrar u ocultar los divs en función de "codigo"
            function mostrarDivSegunCodigo() {
                var borrDiv = document.getElementById("borr");
                var reviDiv = document.getElementById("revi");
                var subDiv = document.getElementById("sub");
                var pendDiv = document.getElementById("pend");

                if (codigo === 1) {
                    borrDiv.style.display = "block";
                    reviDiv.style.display = "none";
                    subDiv.style.display = "none";
                    pendDiv.style.display = "none";
                } else if (codigo === 2) {
                    borrDiv.style.display = "none";
                    reviDiv.style.display = "block";
                    subDiv.style.display = "none";
                    pendDiv.style.display = "none";
                } else if (codigo === 3) {
                    borrDiv.style.display = "none";
                    reviDiv.style.display = "none";
                    subDiv.style.display = "block";
                    pendDiv.style.display = "none";
                } else if (codigo === 4) {
                     borrDiv.style.display = "none";
                     reviDiv.style.display = "none";
                     subDiv.style.display = "none";
                     pendDiv.style.display = "block";

                }
            }

            // Llamamos a la función después de cargar la página
            window.onload = mostrarDivSegunCodigo;
        </script>
</head>
<body>
    <ul class="navbar">
        <li><a href="index.jsp">Inicio</a></li>
        <li><a href="mostrarInstalaciones.jsp">Instalaciones</a></li>
        <li><a href="marcarRevisado.jsp">Revisar</a></li>
        <li><a href="borrar.jsp">Borrar</a></li>
        <li><a href="subir.jsp">Subir</a></li>
        <li><a href="pendiente.jsp">Pendiente</a></li>
    </ul>


    <h1>Datos Enviados</h1>
    <p style="display:none">codigo = <%= codigo %></p>
    <div id = "borr">
    <p>IDs Marcados Borrar: <%= idsMarcados %></p>
    </div>
    <div id = "revi">
    <p>IDs Marcados Revisar: <%= idsMarcadosRev %></p>
    </div>
    <div id = "sub">
    <p> id = <%= idNum %></p>
    <p> Instalacion = <%= instalacion %></p>
    <p> Ciudad = <%= ciudadNum %></p>
    <p> Tamaño = <%= espacioNum %></p>
    </div>
    <div id = "pend">
    <p>IDs Marcados Pendiente: <%= idsMarcadosPen %></p>
    </div>

    <%
        if (idsMarcados != null && !idsMarcados.isEmpty()) {
            String[] datos = idsMarcados.split(", ");
            Consulta consulta = new Consulta();
            consulta.consultaBorrar(datos);
        }
    %>

    <%
        if (idsMarcadosRev != null && !idsMarcadosRev.isEmpty()) {
            String[] datos = idsMarcadosRev.split(", ");
            Consulta consulta = new Consulta();
            consulta.consultaRevisar(datos);
        }
    %>
    <%
        if (instalacion != null){
            Consulta consulta = new Consulta();
            consulta.consultaSubir(idNum,ciudadNum,instalacion,espacioNum);
        }

    %>

    <%
        if (idsMarcadosPen != null && !idsMarcadosPen.isEmpty()) {
            String[] datos = idsMarcadosPen.split(", ");
            Consulta consulta = new Consulta();
            consulta.consultaPendiente(datos);
        }
    %>

</body>
</html>