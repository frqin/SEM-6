import 'package:flutter/material.dart';

class LatihanSoalPage5 extends StatefulWidget {
  const LatihanSoalPage5({super.key});

  @override
  State<LatihanSoalPage5> createState() => _LatihanSoalPage5State();
}

class _LatihanSoalPage5State extends State<LatihanSoalPage5> {
  final List<Map<String, dynamic>> soal = [
    {
      'pertanyaan': 'Apa itu 3D Modeling?',
      'opsi': ['Teknik menggambar 2D', 'Teknik membuat objek tiga dimensi', 'Edit video', 'Desain web'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Langkah pertama membuat karakter 3D?',
      'opsi': ['Rendering', 'Rigging', 'Modeling', 'Compositing'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Software populer untuk desain 3D?',
      'opsi': ['Adobe XD', 'Figma', 'Blender', 'Photoshop'],
      'jawaban': 2,
    },
  ];

  Map<int, int> jawabanUser = {};

  void cekJawaban(int indexSoal, int indexJawaban) {
    setState(() {
      jawabanUser[indexSoal] = indexJawaban;
    });
    bool benar = soal[indexSoal]['jawaban'] == indexJawaban;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(benar ? 'Jawaban Benar!' : 'Jawaban Salah!'),
        backgroundColor: benar ? Colors.green : Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latihan Soal"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: soal.length,
        itemBuilder: (context, index) {
          final item = soal[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Soal ${index + 1}: ${item['pertanyaan']}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(item['opsi'].length, (i) {
                    final isSelected = jawabanUser[index] == i;
                    return ListTile(
                      title: Text(item['opsi'][i]),
                      leading: Radio<int>(
                        value: i,
                        groupValue: jawabanUser[index],
                        onChanged: (value) {
                          if (jawabanUser[index] == null) {
                            cekJawaban(index, value!);
                          }
                        },
                      ),
                      tileColor: isSelected
                          ? (i == item['jawaban'] ? Colors.green[100] : Colors.red[100])
                          : null,
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
