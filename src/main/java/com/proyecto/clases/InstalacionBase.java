package com.proyecto.clases;

public class InstalacionBase {
    String nombre;
    String pais;
    String ciudad;

    public InstalacionBase(String nombre, String pais, String ciudad) {
        this.nombre = nombre;
        this.pais = pais;
        this.ciudad = ciudad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {this.ciudad = ciudad;
    }

}
