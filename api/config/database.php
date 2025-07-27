<?php
// Configuración de base de datos para Hostinger
// Archivo: api/config/database.php

class Database {
    // Configuración para Hostinger - DATOS REALES
    private $host = "localhost";
    private $db_name = "u730885639_musicon"; // Tu base de datos real
    private $username = "u730885639_musicon1"; // Tu usuario real
    private $password = "Misifu93"; // Tu contraseña real
    private $conn;

    // Método para obtener conexión
    public function getConnection() {
        $this->conn = null;
        
        try {
            $this->conn = new PDO(
                "mysql:host=" . $this->host . ";dbname=" . $this->db_name . ";charset=utf8",
                $this->username,
                $this->password
            );
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $this->conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        } catch(PDOException $e) {
            error_log("Error de conexión: " . $e->getMessage());
            throw new Exception("Error de conexión a la base de datos");
        }
        
        return $this->conn;
    }
}

// Configuración CORS para permitir requests desde la app
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
header("Content-Type: application/json; charset=UTF-8");

// Manejar preflight requests
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}
?> 