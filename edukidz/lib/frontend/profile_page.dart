import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'update_profil.dart';

class ProfilePage extends StatefulWidget {
  final String initialName;
  final String initialBio;
  final String initialHobi;
  final Uint8List? profileImage;

  const ProfilePage({
    super.key,
    required this.initialName,
    required this.initialBio,
    required this.initialHobi,
    this.profileImage,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _name;
  late String _bio;
  late String _hobi;
  Uint8List? _webImage;

  @override
  void initState() {
    super.initState();
    _name = widget.initialName;
    _bio = widget.initialBio;
    _hobi = widget.initialHobi;
    _webImage = widget.profileImage;
  }

  Future<void> _editProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfilPage(
          initialName: _name,
          initialBio: _bio,
          initialHobi: _hobi,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _name = result['name'] ?? _name;
        _bio = result['bio'] ?? _bio;
        _hobi = result['hobby'] ?? _hobi;
      });
    }
  }

  void _goBack() {
    Navigator.pop(context, {
      'name': _name,
      'bio': _bio,
      'hobby': _hobi,
      'image': _webImage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                onPressed: _goBack,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Container(
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
            Text(
              _bio.isNotEmpty ? _bio : 'Belum ada bio',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _hobi.isNotEmpty ? 'Hobi: $_hobi' : 'Hobi: -',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
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
