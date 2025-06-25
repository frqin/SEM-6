import 'package:flutter/material.dart';

class LupaPasswordPage extends StatelessWidget {
  const LupaPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Circle
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFE0D9F9), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lupa Password',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Masukkan email yang terdaftar untuk mengatur ulang password.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Email Field
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Kirim Email Button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Tambahkan logika kirim email reset password
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Link reset dikirim ke email")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                    ),

                    label: const Text('Kirim Link Reset'),
                  ),

                  const SizedBox(height: 16),

                  // Kembali ke Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
