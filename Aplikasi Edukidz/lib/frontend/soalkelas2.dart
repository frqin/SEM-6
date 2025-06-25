import 'package:flutter/material.dart';

class LatihanSoalPage2 extends StatefulWidget {
  const LatihanSoalPage2({super.key});

  @override
  State<LatihanSoalPage2> createState() => _LatihanSoalPage2State();
}

class _LatihanSoalPage2State extends State<LatihanSoalPage2> {
  final List<Map<String, dynamic>> soal = [
    {
      'pertanyaan': 'Berapa hasil dari 5 + 3?',
      'opsi': ['6', '7', '8', '9'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Apa ibu kota Indonesia?',
      'opsi': ['Bandung', 'Jakarta', 'Surabaya', 'Medan'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Hewan yang hidup di air adalah...',
      'opsi': ['Kucing', 'Burung', 'Ikan', 'Sapi'],
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
        title: const Text("Latihan Soal Kelas 2"),
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
