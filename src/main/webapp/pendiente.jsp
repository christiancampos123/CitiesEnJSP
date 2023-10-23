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
    <h1>Aceptar Instalaciones</h1>

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
        <th>Aceptar Instalacion<th>
    </tr>
    <%
    List<List<Object>> instalaciones = new ArrayList<>();
    instalaciones = consulta.getInstalaciones();
    for (List<Object> unaInstalacion : instalaciones) {
        int id = (int) unaInstalacion.get(0);
        String nombreInstalacion = (String) unaInstalacion.get(1);
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
        <td><input type="checkbox" name="miCheckbox" value="<%= id %>" data-pendiente="<%= !pendiente %>"></td>
    </tr>
    <%
    }
    %>
</table>

    <!--<button id="btnObtenerIDs">Obtener IDs Marcados</button>-->

<script>
var checkboxes = document.querySelectorAll('input[type="checkbox"]');

// Agrega un evento de cambio a cada checkbox
checkboxes.forEach(function (checkbox) {
    checkbox.addEventListener('change', function () {
        var idsMarcados = [];

        checkboxes.forEach(function (cb) {
            if (cb.checked) {
                idsMarcados.push(cb.value);
            }
        });

        // Actualiza el contenido de 'idsMarcados'
        document.getElementById('idsMarcados').innerHTML = idsMarcados.join(', ');

        // Llena el campo de entrada oculto con la cadena generada
        document.getElementById('idsMarcadosInput').value = idsMarcados.join(', ');
    });
});
</script>

<!-- Agregar un formulario para enviar los datos al servidor -->
<form id="myFormPendiente" action="back.jsp" method="post">
    <!-- Campo de entrada oculto para enviar la cadena generada -->
    <input type="hidden" id="idsMarcadosInput" name="idsMarcadosInputPendiente">
    <input type="hidden" id="codigo" name="codigo" value="4">
    <button type="submit">Enviar al servidor</button>
</form>




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


          const filas = tabla.querySelectorAll('tr');
          for (let i = 1; i < filas.length; i++) {
                const fila = filas[i];
                const pais = fila.querySelector('td:nth-child(4)').textContent.toLowerCase();
                const ciudad = fila.querySelector('td:nth-child(3)').textContent.toLowerCase();
                const instalacion = fila.querySelector('td:nth-child(2)').textContent.toLowerCase();
                const id = parseInt(fila.querySelector('td:nth-child(1)').textContent); // Parsear el valor del ID a un número entero
                const pend = fila.querySelector('td:nth-child(8)').textContent.toLowerCase();
                // Comprobar filtros
                if (pais.includes(filtroP) && ciudad.includes(filtroC) && instalacion.includes(filtroI) && (!isNaN(filtroNumID) ? id === filtroNumID : true) && pend == "true" ) {
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

<script>
document.addEventListener("DOMContentLoaded", function() {
    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    var espacioDiv = document.getElementById('espacio');
    var resultado = 0;

    checkboxes.forEach(function(checkbox) {
        checkbox.addEventListener("change", function() {
            var espacioValue = parseInt(checkbox.parentNode.parentNode.querySelector("td:nth-child(7)").textContent);
            //var isPendiente = checkbox.getAttribute("data-pendiente") === "false";


            if (checkbox.checked) {
                resultado += espacioValue;
            } else {
                resultado -= espacioValue;
            }

            espacioDiv.textContent = "Resultado: " + resultado;
        });
    });
});
</script>

<div id="idsMarcados"></div>
<div id = "espacio"></div>


</body>
</html>