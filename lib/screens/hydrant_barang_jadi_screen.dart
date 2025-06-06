import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_button.dart';

class HydrantBarangJadiScreen extends StatefulWidget {
  @override
  _HydrantBarangJadiScreenState createState() => _HydrantBarangJadiScreenState();
}

class _HydrantBarangJadiScreenState extends State<HydrantBarangJadiScreen> {
  final _namaBarangController = TextEditingController();
  final _beratController = TextEditingController();
  final _tipeBarangController = TextEditingController();
  final _satuanController = TextEditingController();
  final _kondisiBarangController = TextEditingController();
  final _ukuranBarangController = TextEditingController();
  final _panjangController = TextEditingController();
  final _lebarController = TextEditingController();
  final _tinggiController = TextEditingController();

  final Color primaryBlue = Color(0xFF2196F3);
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedFile;

  @override
  void dispose() {
    _namaBarangController.dispose();
    _beratController.dispose();
    _tipeBarangController.dispose();
    _satuanController.dispose();
    _kondisiBarangController.dispose();
    _ukuranBarangController.dispose();
    _panjangController.dispose();
    _lebarController.dispose();
    _tinggiController.dispose();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hydrant Barang Jadi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30),

            _buildInputField(labelText: 'Nama Barang', controller: _namaBarangController, icon: Icons.label_outline),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Berat', controller: _beratController, icon: Icons.scale_outlined),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Tipe Barang', controller: _tipeBarangController, icon: Icons.category_outlined),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Satuan', controller: _satuanController, icon: Icons.straighten_outlined),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Kondisi Barang', controller: _kondisiBarangController, icon: Icons.health_and_safety_outlined),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Ukuran Barang', controller: _ukuranBarangController, icon: Icons.aspect_ratio_outlined),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Panjang', controller: _panjangController, icon: Icons.swap_vert_outlined),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Lebar', controller: _lebarController, icon: Icons.swap_horiz_outlined),
            SizedBox(height: 16),
            _buildInputField(labelText: 'Tinggi', controller: _tinggiController, icon: Icons.height_outlined),
            SizedBox(height: 30),

            CustomButton(
              onPressed: () {
                final namaBarang = _namaBarangController.text;
                final berat = _beratController.text;
                final tipeBarang = _tipeBarangController.text;
                final satuan = _satuanController.text;
                final kondisiBarang = _kondisiBarangController.text;
                final ukuranBarang = _ukuranBarangController.text;
                final panjang = _panjangController.text;
                final lebar = _lebarController.text;
                final tinggi = _tinggiController.text;

                print('Data yang disimpan: Nama Barang: $namaBarang, Berat: $berat, Tipe: $tipeBarang, Satuan: $satuan, Kondisi: $kondisiBarang, Ukuran: $ukuranBarang, Panjang: $panjang, Lebar: $lebar, Tinggi: $tinggi');
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
