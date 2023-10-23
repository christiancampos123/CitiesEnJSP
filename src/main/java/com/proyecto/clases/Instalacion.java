package com.proyecto.clases;

public class Instalacion extends InstalacionBase implements InterfazGestion {
    boolean revisado;
    boolean borrado;
    int espacio;

    public Instalacion(String nombre, String pais, String ciudad, boolean revisado, boolean borrado, int espacio) {
        super(nombre, pais, ciudad);
        this.revisado = revisado;
        this.borrado = borrado;
        this.espacio = espacio;
    }


    public boolean isRevisado() {
        return revisado;
    }

    public void setRevisado(boolean revisado) {
        this.revisado = revisado;
    }

    public boolean isBorrado() {
        return borrado;
    }

    public void setBorrado(boolean borrado) {
        this.borrado = borrado;
    }

    public int getEspacio() {
        return espacio;
    }

    public void setEspacio(int espacio) {
        this.espacio = espacio;
    }

}
