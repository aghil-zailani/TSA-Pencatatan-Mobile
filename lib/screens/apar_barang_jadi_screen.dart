import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_vision/flutter_vision.dart'; // Import flutter_vision

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
  late final FlutterVision ocrEngine; // Deklarasikan ocrEngine

  @override
  void initState() {
    super.initState();
    ocrEngine = FlutterVision(); // Inisialisasi ocrEngine
    initializeOCR();
  }

  Future<void> initializeOCR() async {
    // Inisialisasi OCR (periksa dokumentasi flutter_vision untuk detailnya!)
    //  Anda mungkin perlu menentukan model Tesseract.
    //  Contoh (mungkin perlu disesuaikan):
    await ocrEngine.loadTesseract('assets/tessdata/eng.traineddata'); // Ganti dengan path yang benar
  }

  @override
  void dispose() {
    _namaBarangController.dispose();
    _beratController.dispose();
    _tipeBarangController.dispose();
    _tanggalKadaluarsaController.dispose();
    _satuanController.dispose();
    _kondisiBarangController.dispose();
    ocrEngine.closeTesseract(); // Tutup ocrEngine
    super.dispose();
  }

  Future<void> _startOCR() async {
    setState(() {
      _isOCRRunning = true;
      _ocrText = 'Scanning...';
    });

    try {
      final List<OcrText> ocrResults = await ocrEngine.ocr(
        'assets/image.jpg', // Ganti dengan path gambar yang diambil
        //  Contoh: Anda mungkin perlu menyimpan gambar yang diambil dari kamera dan memberinya path
      );

      if (ocrResults.isNotEmpty) {
        String extractedText = '';
        for (OcrText result in ocrResults) {
          extractedText += result.text + ' ';
        }
        setState(() {
          _ocrText = extractedText;
          _parseOCRResult(extractedText);
        });
      } else {
        setState(() {
          _ocrText = 'No text found.';
        });
      }
    } catch (e) {
      setState(() {
        _ocrText = 'Error: $e';
      });
    } finally {
      setState(() {
        _isOCRRunning = false;
      });
    }
  }

  void _parseOCRResult(String text) {
    //  Logika parsing yang sama seperti sebelumnya (sangat penting untuk disesuaikan)
    if (text.contains('GUNNEBO') && text.contains('POWDER')) {
      _namaBarangController.text = 'APAR GUNNEBO';
      _tipeBarangController.text = 'ABC-POWDER';
    }

    RegExp beratRegExp = RegExp(r'(\d+\.?\d*)\s*kg', caseSensitive: false);
    Match? beratMatch = beratRegExp.firstMatch(text);
    if (beratMatch != null) {
      _beratController.text = beratMatch.group(1) ?? '';
    }

    //  ... (parsing tanggal kadaluarsa, dll.)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('APAR Barang Jadi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              color: Colors.grey[300],
            ),
            CustomButton(
              onPressed: _startOCR,
              text: _isOCRRunning ? 'Scanning...' : 'Ambil Gambar & Scan',
            ),
            Text('Hasil OCR: $_ocrText'),
            SizedBox(height: 20),
            InputField(labelText: 'Nama Barang', controller: _namaBarangController),
            SizedBox(height: 10),
            InputField(labelText: 'Berat', controller: _beratController),
            SizedBox(height: 10),
            InputField(labelText: 'Tipe Barang', controller: _tipeBarangController),
            SizedBox(height: 10),
            InputField(labelText: 'Tanggal Kadaluarsa', controller: _tanggalKadaluarsaController),
            SizedBox(height: 10),
            InputField(labelText: 'Satuan', controller: _satuanController),
            SizedBox(height: 10),
            InputField(labelText: 'Kondisi Barang', controller: _kondisiBarangController),
            SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                // Logika simpan data
              },
              text: 'Simpan Data',
            ),
          ],
        ),
      ),
    );
  }
}