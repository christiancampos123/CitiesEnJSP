package com.proyecto.clases;

import io.minio.errors.*;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;



public interface InterfazGestion {

    public static void subir(int id, int idCiudad, String nombre, int espacio) {
        Connection conexion = ConexionBD.conectar();

        if (conexion != null) {
            System.out.println("Conectado a la base de datos desde Interfaz.");

            try {
                // Preparar una consulta parametrizada para insertar una nueva fila
                String consultaSQL = "INSERT INTO Instalaciones (id, id_ciudad, nombre, revisado, borrar, tamaño, pendiente) VALUES (?, ?, ?, false, false, ?, true)";
                PreparedStatement preparedStatement = conexion.prepareStatement(consultaSQL);
                preparedStatement.setInt(1, id);
                preparedStatement.setInt(2, idCiudad);
                preparedStatement.setString(3, nombre);
                preparedStatement.setInt(4, espacio);

                // Ejecutar la consulta de inserción
                int filasInsertadas = preparedStatement.executeUpdate();

                if (filasInsertadas > 0) {
                    System.out.println("Se ha creado correctamente");
                    crearTXT(id,idCiudad,nombre,espacio);

                } else {
                    System.out.println("No se ha creado correctamente");

                }

                // Cerrar recursos
                preparedStatement.close();
            } catch (SQLException e) {
                System.out.println("error");
                e.printStackTrace();
            }

            ConexionBD.desconectar(conexion);

        } else {
            System.err.println("No se pudo establecer la conexión a la base de datos.");
        }
    }

    public static void crearTXT(int id, int idCiudad, String nombre, int espacio) {
        try {
            // Obtener la ubicación del escritorio del usuario
            String escritorio = System.getProperty("user.home") + File.separator + "Desktop";

            // Crear la carpeta "datos" en el escritorio si no existe
            File carpetaDatos = new File(escritorio, "datos");
            carpetaDatos.mkdir();

            // Nombre del archivo
            String nombreArchivo = nombre + ".txt";

            // Crear la ruta completa del archivo
            String rutaCompleta = carpetaDatos.getAbsolutePath() + File.separator + nombreArchivo;

            // Crear un objeto FileWriter para escribir en el archivo CSV en la carpeta "datos"
            FileWriter writer = new FileWriter(rutaCompleta, true);

            // Escribir los datos en el archivo CSV
            writer.append(Integer.toString(id));
            writer.append(",");
            writer.append(Integer.toString(idCiudad));
            writer.append(",");
            writer.append(nombre);
            writer.append(",");
            writer.append(Integer.toString(espacio));
            writer.append("\n");

            // Cerrar el FileWriter
            writer.close();


            System.out.println("Datos escritos en el archivo CSV en la carpeta 'datos' en el escritorio: " + nombre + ".txt");


            //subir a minio

            try {
                Minio.subirArchivoAMinio(nombreArchivo,rutaCompleta);

            } catch (IOException | ServerException | InsufficientDataException | ErrorResponseException |
                 NoSuchAlgorithmException | InvalidKeyException | InvalidResponseException |
                 XmlParserException | InternalException e){
                System.out.println("No se ha podido subir correctamente");
            }

        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Error al escribir en el archivo txt.");
        }


    }

