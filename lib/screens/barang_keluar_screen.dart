import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/custom_button.dart';

class BarangKeluarScreen extends StatefulWidget {
  @override
  _BarangKeluarScreenState createState() => _BarangKeluarScreenState();
}

class _BarangKeluarScreenState extends State<BarangKeluarScreen> {
  final _idBarangControllers = <TextEditingController>[TextEditingController()];
  final _namaBarangController = TextEditingController();
  final _tujuanController = TextEditingController();
  final _keteranganController = TextEditingController();

  List<String> _idBarangList = [];
  final Color primaryBlue = Color(0xFF2196F3);

  @override
  void dispose() {
    for (var controller in _idBarangControllers) {
      controller.dispose();
    }
    _namaBarangController.dispose();
    _tujuanController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  void _addIdBarangField() {
    setState(() {
      _idBarangControllers.add(TextEditingController());
    });
  }

  void _removeIdBarangField(int index) {
    setState(() {
      _idBarangControllers[index].dispose();
      _idBarangControllers.removeAt(index);
    });
  }

  void _showDuplicateDialog(String duplicateId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFE0E0E0), // warna abu-abu terang seperti desain
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Center(
            child: Text(
              'Peringatan!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          content: Text(
            'Barang dengan ID\n$duplicateId\nSudah Ditambahkan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[400],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Konfirmasi',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  Widget _buildIdBarangField(int index) {
    return Row(
      children: [
        Expanded(
          child: InputField(
            labelText: 'ID Barang',
            controller: _idBarangControllers[index],
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_circle_outline, color: primaryBlue),
          onPressed: _addIdBarangField,
        ),
        if (index > 0)
          IconButton(
            icon: Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: () => _removeIdBarangField(index),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ Set background putih
      appBar: AppBar(
        title: Text(
          'Barang Keluar',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
        backgroundColor: primaryBlue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Logika Scan QR
                },
                icon: Icon(Icons.qr_code_scanner),
                label: Text('Scan QR Code', style: TextStyle(fontFamily: 'Poppins', color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'ID Barang',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Column(
                children: List.generate(_idBarangControllers.length, _buildIdBarangField),
              ),
              SizedBox(height: 20),
              InputField(labelText: 'Nama Barang', controller: _namaBarangController),
              SizedBox(height: 12),
              InputField(labelText: 'Tujuan', controller: _tujuanController),
              SizedBox(height: 12),
              InputField(labelText: 'Keterangan', controller: _keteranganController),
              SizedBox(height: 24),
              CustomButton(
                onPressed: () {
                  final inputIds = _idBarangControllers.map((c) => c.text.trim()).toList();

                  // Deteksi ID duplikat
                  final duplicate = inputIds.firstWhere(
                        (id) => inputIds.where((x) => x == id).length > 1,
                    orElse: () => '',
                  );

                  if (duplicate.isNotEmpty) {
                    _showDuplicateDialog(duplicate);
                    return;
                  }

                  // Jika tidak duplikat, lanjut proses
                  _idBarangList = inputIds;
                  final namaBarang = _namaBarangController.text;
                  final tujuan = _tujuanController.text;
                  final keterangan = _keteranganController.text;

                  print('ID Barang: $_idBarangList, Nama: $namaBarang, Tujuan: $tujuan, Ket: $keterangan');
                  // Lanjut simpan data ke database/API
                },
                text: 'Konfirmasi Barang Keluar',
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
