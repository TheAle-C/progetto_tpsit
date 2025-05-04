package com.mywebapp.MySql;

import com.mywebapp.Other.Logger;

import java.sql.*;

public class Database {
    MySqlConnection conn;

    public Database(String username, String password) {
        conn = new MySqlConnection(username, password);
    }

    public void connect(String DatabaseAddress, String DatabasePort, String DatabaseName) {
        if (conn != null) {
            conn.connect(DatabaseAddress, DatabasePort, DatabaseName);
        }
        else {
            Logger.error("Database.connect(..., ..., ...) : connessione al database già presente");
        }
    }

    public ResultSet query(String query) {
        try {
            Statement statement = conn.getConnection().createStatement();
            return statement.executeQuery(query);
        } catch (SQLException e) {
            Logger.error(e.getMessage());
            return null;
        }
    }

    public void queryUpdate(String query) {
        try {
            Statement statement = conn.getConnection().createStatement();
            statement.executeUpdate(query);
        } catch (SQLException e) {
            Logger.error(e.getMessage());
        }
    }

    public Connection getConnection() {
        return conn.getConnection();
    }

    public void close() {
        conn.close();
    }
}