    public static void borrar(int id){
        //TODO borrar del escritorio


        Connection conexion = ConexionBD.conectar();

        if (conexion != null) {
            System.out.println("Conectado a la base de datos desde Interfaz.");

            try {
                // Preparar una consulta parametrizada para eliminar la fila con la ID proporcionada
                String consultaSQL = "UPDATE Instalaciones SET borrar = true WHERE id = ?";
                PreparedStatement preparedStatement = conexion.prepareStatement(consultaSQL);
                preparedStatement.setInt(1, id);

                // Ejecutar la consulta de eliminación
                int filasEliminadas = preparedStatement.executeUpdate();

                if (filasEliminadas > 0) {
                    System.out.println("Se ha eliminado la fila con ID " + id + " de la base de datos.");
                    //llamar minio pasando nombre
                    Minio.borrarArchivoDeMinio(obtenerNombre(id) + ".txt");
                    borrarArchivoDeEscritorio(obtenerNombre(id) + ".txt");


                } else {
                    System.out.println("No se encontró una fila con ID " + id + " en la base de datos.");
                }

                // Cerrar recursos
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            ConexionBD.desconectar(conexion);

        } else {
            System.err.println("No se pudo establecer la conexión a la base de datos.");
        }

    }

    public static String obtenerNombre(int id) {
        Connection conexion = ConexionBD.conectar();
        String nombre = null;

        if (conexion != null) {
            System.out.println("Conectado a la base de datos desde Interfaz.");

            try {
                // Preparar una consulta parametrizada para obtener el nombre
                String consultaSQL = "SELECT nombre FROM Instalaciones WHERE id = ?";
                PreparedStatement preparedStatement = conexion.prepareStatement(consultaSQL);
                preparedStatement.setInt(1, id);

                // Ejecutar la consulta y obtener el resultado
                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    nombre = resultSet.getString("nombre");
                    System.out.println("Nombre obtenido: " + nombre);
                } else {
                    System.out.println("No se encontró una fila con ID " + id + " en la base de datos.");
                }

                // Cerrar recursos
                resultSet.close();
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            ConexionBD.desconectar(conexion);

        } else {
            System.err.println("No se pudo establecer la conexión a la base de datos.");
        }

        return nombre;
    }

    public static void borrarArchivoDeEscritorio(String nombre){
        // Obtenemos el directorio del escritorio del usuario
        String directorioEscritorio = System.getProperty("user.home") + File.separator + "Desktop\\datos";

        // Creamos un objeto File con la ruta completa del archivo a borrar
        File archivoABorrar = new File(directorioEscritorio, nombre);

        // Verificamos si el archivo existe antes de intentar borrarlo
        if (archivoABorrar.exists()) {
            boolean exitoBorrado = archivoABorrar.delete();

            if (exitoBorrado) {
                System.out.println("El archivo " + nombre + " ha sido borrado con éxito.");
            } else {
                System.out.println("No se pudo borrar el archivo " + nombre);
            }
        } else {
            System.out.println("El archivo " + nombre + " no existe en el escritorio.");
        }
    }

    public static void revisar(int id){

        Connection conexion = ConexionBD.conectar();

        if (conexion != null) {
            System.out.println("Conectado a la base de datos desde Interfaz.");

            try {
                // Preparar una consulta parametrizada para eliminar la fila con la ID proporcionada
                String consultaSQL = "UPDATE Instalaciones SET revisado = true WHERE id = ?";
                PreparedStatement preparedStatement = conexion.prepareStatement(consultaSQL);
                preparedStatement.setInt(1, id);

                // Ejecutar la consulta de eliminación
                int filasEliminadas = preparedStatement.executeUpdate();

                if (filasEliminadas > 0) {
                    System.out.println("Se ha actualizado la fila con ID " + id + " de la base de datos.");
                } else {
                    System.out.println("No se encontró una fila con ID " + id + " en la base de datos.");
                }

                // Cerrar recursos
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            ConexionBD.desconectar(conexion);

        } else {
            System.err.println("No se pudo establecer la conexión a la base de datos.");
        }


    }

    public static int espacio(int id) { //Done mira el espacio que ocupa cierto video en la BD por id
        int espacio = 0;
        Connection conexion = ConexionBD.conectar();

        if (conexion != null) {
            System.out.println("Conectado a la base de datos.");

            try {
                String consultaSQL = "SELECT tamaño FROM Instalaciones WHERE id = ?";
                PreparedStatement preparedStatement = conexion.prepareStatement(consultaSQL);
                preparedStatement.setInt(1, id);

                // Ejecutar la consulta de selección
                ResultSet resultSet = preparedStatement.executeQuery();

                // Verificar si se obtuvo un resultado
                if (resultSet.next()) {
                    espacio = resultSet.getInt("tamaño");
                }

            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                ConexionBD.desconectar(conexion);
            }

        } else {
            System.err.println("No se pudo establecer la conexión a la base de datos.");
        }

        return espacio;
    }

    public static int calcular(List<Integer> ids) {
        int espacioTotal = 0;

        for (Integer id : ids) {
            espacioTotal += id;
        }

        System.out.println(espacioTotal);
        return espacioTotal;
    }

    public static void subir(int id){
        // sube los datos al s3 sacando los datos de la base de datos

        Connection conexion = ConexionBD.conectar();

        if (conexion != null) {
            System.out.println("Conectado a la base de datos.");

            try {
                Statement statement = conexion.createStatement();
                String consultaSQL = "SELECT * FROM Países";
                ResultSet resultado = statement.executeQuery(consultaSQL);

            } catch (SQLException e) {
                e.printStackTrace();
            }

            ConexionBD.desconectar(conexion);

        } else {
            System.err.println("No se pudo establecer la conexión a la base de datos.");
        }



    }

    public static void pendiente(int id) {
        Connection conexion = ConexionBD.conectar();

        if (conexion != null) {
            System.out.println("Conectado a la base de datos desde Interfaz.");

            try {
                // Preparar una consulta parametrizada para eliminar la fila con la ID proporcionada
                String consultaSQL = "UPDATE Instalaciones SET pendiente = false WHERE id = ?";
                PreparedStatement preparedStatement = conexion.prepareStatement(consultaSQL);
                preparedStatement.setInt(1, id);

                // Ejecutar la consulta de eliminación
                int filasEliminadas = preparedStatement.executeUpdate();

                if (filasEliminadas > 0) {
                    System.out.println("Se ha eliminado la fila con ID " + id + " de la base de datos.");
                } else {
                    System.out.println("No se encontró una fila con ID " + id + " en la base de datos.");
                }

                // Cerrar recursos
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            ConexionBD.desconectar(conexion);

        } else {
            System.err.println("No se pudo establecer la conexión a la base de datos.");
        }

    }
}
