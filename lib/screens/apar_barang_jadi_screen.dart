import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/custom_button.dart';
// import 'package:flutter_vision/flutter_vision.dart'; // Tetap dikomentari jika OCR dimatikan sementara
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class APARBarangJadiScreen extends StatefulWidget {
  @override
  _APARBarangJadiScreenState createState() => _APARBarangJadiScreenState();
}

class _APARBarangJadiScreenState extends State<APARBarangJadiScreen> {
  final _namaBarangController = TextEditingController();
  final _beratController = TextEditingController();
  final _tipeBarangController = TextEditingController();
  final _tanggalKadaluarsaController = TextEditingController();
  final _satuanController = TextEditingController();
  final _kondisiBarangController = TextEditingController();

  String _ocrText = '';
  bool _isOCRRunning = false;
  // late final FlutterVision ocrEngine; // Dihapus/dikomentari
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedFile;

  // Pindahkan definisi primaryBlue ke sini agar bisa diakses oleh semua metode
  final Color primaryBlue = Color(0xFF2196F3); // Contoh biru, sesuaikan dengan logo TSA

  @override
  void initState() {
    super.initState();
    // Inisialisasi OCR dikomentari/dihapus sesuai permintaan
    // ocrEngine = FlutterVision();
    // initializeOCR();
  }

  Future<void> initializeOCR() async {
    // Fungsi ini dikosongkan karena OCR dimatikan sementara
  }

  @override
  void dispose() {
    _namaBarangController.dispose();
    _beratController.dispose();
    _tipeBarangController.dispose();
    _tanggalKadaluarsaController.dispose();
    _satuanController.dispose();
    _kondisiBarangController.dispose();
    // ocrEngine.closeTesseract(); // Dihapus/dikomentari
    super.dispose();
  }

  Future<void> _startOCR() async {
    setState(() {
      _isOCRRunning = true;
      _ocrText = 'Scanning...';
    });

    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        _pickedFile = pickedFile;

        String extractedText = 'OCR Disabled'; // Pesan sementara
        // Logika OCR di sini akan diaktifkan kembali nanti
        // final List<Map<String, dynamic>> ocrResultsRaw = await ocrEngine.tesseractOnImage(
        //   path: _pickedFile!.path,
        // );
        // extractedText = '';
        // for (var result in ocrResultsRaw) {
        //   if (result.containsKey('text')) {
        //     extractedText += result['text'] + ' ';
        //   }
        // }

        if (extractedText.isNotEmpty) {
          setState(() {
            _ocrText = extractedText;
            _parseOCRResult(extractedText);
          });
        } else {
          setState(() {
            _ocrText = 'No text found.';
          });
        }
      } else {
        setState(() {
          _ocrText = 'No image selected.';
        });
      }
    } catch (e) {
      setState(() {
        _ocrText = 'Error during OCR: ${e.toString()}';
      });
      print('Error during OCR: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan saat OCR: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isOCRRunning = false;
        });
      }
    }
  }

  void _parseOCRResult(String text) {
    if (text.contains('GUNNEBO') && text.contains('POWDER')) {
      _namaBarangController.text = 'APAR GUNNEBO';
      _tipeBarangController.text = 'ABC-POWDER';
    }

    RegExp beratRegExp = RegExp(r'(\d+\.?\d*)\s*kg', caseSensitive: false);
    Match? beratMatch = beratRegExp.firstMatch(text);
    if (beratMatch != null) {
      _beratController.text = beratMatch.group(1) ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // primaryBlue sudah didefinisikan di level kelas, jadi tidak perlu di sini lagi
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'APAR Barang Jadi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30),

            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: _pickedFile != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.file(
                  File(_pickedFile!.path),
                  fit: BoxFit.cover,
                ),
              )
                  : Center(
                child: Text(
                  'Ambil Gambar APAR',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            CustomButton(
              onPressed: _startOCR,
              text: _isOCRRunning ? 'Scanning...' : 'Ambil Gambar & Scan',
              buttonColor: primaryBlue, // Gunakan primaryBlue yang sudah diakses
              textColor: Colors.white,
            ),
            SizedBox(height: 10),
            Text('Hasil OCR: $_ocrText', style: TextStyle(fontFamily: 'Poppins', fontStyle: FontStyle.italic)),
            SizedBox(height: 30),

            _buildInputField(
              labelText: 'Nama Barang',
              controller: _namaBarangController,
              primaryBlue: primaryBlue,
              icon: Icons.label_outline,
            ),
            SizedBox(height: 16),
            _buildInputField(
              labelText: 'Berat',
              controller: _beratController,
              primaryBlue: primaryBlue,
              icon: Icons.scale_outlined,
            ),
            SizedBox(height: 16),
            _buildInputField(
              labelText: 'Tipe Barang',
              controller: _tipeBarangController,
              primaryBlue: primaryBlue,
              icon: Icons.category_outlined,
            ),
            SizedBox(height: 16),
            _buildInputField(
              labelText: 'Tanggal Kadaluarsa',
              controller: _tanggalKadaluarsaController,
              primaryBlue: primaryBlue,
              icon: Icons.calendar_today_outlined,
              isDateField: true,
            ),
            SizedBox(height: 16),
            _buildInputField(
              labelText: 'Satuan',
              controller: _satuanController,
              primaryBlue: primaryBlue,
              icon: Icons.straighten_outlined,
            ),
            SizedBox(height: 16),
            _buildInputField(
              labelText: 'Kondisi Barang',
              controller: _kondisiBarangController,
              primaryBlue: primaryBlue,
              icon: Icons.health_and_safety_outlined,
            ),
            SizedBox(height: 30),

            CustomButton(
              onPressed: () {
                final namaBarang = _namaBarangController.text;
                final berat = _beratController.text;
                final tipeBarang = _tipeBarangController.text;
                final tanggalKadaluarsa = _tanggalKadaluarsaController.text;
                final satuan = _satuanController.text;
                final kondisiBarang = _kondisiBarangController.text;

                print('Data yang disimpan: Nama Barang: $namaBarang, Berat: $berat, Tipe: $tipeBarang, Tgl Kadaluarsa: $tanggalKadaluarsa, Satuan: $satuan, Kondisi: $kondisiBarang');
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

  Widget _buildInputField({
    required String labelText,
    required TextEditingController controller,
    required Color primaryBlue,
    required IconData icon,
    bool isDateField = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: isDateField,
      onTap: isDateField ? () => _selectDate(context, controller) : null,
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
      keyboardType: isDateField ? TextInputType.datetime : TextInputType.text,
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryBlue, // Mengakses primaryBlue dari _APARBarangJadiScreenState
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primaryBlue, // Mengakses primaryBlue
              ),
            ),
            textTheme: TextTheme(
              bodyMedium: TextStyle(fontFamily: 'Poppins'),
              labelLarge: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != DateTime.now()) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }
}