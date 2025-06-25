import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'update_profil.dart';

class ProfilePage extends StatefulWidget {
  final String initialName;

  const ProfilePage({super.key, required this.initialName});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  Uint8List? _webImage;
  String _name = '';

  // Daftar warna yang akan berganti
  final List<Color> _colors = [
    const Color(0xFFEDF2F7),
    const Color(0xFFE6FFFA),
    const Color(0xFFFFF5F7),
    const Color(0xFFE3FCEF),
    const Color(0xFFE0F2FE),
  ];

  int _colorIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _name = widget.initialName;

    // Timer untuk mengubah warna background
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        _colorIndex = (_colorIndex + 1) % _colors.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _webImage = bytes;
        if (!kIsWeb) {
          _imageFile = File(picked.path);
        }
      });
    }
  }

  Future<void> _editProfile() async {
    final updatedName = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfilPage(initialName: _name),
      ),
    );

    if (updatedName != null && updatedName is String) {
      setState(() {
        _name = updatedName;
      });
    }
  }

  void _returnToHome() {
    Navigator.pop(context, {
      'name': _name,
      'image': _webImage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        color: _colors[_colorIndex],
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  '🧑‍🎓 Profil',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightBlue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _buildProfileImage(),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 4,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _name,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF2D3748),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: _editProfile,
                icon: const Icon(Icons.edit, size: 18, color: Colors.purple),
                label: Text(
                  "Edit Profil",
                  style: GoogleFonts.poppins(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    if (_webImage != null) {
      return ClipOval(
        child: Image.memory(
          _webImage!,
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return const Center(
        child: Icon(Icons.person, size: 60, color: Colors.white),
      );
    }
  }
}
