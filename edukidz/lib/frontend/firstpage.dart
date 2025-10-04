import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();

    // Navigasi otomatis setelah 3 detik
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, _createRoute());
    });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/tubes1.png',
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 10),
            Text(
              'EduKidz',
              style: GoogleFonts.angkor(
                fontSize: 18,
                color: const Color(0xFF444444),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
