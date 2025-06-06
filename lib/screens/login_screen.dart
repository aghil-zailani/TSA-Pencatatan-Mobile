import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http; // Import package http
import 'dart:convert'; // Untuk jsonEncode dan jsonDecode
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import secure storage
import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'main_screen.dart'; // Pastikan MainScreen sudah ada dan diimport dengan benar

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Untuk menampilkan indikator loading

  // Buat instance dari FlutterSecureStorage
  final _storage = FlutterSecureStorage();

  // GANTI URL INI DENGAN IP ADDRESS MESIN DEVELOPMENT ANDA JIKA MENGGUNAKAN EMULATOR
  // JANGAN GUNAKAN localhost ATAU 127.0.0.1 JIKA DARI EMULATOR ANDROID
  // Contoh: 'http://192.168.1.10:8000/api/login'
  // final String _loginApiUrl = 'http://192.168.56.96:8000/api/login';
  final String _loginApiUrl = '${dotenv.env['API_BASE_URL']}/login';

  Future<void> _login() async {
    if (_idController.text.isEmpty || _passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "ID dan Password tidak boleh kosong!");
      return;
    }

    setState(() {
      _isLoading = true; // Tampilkan loading indicator
    });

    try {
      final response = await http.post(
        Uri.parse(_loginApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          // Sesuaikan key dengan yang diharapkan API Laravel Anda ('username' atau 'id_perusahaan')
          'id': _idController.text,
          'password': _passwordController.text,
        }),
      ).timeout(const Duration(seconds: 10)); // Tambahkan timeout untuk menghindari loading tanpa henti

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Jika login berhasil (status code 200 OK)
        final String token = responseData['access_token'];
        final Map<String, dynamic> userData = responseData['user'];

        // Simpan token dengan aman untuk digunakan di request selanjutnya
        await _storage.write(key: 'api_token', value: token);
        await _storage.write(key: 'user_name', value: userData['username']);
        await _storage.write(key: 'user_role', value: userData['role']);

        Fluttertoast.showToast(msg: "Login Berhasil! Selamat datang ${userData['username']}");

        // Navigasi ke halaman utama setelah login berhasil
        if (mounted) { // Cek apakah widget masih ada di tree
          Navigator.pushReplacementNamed(context, '/main');
        }

      } else {
        // Jika API mengembalikan error (misalnya, status 422 untuk validasi)
        String errorMessage = responseData['message'] ?? "Terjadi kesalahan";
        if (responseData.containsKey('errors')) {
          // Ambil pesan error pertama dari validasi
          errorMessage = responseData['errors'].values.first[0];
        }
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      // Tangani error koneksi, timeout, atau lainnya
      print('Error saat login: $e'); // Untuk debugging di konsol Anda
      Fluttertoast.showToast(
        msg: "Gagal terhubung ke server. Periksa koneksi dan IP address.",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      // Pastikan loading indicator selalu berhenti, baik berhasil maupun gagal
      if(mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 30),
              Image.asset(
                'assets/images/tsa.jpeg',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 40),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: 'ID Pengguna',
                  hintText: 'Masukkan ID Anda',
                  prefixIcon: Icon(Icons.person_outline, color: primaryBlue),
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
                keyboardType: TextInputType.text,
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukkan password Anda',
                  prefixIcon: Icon(Icons.lock_outline, color: primaryBlue),
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
                obscureText: true,
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              SizedBox(height: 30),
              _isLoading
                  ? Center(child: CircularProgressIndicator()) // Tampilkan loading
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: _login,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}