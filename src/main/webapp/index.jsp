<%@page import="java.sql.*"%>
<%@page import="com.mycompany.inventory.Koneksi"%> <%-- ⚠️ PERHATIAN: Sesuaikan com.mycompany.inventory dengan nama package Anda! --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistem Inventaris IT Perusahaan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .navbar-brand { font-weight: bold; }
    </style>
</head>
<body>

    <nav class="navbar navbar-dark bg-dark shadow-sm">
        <div class="container">
            <span class="navbar-brand mb-0 h1">📦 IT Asset & Inventory</span>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row mb-4">
            <div class="col">
                <h2>Logistik & Stok Barang IT</h2>
                <p class="text-muted">Mempermudah monitoring stok aset masuk dan keluar di lingkungan perusahaan.</p>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-secondary text-white">
                <h5 class="card-title mb-0">Daftar Stok Aset</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th class="ps-3">Kode Barang</th>
                                <th>Nama Barang</th>
                                <th>Stok</th>
                                <th>Satuan</th>
                                <th>Lokasi Penyimpanan</th>
                                <th class="pe-3">Keterangan</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                // Bagian Java untuk mengambil data dari Database Cloud Neon
                                Connection con = null;
                                Statement st = null;
                                ResultSet rs = null;
                                try {
                                    con = Koneksi.getKoneksi();
                                    if (con != null) {
                                        st = con.createStatement();
                                        // Mengambil data barang dari tabel
                                        rs = st.executeQuery("SELECT * FROM Barang");
                                        
                                        // Looping (perulangan) untuk menampilkan baris demi baris barang
                                        while(rs.next()) {
                            %>
                            <tr>
                                <td class="fw-bold ps-3"><%= rs.getString("kode_barang") %></td>
                                <td><%= rs.getString("nama_barang") %></td>
                                <td>
                                    <span class="badge <%= (rs.getInt("stok") <= 3) ? "bg-danger" : "bg-primary" %>">
                                        <%= rs.getInt("stok") %>
                                    </span>
                                </td>
                                <td><%= rs.getString("satuan") %></td>
                                <td><%= rs.getString("lokasi_penyimpanan") %></td>
                                <td class="text-muted pe-3"><%= rs.getString("keterangan") %></td>
                            </tr>
                            <% 
                                        }
                                    } else {
                                        out.print("<tr><td colspan='6' class='text-center text-danger'>Gagal terhubung ke database server cloud.</td></tr>");
                                    }
                                } catch(Exception e) {
                                    out.print("<tr><td colspan='6' class='text-center text-danger'>Error memuat data: " + e.getMessage() + "</td></tr>");
                                } finally {
                                    // Menutup koneksi demi keamanan dan menghemat kapasitas database
                                    if (rs != null) rs.close();
                                    if (st != null) st.close();
                                    if (con != null) con.close();
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>