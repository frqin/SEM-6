import 'package:edukidz/frontend/firstpage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
