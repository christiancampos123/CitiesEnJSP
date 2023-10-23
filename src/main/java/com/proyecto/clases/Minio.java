package com.proyecto.clases;

import io.minio.*;
import io.minio.errors.*;
import io.minio.MakeBucketArgs;
import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

public class Minio {
    public static void subirArchivoAMinio(String nombre,String ruta) throws ServerException, InsufficientDataException, ErrorResponseException, IOException, NoSuchAlgorithmException, InvalidKeyException, InvalidResponseException, XmlParserException, InternalException {
        try {
            String endpoint = "http://192.168.1.234:9000";
            String accessKey = "ROOTNAME";
            String secretKey = "CHANGEME123";
            MinioClient minioClient = MinioClient.builder()
                    .endpoint(endpoint)
                    .credentials(accessKey, secretKey)
                    .build();

            boolean found =
                    minioClient.bucketExists(BucketExistsArgs.builder().bucket("instalaciones").build());
            if (!found) {
                // Make a new bucket called 'asiatrip'.
                minioClient.makeBucket(MakeBucketArgs.builder().bucket("instalaciones").build());
            } else {
                System.out.println("Bucket 'instalaciones' already exists.");
            }

            minioClient.uploadObject(
                    UploadObjectArgs.builder()
                            .bucket("instalaciones")
                            .object(nombre)
                            .filename(ruta)
                            .build());
            System.out.println(
                    "'/home/user/Photos/asiaphotos.zip' is successfully uploaded as "
                            + "object 'asiaphotos-2015.zip' to bucket 'asiatrip'.");
        } catch (MinioException e) {
            System.out.println("Error occurred: " + e);
            System.out.println("HTTP trace: " + e.httpTrace());
        }


    }


    public static void borrarArchivoDeMinio(String nombreArchivo) {
        //recordar que le tienes que pasar nomrbe de archivo.txt
        try {
            String endpoint = "http://192.168.1.234:9000";
            String accessKey = "ROOTNAME";
            String secretKey = "CHANGEME123";

            MinioClient minioClient = MinioClient.builder()
                    .endpoint(endpoint)
                    .credentials(accessKey, secretKey)
                    .build();

            String bucketName = "instalaciones"; // Nombre del bucket
            boolean found = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build());

            if (!found) {
                System.out.println("El bucket no existe.");
                return;
            }

            // Borra el archivo del bucket
            minioClient.removeObject(RemoveObjectArgs.builder().bucket(bucketName).object(nombreArchivo).build());

            System.out.println("Archivo '" + nombreArchivo + "' ha sido borrado del bucket '" + bucketName + "'.");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error al borrar el archivo de Minio.");
        }
    }


}
