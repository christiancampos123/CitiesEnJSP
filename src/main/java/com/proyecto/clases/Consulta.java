package com.proyecto.clases;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.io.PrintWriter;

public class Consulta implements InterfazGestion {
    private List<List<Object>> paises = new ArrayList<>();
    private List<List<Object>> ciudades = new ArrayList<>();
    private List<List<Object>> instalaciones = new ArrayList<>();

    public List<List<Object>> getPaises() {
        return paises;
    }

    public List<List<Object>> getCiudades() {
        return ciudades;
    }

    public List<List<Object>> getInstalaciones() {
        return instalaciones;
    }

    public void consultaBorrar(String[] datos) {
        for (String dato : datos) {
            InterfazGestion.borrar(Integer.parseInt(dato));
        }
    }

    public void consultaRevisar(String[] datos) {
        for (String dato : datos) {
            InterfazGestion.revisar(Integer.parseInt(dato));
        }
    }

    public void consultaSubir(int id, int ciudad, String instalacion, int espacio) {
        System.out.println(id + " " + instalacion + " " + ciudad + " " + espacio);
        InterfazGestion.subir(id, ciudad, instalacion, espacio);
    }

    public void consultaPendiente(String[] datos) {
        for (String dato : datos) {
            InterfazGestion.pendiente(Integer.parseInt(dato));
        }
    }

    public void consultaPais() {
        Connection conexion = ConexionBD.conectar();
        if (conexion != null) {
            System.out.println("Conectado a la base de datos.");
            try {
                Statement statement = conexion.createStatement();
                String consultaSQL = "SELECT * FROM Países";
                ResultSet resultado = statement.executeQuery(consultaSQL);
                while (resultado.next()) {
                    int columna1 = resultado.getInt("id");
                    String columna2 = resultado.getString("nombre");
                    List<Object> pais = new ArrayList<>();
                    pais.add(columna1);
                    pais.add(columna2);
                    paises.add(pais);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            ConexionBD.desconectar(conexion);

        } else {
            System.err.println("No se pudo establecer la conexión a la base de datos.");
        }

    }

    public void imprimirPaises(List<List<Object>> paises, PrintWriter out) {
        for (List<Object> pais : paises) {
            int id = (int) pais.get(0);
            String nombre = (String) pais.get(1);
            out.println("<h3>Id: " + id + ", País: " + nombre + "</h3>");
        }
    }

    public void imprimirPaises2(List<List<Object>> paises) {
        for (List<Object> pais : paises) {
            int id = (int) pais.get(0);
            String nombre = (String) pais.get(1);
            System.out.println("<h1>Id: " + id + ", País: " + nombre + "<h1>");
        }
    }

    public void imprimirInstalaciones(List<List<Object>> instalaciones) {
        for (List<Object> instalacion : instalaciones) {
            int id = (int) instalacion.get(0);
            int idCiudad = (int) instalacion.get(1);
            String nombre = (String) instalacion.get(2);
            Boolean revisado = (Boolean) instalacion.get(3);
            Boolean borrar = (Boolean) instalacion.get(4);
            int espacio = (int) instalacion.get(5);
            Boolean pendiente = (Boolean) instalacion.get(6);
            System.out.println("<h1>Id: " + id + ", id_ciudad: " + idCiudad + ", nombre: " + nombre + ", revisado: " + revisado + ", borrar: " + borrar + ", tamaño: " + espacio + ", pendiente: " + pendiente + "<h1>");
        }
    }

    public void consultaCiudades() {
        Connection conexion = ConexionBD.conectar();
        if (conexion != null) {
            System.out.println("Conectado a la base de datos.");
            try {
                Statement statement = conexion.createStatement();
                // Realiza una consulta SQL con una unión (JOIN) entre las tablas Ciudades y Países
                String consultaSQL = "SELECT c.id, c.id_país, c.nombre, p.nombre AS nombre_país " + "FROM Ciudades c " + "JOIN Países p ON c.id_país = p.id";
                ResultSet resultado = statement.executeQuery(consultaSQL);
                while (resultado.next()) {
                    int idCiudad = resultado.getInt("id");
                    String nombreCiudad = resultado.getString("nombre");
                    int idPaís = resultado.getInt("id_país");
                    String nombrePaís = resultado.getString("nombre_país");
                    // Ahora puedes trabajar con los datos, como almacenarlos en una lista o imprimirlos
                    List<Object> ciudad = new ArrayList<>();
                    ciudad.add(idCiudad);
                    ciudad.add(nombreCiudad);
                    ciudad.add(idPaís);
                    ciudad.add(nombrePaís);
                    ciudades.add(ciudad);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            ConexionBD.desconectar(conexion);
        } else {
            System.err.println("No se pudo establecer la conexión a la base de datos.");
        }
    }

    public void consultaInstalaciones() {
        // Intenta conectarse a la base de datos
        Connection conexion = ConexionBD.conectar();
        // Comprueba si la conexión es exitosa
        if (conexion != null) {
            System.out.println("Conectado a la base de datos.");
            // Realiza la consulta
            try {
                Statement statement = conexion.createStatement();
                String consultaSQL = "SELECT" + "    I.id AS id_instalacion," + "    I.nombre AS nombre_instalacion," + "    C.nombre AS nombre_ciudad," + "    P.nombre AS nombre_pais," + "    I.revisado," + "    I.borrar," + "    I.tamaño," + "    I.pendiente" + " FROM Instalaciones AS I" + " INNER JOIN Ciudades AS C ON I.id_ciudad = C.id" + " LEFT JOIN Países AS P ON C.id_país = P.id" + " ORDER BY id_instalacion ASC";  // ASC para orden ascendente
                ResultSet resultado = statement.executeQuery(consultaSQL);
                // Itera a través de los resultados y muestra los datos
                while (resultado.next()) {
                    int idInstalacion = resultado.getInt("id_instalacion");
                    String nombreInstalacion = resultado.getString("nombre_instalacion");
                    String nombreCiudad = resultado.getString("nombre_ciudad");
                    String nombrePais = resultado.getString("nombre_pais");
                    boolean revisado = resultado.getBoolean("revisado");
                    boolean borrar = resultado.getBoolean("borrar");
                    int tamano = resultado.getInt("tamaño");
                    boolean pendiente = resultado.getBoolean("pendiente");
                    List<Object> instalacion = new ArrayList<>();
                    instalacion.add(idInstalacion);
                    instalacion.add(nombreInstalacion);
                    instalacion.add(nombreCiudad);
                    instalacion.add(nombrePais);
                    instalacion.add(revisado);
                    instalacion.add(borrar);
                    instalacion.add(tamano);
                    instalacion.add(pendiente);
                    instalaciones.add(instalacion);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            // Cierra la conexión
            ConexionBD.desconectar(conexion);
        } else {
            System.err.println("No se pudo establecer la conexión a la base de datos.");
        }
    }

}