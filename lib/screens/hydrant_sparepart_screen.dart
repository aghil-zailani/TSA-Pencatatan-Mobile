import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/custom_button.dart';

class HydrantSparepartScreen extends StatefulWidget {
  @override
  _HydrantSparepartScreenState createState() => _HydrantSparepartScreenState();
}

class _HydrantSparepartScreenState extends State<HydrantSparepartScreen> {
  final _namaBarangController = TextEditingController();
  final _beratController = TextEditingController();
  final _merekBarangController = TextEditingController();
  final _ukuranBarangController = TextEditingController();
  final _satuanController = TextEditingController();
  final _kondisiBarangController = TextEditingController();
  final _jumlahBarangController = TextEditingController();

  final Color primaryBlue = Color(0xFF2196F3);

  @override
  void dispose() {
    _namaBarangController.dispose();
    _beratController.dispose();
    _merekBarangController.dispose();
    _ukuranBarangController.dispose();
    _satuanController.dispose();
    _kondisiBarangController.dispose();
    _jumlahBarangController.dispose();
    super.dispose();
  }

  Widget _buildInputField({
    required String labelText,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: primaryBlue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: primaryBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: primaryBlue.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: primaryBlue, width: 2.0),
        ),
        labelStyle: TextStyle(fontFamily: 'Poppins', color: primaryBlue),
        hintStyle: TextStyle(fontFamily: 'Poppins'),
      ),
      style: TextStyle(fontFamily: 'Poppins'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Hydrant Sparepart',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
        backgroundColor: primaryBlue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputField(labelText: 'Nama Barang', controller: _namaBarangController, icon: Icons.label),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Berat', controller: _beratController, icon: Icons.scale),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Merek Barang', controller: _merekBarangController, icon: Icons.branding_watermark),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Ukuran Barang', controller: _ukuranBarangController, icon: Icons.aspect_ratio),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Satuan', controller: _satuanController, icon: Icons.straighten),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Kondisi Barang', controller: _kondisiBarangController, icon: Icons.build_circle),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Jumlah Barang', controller: _jumlahBarangController, icon: Icons.confirmation_number),
            SizedBox(height: 30),

            CustomButton(
              onPressed: () {
                final namaBarang = _namaBarangController.text;
                final berat = _beratController.text;
                final merekBarang = _merekBarangController.text;
                final ukuranBarang = _ukuranBarangController.text;
                final satuan = _satuanController.text;
                final kondisiBarang = _kondisiBarangController.text;
                final jumlahBarang = _jumlahBarangController.text;

                print('Nama Barang: $namaBarang, Berat: $berat, Merek: $merekBarang, Ukuran: $ukuranBarang, Satuan: $satuan, Kondisi: $kondisiBarang, Jumlah: $jumlahBarang');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Data berhasil disimpan (simulasi)!')),
                );
              },
              text: 'Simpan Data',
              buttonColor: primaryBlue,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
