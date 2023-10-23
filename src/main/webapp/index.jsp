<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.proyecto.clases.Consulta" %>
<%@ page import="com.proyecto.clases.ConexionBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %> <!-- Importa la clase ArrayList -->



<html>
<title>Ciudades Christian</title>
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
        <style>
            /* Estilo para el encabezado con fondo gris claro */
            .header {
                background-color: lightgrey;
                padding: 10px;
            }
        </style>

    <div class="header">
        <h2>Recuerda que solo puedes dar estos IDs de ciudades cuando des de alta una nueva Instalacion.</h2>
        <p>En caso de no encontrar la ID en la lista, solicita que se dé de alta esa ciudad en la base de datos.</p>
    </div>

     <%
         Consulta consulta = new Consulta();

         consulta.consultaPais();

     %>
         <style>
             /* Estilo para crear dos columnas */
             .container {
                 display: flex;
             }

             .column {
                 flex: 1;
                 padding: 10px;
             }
         </style>

    <div class="container">
        <div class="column">
            <h2>Países Disponibles</h2>
            <%
            List<List<Object>> paises = new ArrayList<>();
            paises = consulta.getPaises();
            for (List<Object> pais : paises) {
                int id = (int) pais.get(0);
                String nombre = (String) pais.get(1);
                out.println("<h3>" + nombre + " | " + id + "</h3>");
            }
            %>
        </div>
    <div class="column">
        <h2>Ciudades Disponibles</h2>
        <input type="text" id="search-box" placeholder="Buscar por nombre o ID" onkeyup="buscarCiudades()">
        <div id="city-list">
            <%
            consulta.consultaCiudades();
            List<List<Object>> ciudades = consulta.getCiudades();

            for (List<Object> ciudad : ciudades) {
                int idC = (int) ciudad.get(0);
                String nombreC = (String) ciudad.get(1);
                int idP = (int) ciudad.get(2);
                String nombreP = (String) ciudad.get(3);

                // Crea elementos HTML para mostrar los datos de la ciudad
                out.println("<p>" + idC + " | " + nombreC + "   ("+ nombreP.substring(0, 3) +")</p>");


            }
            %>
        </div>
    </div>
</div>

        <script>
            function buscarCiudades() {
                var input, filter, ul, li, a, i, txtValue;
                input = document.getElementById('search-box');
                filter = input.value.toUpperCase();
                ul = document.getElementById('city-list');
                li = ul.getElementsByTagName('p');
                for (i = 0; i < li.length; i++) {
                    a = li[i];
                    txtValue = a.textContent || a.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        li[i].style.display = '';
                    } else {
                        li[i].style.display = 'none';
                    }
                }
            }
        </script>


</body>
</html>