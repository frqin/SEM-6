import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:edukidz/frontend/kelas1.dart';
import 'package:edukidz/frontend/kelas2.dart';
import 'package:edukidz/frontend/kelas3.dart';
import 'package:edukidz/frontend/kelas4.dart';
import 'package:edukidz/frontend/kelas5.dart';
import 'package:edukidz/frontend/kelas6.dart';
import 'package:edukidz/frontend/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _nama = 'Liza';
  String _bio = 'Belum ada bio';
  String _hobi = 'Belum ada hobi';
  Uint8List? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProfilePage(
                                initialName: _nama,
                                initialBio: _bio,
                                initialHobi: _hobi,
                                profileImage: _profileImage,
                              ),
                            ),
                          );

                          if (result != null && result is Map) {
                            setState(() {
                              _nama = result['name'] ?? _nama;
                              _bio = result['bio'] ?? _bio;
                              _hobi = result['hobi'] ?? _hobi;
                              _profileImage = result['image'];
                            });
                          }
                        },
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.blueGrey,
                          child: _profileImage != null
                              ? ClipOval(
                            child: Image.memory(
                              _profileImage!,
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                            ),
                          )
                              : const Icon(Icons.person, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Hii, ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: "$_nama 👋",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    'Pilih Kelas Kamu',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [
                        classCard('assets/kelas1.png', 'Kelas 1', Colors.orange, () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const Kelas1Page()));
                        }),
                        classCard('assets/kelas2.png', 'Kelas 2', Colors.orange, () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const Kelas2Page()));
                        }),
                        classCard('assets/kelas3.png', 'Kelas 3', Colors.orange, () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const Kelas3Page()));
                        }),
                        classCard('assets/kelas4.png', 'Kelas 4', Colors.orange, () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const Kelas4Page()));
                        }),
                        classCard('assets/kelas5.png', 'Kelas 5', Colors.orange, () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const Kelas5Page()));
                        }),
                        classCard('assets/kelas6.png', 'Kelas 6', Colors.orange, () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const Kelas6Page()));
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget classCard(String imagePath, String title, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
