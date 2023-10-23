package com.proyecto.clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    private static final String URL = "jdbc:mysql://192.168.1.234:3306/cities";
    private static final String USUARIO = "christian";
    private static final String CONTRASENA = "a";

    public static Connection conectar() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conexion = DriverManager.getConnection(URL, USUARIO, CONTRASENA);
            return conexion;
        } catch (ClassNotFoundException e) {
            System.err.println("Error: No se pudo cargar el controlador de MySQL.");
        } catch (SQLException e) {
            System.err.println("Error: No se pudo conectar a la base de datos. Verifica la IP, usuario y contraseña.");
        }

        return null;
    }

    public static void desconectar(Connection conexion) {
        try {
            if (conexion != null) {
                conexion.close();
                System.out.println("Conexión cerrada.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
