<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.proyecto.clases.Consulta" %>
<%@ page import="com.proyecto.clases.ConexionBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>



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
                background-color: #555;
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
    <h1>Lista de Instalaciones</h1>

     <%
         Consulta consulta = new Consulta();

         consulta.consultaInstalaciones();

     %>
<style>

th,
td {
    padding-right: 60px;
}

</style>

<table class="instalaciones-table">
    <tr>
        <th><input type="text" id="filtroID" placeholder="ID"></th>
        <th class="narrow-column"><input type="text" id="filtroInstalacion" placeholder="Instalacion"></th>
        <th><input type="text" id="filtroCiudad" placeholder="Ciudad"></th>
        <th><input type="text" id="filtroPais" placeholder="País"></th>
        <th>Revisado</th>
        <th>Borrar</th>
        <th>Tamaño</th>
        <th>Pendiente</th>
    </tr>
    <%
    List<List<Object>> instalaciones = new ArrayList<>();
    instalaciones = consulta.getInstalaciones();
    for (List<Object> unaInstalacion : instalaciones) { // Cambié el nombre de la variable aquí
        int id = (int) unaInstalacion.get(0);
        String nombreInstalacion = (String) unaInstalacion.get(1); // Cambié el nombre de la variable aquí
        String ciudad = (String) unaInstalacion.get(2);
        String pais = (String) unaInstalacion.get(3);
        Boolean revisado = (Boolean) unaInstalacion.get(4);
        Boolean borrar = (Boolean) unaInstalacion.get(5);
        int espacio = (int) unaInstalacion.get(6);
        Boolean pendiente = (Boolean) unaInstalacion.get(7);
    %>
    <tr>
        <td><%= id %></td>
        <td><%= nombreInstalacion %></td> <!-- Cambié el nombre de la variable aquí -->
        <td><%= ciudad %></td>
        <td><%= pais %></td>
        <td><%= revisado %></td>
        <td><%= borrar %></td>
        <td><%= espacio %></td>
        <td><%= pendiente %></td>
    </tr>
    <%
    }
    %>
</table>

<script>
    // Obtener el campo de entrada y la tabla
    const filtroPais = document.getElementById('filtroPais');
    const filtroCiudad = document.getElementById('filtroCiudad');
    const filtroInstalacion = document.getElementById('filtroInstalacion');
    const filtroID = document.getElementById('filtroID');
    const tabla = document.querySelector('.instalaciones-table');

    // Función para aplicar el filtro
    function aplicarFiltro() {
          // Convertir el filtro a minúsculas
          const filtroP = filtroPais.value.toLowerCase();
          const filtroC = filtroCiudad.value.toLowerCase();
          const filtroI = filtroInstalacion.value.toLowerCase();
          const filtroNumID = parseInt(filtroID.value); // Parsear el valor del filtro ID a un número entero

          // Iterar a través de las filas de la tabla (a partir de la segunda fila)
          const filas = tabla.querySelectorAll('tr');
          for (let i = 1; i < filas.length; i++) {
                const fila = filas[i];
                const pais = fila.querySelector('td:nth-child(4)').textContent.toLowerCase();
                const ciudad = fila.querySelector('td:nth-child(3)').textContent.toLowerCase();
                const instalacion = fila.querySelector('td:nth-child(2)').textContent.toLowerCase();
                const id = parseInt(fila.querySelector('td:nth-child(1)').textContent); // Parsear el valor del ID a un número entero

                // Comprobar filtros
                if (pais.includes(filtroP) && ciudad.includes(filtroC) && instalacion.includes(filtroI) && (!isNaN(filtroNumID) ? id === filtroNumID : true)) {
                     fila.style.display = ''; // Mostrar la fila si coincide
                } else {
                    fila.style.display = 'none'; // Ocultar la fila si no coincide
                }
          }
    }

    // Agregar un evento input al campo de entrada para llamar a la función de filtro
    filtroPais.addEventListener('input', aplicarFiltro);
    filtroCiudad.addEventListener('input', aplicarFiltro);
    filtroInstalacion.addEventListener('input', aplicarFiltro);
    filtroID.addEventListener('input', aplicarFiltro);

    // Aplicar el filtro inicialmente al cargar la página
    aplicarFiltro();
</script>

</body>
</html>