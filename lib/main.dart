import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Rute awal
      routes: {
        '/': (context) => LoginScreen(),  // Rute ke LoginScreen
        '/main': (context) => MainScreen(), // Rute ke MainScreen
      },
    );
  }
}