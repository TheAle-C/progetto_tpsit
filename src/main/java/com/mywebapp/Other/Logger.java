package com.mywebapp.Other;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Logger {

    private static String logFilePath = "default.log"; // fallback se non impostato
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    // Imposta il percorso del file di log (va fatto all'avvio della webapp)
    public static void setLogFilePath(String path) {
        logFilePath = path;

        // Crea la cartella se non esiste
        File file = new File(logFilePath);
        File dir = file.getParentFile();
        if (dir != null && !dir.exists()) {
            dir.mkdirs();
        }
    }

    private static synchronized void log(String level, String message) {
        String timestamp = LocalDateTime.now().format(formatter);
        String fullMessage = String.format("[%s] [%s] %s", timestamp, level, message);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(logFilePath, true))) {
            writer.write(fullMessage);
            writer.newLine();
        } catch (IOException e) {
            // In caso di errore, stampa a console
            System.err.println("Logger error: " + e.getMessage());
        }
    }

    public static void info(String message) {
        log("INFO", message);
    }

    public static void error(String message) {
        log("ERROR", message);
    }

    public static void debug(String message) {
        log("DEBUG", message);
    }
}
