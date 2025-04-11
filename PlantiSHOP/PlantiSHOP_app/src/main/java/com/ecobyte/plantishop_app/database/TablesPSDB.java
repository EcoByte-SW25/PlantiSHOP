package com.ecobyte.plantishop_app.database;

/**
 * Enum that contains the actual SQL table names used in the Plantishop project.
 * Ensures consistent and error-free SQL referencing.
 * 
 * @author Glamdring
 * @version 1.2.0
 * @since 0.1
 */
public enum TablesPSDB {

    UBICACIONES("Ubicaciones"),
    USUARIOS("Usuarios"),
    PLANTAS("Plantas"),
    MENSAJES("Mensajes"),
    TRANSACCIONES("Transacciones"),
    MENSAJES_IA("MensajesIA"),
    FOTOS_IA("FotosIA"),
    MOVIMIENTOS("Movimientos"),
    CATEGORIAS("Categorias"),
    PLANTA_CATEGORIA("PlantaCategoria");

    /**
     * Holds the SQL table name.
     */
    private final String table;

    /**
     * Constructor to assign the table name.
     *
     * @param table The name of the table in the SQL database.
     */
    TablesPSDB(String table) {
        this.table = table;
    }

    /**
     * Getter for the table name.
     *
     * @return The SQL table name.
     */
    public String getTable() {
        return table;
    }
}
