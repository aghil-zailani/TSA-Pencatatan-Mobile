import 'package:flutter/material.dart';
import 'apar_barang_jadi_screen.dart';
import 'apar_sparepart_screen.dart';
import 'hydrant_barang_jadi_screen.dart';
import 'hydrant_sparepart_screen.dart';
import 'barang_keluar_screen.dart';
import '../widgets/custom_button.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Color(0xFF2196F3); // Contoh biru, sesuaikan dengan logo TSA
    final Color redCard = Color(0xFFEF5350); // Contoh merah untuk card Barang Keluar
    final Color buttonBackgroundColor = Color(0xFFE0E0E0); // Warna abu-abu muda untuk tombol

    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar dihapus untuk memindahkan "Kelola Barang" ke body
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Teks "Kelola Barang" dipindahkan ke sini
              Text(
                'Kelola Barang',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28, // Ukuran font mungkin lebih besar
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 30), // Jarak antara teks Kelola Barang dan card APAR

              // Bagian APAR
              _buildCategoryCard(
                context,
                title: 'APAR',
                cardColor: primaryBlue,
                buttonTextColor: Colors.white,
                buttons: [
                  _buildCategoryButton(
                    context,
                    text: 'Barang Jadi',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => APARBarangJadiScreen()),
                      );
                    },
                    buttonColor: buttonBackgroundColor,
                    textColor: Colors.black87,
                  ),
                  _buildCategoryButton(
                    context,
                    text: 'Sparepart',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => APARSpartScreen()),
                      );
                    },
                    buttonColor: buttonBackgroundColor,
                    textColor: Colors.black87,
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Bagian Hydrant
              _buildCategoryCard(
                context,
                title: 'Hydrant',
                cardColor: primaryBlue,
                buttonTextColor: Colors.white,
                buttons: [
                  _buildCategoryButton(
                    context,
                    text: 'Barang Jadi',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HydrantBarangJadiScreen()),
                      );
                    },
                    buttonColor: buttonBackgroundColor,
                    textColor: Colors.black87,
                  ),
                  _buildCategoryButton(
                    context,
                    text: 'Sparepart',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HydrantSparepartScreen()),
                      );
                    },
                    buttonColor: buttonBackgroundColor,
                    textColor: Colors.black87,
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Bagian Barang Keluar
              _buildActionCard(
                context,
                title: 'Barang Keluar',
                description: 'Pencatatan terhadap barang yang akan keluar dari gudang termasuk transaksi',
                cardColor: redCard,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BarangKeluarScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, {
    required String title,
    required Color cardColor,
    required List<Widget> buttons,
    Color? buttonTextColor,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: cardColor,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, {
    required String text,
    required VoidCallback onPressed,
    required Color buttonColor,
    required Color textColor,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          constraints: BoxConstraints(minHeight: 80, minWidth: 100),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: textColor,
              padding: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 0,
            ),
            onPressed: onPressed,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, {
    required String title,
    required String description,
    required Color cardColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: cardColor,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: textColor.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}