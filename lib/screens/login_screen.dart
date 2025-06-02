import 'package:flutter/material.dart';
import '../main.dart'; // Import MyApp (jika diperlukan untuk navigasi langsung)
import 'main_screen.dart'; // Import MainScreen
import '../widgets/input_field.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo atau Judul Aplikasi
            Container(
              height: 100,
              color: Colors.grey[300],
              margin: EdgeInsets.only(bottom: 20),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //  Perbaikan Navigasi: Gunakan Navigator.pushNamed
                Navigator.pushNamed(context, '/main');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}