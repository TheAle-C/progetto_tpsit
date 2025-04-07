package com.mywebapp.MySql;

import com.mywebapp.Other.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

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

    public void close() {
        conn.close();
    }
}
