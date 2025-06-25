import 'package:edukidz/frontend/firstpage.dart';
import 'package:edukidz/frontend/home.dart';
import 'package:flutter/material.dart';
import 'package:edukidz/frontend//login.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduKidz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Sans',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const FirstPage(),
    );
  }
}
