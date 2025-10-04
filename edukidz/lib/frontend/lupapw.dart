import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LupaPasswordPage extends StatefulWidget {
  const LupaPasswordPage({super.key});

  @override
  State<LupaPasswordPage> createState() => _LupaPasswordPageState();
}

class _LupaPasswordPageState extends State<LupaPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  void resetPassword() async {
    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❗ Email tidak boleh kosong")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await _auth.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Link reset sudah dikirim ke email")),
      );

      Navigator.pop(context); // Kembali ke login
    } on FirebaseAuthException catch (e) {
      String message = "Terjadi kesalahan";

      if (e.code == 'user-not-found') {
        message = "❌ Email tidak terdaftar.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
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

                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.mail_outline),
                    ),
                  ),
                  const SizedBox(height: 24),

                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton.icon(
                    onPressed: resetPassword,
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

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Kembali ke Login",
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
