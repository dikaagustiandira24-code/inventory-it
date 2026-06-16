package com.mycompany.inventory; // ⚠️ PERHATIAN: Sesuaikan baris ini dengan nama package Anda yang tertera di bagian paling atas sebelum dihapus tadi!

import java.sql.Connection;
import java.sql.DriverManager;

public class Koneksi {
    public static Connection getKoneksi() {
        Connection con = null;
        try {
            // 1. Mengambil URL database langsung dari Environment Variable Render nanti
            String dbUrl = System.getenv("DATABASE_URL") != null ? 
                            System.getenv("DATABASE_URL") : 
                            "jdbc:postgresql://localhost:5432/db_inventory_it"; // Ini cadangan untuk di laptop lokal

            // 2. Jika URL dari Neon diawali 'postgresql://', Java butuh mengubahnya menjadi 'jdbc:postgresql://' agar terbaca oleh driver
            if (dbUrl.startsWith("postgresql://")) {
                dbUrl = dbUrl.replace("postgresql://", "jdbc:postgresql://");
            }

            // 3. Membuka gerbang koneksi ke server Neon
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(dbUrl);
            System.out.println("Koneksi ke Database Cloud Neon BERHASIL!");
            
        } catch (Exception e) {
            System.out.println("Koneksi ke Database GAGAL: " + e.getMessage());
        }
        return con;
    }
}