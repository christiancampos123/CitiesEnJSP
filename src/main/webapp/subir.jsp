<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.proyecto.clases.Consulta" %>
<%@ page import="com.proyecto.clases.ConexionBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %> <!-- Importa la clase ArrayList -->





<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
        <h2>Recuerda que solo puedes usar los ids de ciudad que hay en INICIO.</h2>
        <p>En caso de no encontrar la ID en la lista, solicita que se dé de alta esa ciudad en la base de datos.</p>
    </div>

<h1>Subir una instalacion</h1>
  <div id="messageLayer">
    Recuerda que debes poner la ID de la ciudad que encontrarás <a href="index.jsp">aquí</a>.
  </div>
    <style>
      /* Estilo para la capa de mensaje */
      #messageLayer {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: #ffffff;
        padding: 20px;
        border: 1px solid #ccc;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        z-index: 9999;
      }
    </style>
<br>

<form id="myFormSubir" action="back.jsp" method="post">
    <!-- Campos de entrada -->
    <input type="text" id="id" name="id" placeholder="id">
    <input type="text" id="ciudad" name="ciudad" placeholder="id_ciudad">
    <i id = "iconButton" class="fa fa-info-circle" aria-hidden="true" title="Click para mas informacion"></i>
    <input type="text" id="instalacion" name="instalacion" placeholder="instalacion">
    <input type="text" id="espacio" name="espacio" placeholder="tamaño en MB">
    <input type="hidden" id="codigo" name="codigo" value="3">


    <!-- Botón para enviar el formulario -->
    <button type="submit">Enviar al servidor</button>
</form>

  <script>
    // Obtén una referencia al botón de ícono y la capa de mensaje
    var iconButton = document.getElementById("iconButton");
    var messageLayer = document.getElementById("messageLayer");

    // Agrega un controlador de eventos de clic al botón
    iconButton.addEventListener("click", function() {
      messageLayer.style.display = "block"; // Muestra la capa de mensaje
    });

      // Agrega un controlador de eventos de clic al documento
      document.addEventListener("click", function(event) {
        if (event.target !== messageLayer && event.target !== iconButton) {
          // Si se hizo clic fuera de la capa de mensaje y del botón, oculta la capa de mensaje
          messageLayer.style.display = "none";
        }
      });
  </script>

<script>
document.getElementById("myFormSubir").addEventListener("submit", function(event) {
    event.preventDefault(); // Evita el envío predeterminado del formulario

    // Obtiene todos los campos de entrada dentro del formulario
    var inputs = this.querySelectorAll("input[name]");

    // Crea un array para almacenar los valores de los campos de entrada
    var values = [];

    // Recorre los campos de entrada y agrega sus valores al array
    inputs.forEach(function(input) {
        values.push(input.value);
    });

    // Crea una cadena separada por comas a partir del array de valores
    var formData = values.join(",");

    // Agrega un campo de entrada oculto al formulario con la cadena generada
    var hiddenInput = document.createElement("input");
    hiddenInput.type = "hidden";
    hiddenInput.name = "formData";
    hiddenInput.value = formData;
    this.appendChild(hiddenInput);

    // Envía el formulario
    this.submit();
});
</script>

</body>
</html>