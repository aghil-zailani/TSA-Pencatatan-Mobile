import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/custom_button.dart';

class APARSpartScreen extends StatefulWidget {
  @override
  _APARSpartScreenState createState() => _APARSpartScreenState();
}

class _APARSpartScreenState extends State<APARSpartScreen> {
  final _namaBarangController = TextEditingController();
  final _beratController = TextEditingController();
  final _merekBarangController = TextEditingController();
  final _sizeController = TextEditingController();
  final _satuanController = TextEditingController();
  final _kondisiBarangController = TextEditingController();
  final _jumlahBarangController = TextEditingController();

  final Color primaryBlue = Color(0xFF2196F3);

  @override
  void dispose() {
    _namaBarangController.dispose();
    _beratController.dispose();
    _merekBarangController.dispose();
    _sizeController.dispose();
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
      style: TextStyle(fontFamily: 'Poppins'),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontFamily: 'Poppins'),
        prefixIcon: Icon(icon, color: primaryBlue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: primaryBlue.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: primaryBlue, width: 2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'APAR Sparepart',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
        backgroundColor: primaryBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildInputField(
                labelText: 'Nama Barang',
                controller: _namaBarangController,
                icon: Icons.inventory_2_outlined,
              ),
              SizedBox(height: 12),
              _buildInputField(
                labelText: 'Berat',
                controller: _beratController,
                icon: Icons.monitor_weight_outlined,
              ),
              SizedBox(height: 12),
              _buildInputField(
                labelText: 'Merek Barang',
                controller: _merekBarangController,
                icon: Icons.branding_watermark,
              ),
              SizedBox(height: 12),
              _buildInputField(
                labelText: 'Size',
                controller: _sizeController,
                icon: Icons.format_size,
              ),
              SizedBox(height: 12),
              _buildInputField(
                labelText: 'Satuan',
                controller: _satuanController,
                icon: Icons.straighten,
              ),
              SizedBox(height: 12),
              _buildInputField(
                labelText: 'Kondisi Barang',
                controller: _kondisiBarangController,
                icon: Icons.check_circle_outline,
              ),
              SizedBox(height: 12),
              _buildInputField(
                labelText: 'Jumlah Barang',
                controller: _jumlahBarangController,
                icon: Icons.numbers,
              ),
              SizedBox(height: 24),
              CustomButton(
                onPressed: () {
                  final namaBarang = _namaBarangController.text;
                  final berat = _beratController.text;
                  final merekBarang = _merekBarangController.text;
                  final size = _sizeController.text;
                  final satuan = _satuanController.text;
                  final kondisiBarang = _kondisiBarangController.text;
                  final jumlahBarang = _jumlahBarangController.text;

                  print(
                    'Nama Barang: $namaBarang, Berat: $berat, Merek: $merekBarang, Size: $size, Satuan: $satuan, Kondisi: $kondisiBarang, Jumlah: $jumlahBarang',
                  );

                  // Lakukan penyimpanan data ke backend atau database
                },
                text: 'Simpan Data',
                buttonColor: primaryBlue,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
