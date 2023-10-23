Este es un programa que consulta una base de datos y trabaja con Minio para sincronizarse y crear instalaciones. Permite crearlas, revisarlas, marcarlas y subirlas a MINIO.

Versión 1:

- Inicio (muestra los países disponibles y las ciudades con las IDs disponibles para crear archivos en la base de datos).

- Instalaciones (muestra todas las instalaciones con sus datos; se puede buscar por ID, nombre, ciudad y país. Este buscador está presente en todos los JSP).

- Revisar (muestra todas las instalaciones no revisadas y permite marcarlas como revisadas. También se actualizan en la base de datos).

- Borrar (permite marcar las instalaciones para su eliminación. Estas se actualizan en el campo "borrar" en la base de datos, cambiando su estado a "true". En caso de encontrarse en la ubicación local, el programa las elimina de la carpeta local. Además, se eliminan de MINIO si se encuentran allí. Sin embargo, no desaparecen de la base de datos).

- Subir (permite subir una instalación que se creará como pendiente y no revisada. Si es permitido por la base de datos, creará una fila en la misma y un archivo .txt en tu escritorio en la carpeta "datos". Finalmente, lo subirá a MINIO S3. También dispone de un recordatorio y una casilla de información para consultar).

- Pendiente (muestra todas las instalaciones pendientes y permite marcarlas como no pendientes, actualizando la base de datos).

- Back (este es el lugar al que redirigen todos los JSP para ejecutar los cambios posteriores con la información solicitada).

Descarga : https://github.com/christiancampos123/CitiesEnJSP/archive/refs/heads/master.zip