package com.mywebapp.MySql;

import com.mywebapp.Other.Logger;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySqlConnection {
    // è neccessario prima importare le librerie da https://dev.mysql.com/downloads/connector/j/
    // selezionare nel menu a tendina "Platform Independent"
    // nome pacchetto: Platform Independent (Architecture Independent), ZIP Archive
    // scaricarlo, estrarlo ed infine importarlo nel progetto
    private String DRIVER = "com.mysql.cj.jdbc.Driver";
    private String User;
    private String Password;

    private Connection connection;

    // connessione con valori default
    public MySqlConnection() {
        User = "root";
        Password = "";

        loadDriver();
    }

    // connessione con user e password, specificati
    public MySqlConnection(String user, String password) {
        User = user;
        Password = password;

        loadDriver();
    }

    public void loadDriver() {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            Logger.error("Errore nel caricamento dei driver: " + e.getMessage());
        }
    }

    public void connect(String DatabaseAddress, String DatabasePort, String DatabaseName) {
        String tmp_url_db = "jdbc:mysql://" + DatabaseAddress + ":" + DatabasePort + "/" + DatabaseName;

        connection = null;

        try {
            connection = DriverManager.getConnection(tmp_url_db, User, Password);
        }
        catch (Exception e) {
            Logger.error(e.getMessage());
        }
    }

    public void close() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                Logger.error(e.getMessage());
            }
        }
    }

    public Connection getConnection() {
        if (connection == null) {
            Logger.error("MySqlConnection.getConnection(): Non esiste uan connessione al database");
        }
        return connection;
    }
}
