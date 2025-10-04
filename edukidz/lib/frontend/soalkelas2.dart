import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Soal Kelas 2',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const LatihanSoalKelas2(),
    );
  }
}

class LatihanSoalKelas2 extends StatefulWidget {
  const LatihanSoalKelas2({super.key});

  @override
  State<LatihanSoalKelas2> createState() => _LatihanSoalKelas2State();
}

class _LatihanSoalKelas2State extends State<LatihanSoalKelas2> {
  final List<Map<String, dynamic>> soal = [
    {
      'pertanyaan': 'Apa tema utama yang dijelaskan dalam video?',
      'opsi': ['Bentuk dan jenis kata', 'Berbagai perasaan', 'Kata tanya', 'Lingkungan sekitar'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Dari pilihan berikut, mana termasuk contoh kalimat menyatakan perasaan sedih?',
      'opsi': [
        '“Aku sangat senang hari ini.”',
        '“Aku merasa sedih karena hujan.”',
        '“Aku lapar sekali.”',
        '“Aku senang bermain.”'
      ],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Kata tanya yang tepat untuk menanyakan tempat adalah …',
      'opsi': ['Siapa', 'Kapan', 'Di mana', 'Mengapa'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Jika anak menyatakan “Aku takut gelap,” maka ia sedang mengungkapkan perasaan …',
      'opsi': ['bahagia', 'marah', 'sedih', 'takut'],
      'jawaban': 3,
    },
    {
      'pertanyaan': '“Aku senang sekali saat bermain bola” kalimat ini termasuk …',
      'opsi': ['Kalimat tanya', 'Kalimat perintah', 'Kalimat perasaan', 'Kalimat berita'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Hitunglah: 7 + 8 = ...',
      'opsi': ['14', '15', '16', '17'],
      'jawaban': 3,
    },
    {
      'pertanyaan': '12 − 5 sama dengan ...',
      'opsi': ['6', '7', '8', '9'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Bentuk bangun berikut ini yang memiliki 4 sisi sama panjang dan 4 sudut siku-siku adalah …',
      'opsi': ['Persegi panjang', 'Persegi', 'Segitiga', 'Lingkaran'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Jika kita memiliki 3 kelompok apel, masing-masing 4 buah, jumlah apel keseluruhan adalah …',
      'opsi': ['7', '12', '10', '14'],
      'jawaban': 1,
    },
    {
      'pertanyaan':
      'Mana operasi matematika yang tepat untuk soal: “Tina punya 10 permen. Ia memberi 3 kepada teman. Berapa sisa permennya?”',
      'opsi': ['10 + 3', '10 − 3', '10 × 3', '10 ÷ 3'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Apa arti kata “good morning”?',
      'opsi': ['Selamat malam', 'Halo teman', 'Selamat pagi', 'Selamat tinggal'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Bagaimana cara menanyakan “Apa kabarmu?” dalam bahasa Inggris yang tepat?',
      'opsi': [
        'What is your name?',
        'How are you?',
        'Where are you?',
        'When is your birthday?'
      ],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Jawaban yang biasa digunakan untuk menjawab “How are you?” adalah …',
      'opsi': [
        'I am nine years old.',
        'I am fine, thank you.',
        'I am from Indonesia.',
        'I am hungry.'
      ],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Untuk memperkenalkan diri, kita menggunakan kalimat …',
      'opsi': ['My name is …', 'I am happy.', 'Good evening.', 'I like apple.'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Jika seseorang berkata “Good night,” maka yang tepat dibalas adalah …',
      'opsi': ['Hello', 'Thank you', 'Good night', 'Goodbye'],
      'jawaban': 2,
    },
  ];

  Map<int, int> jawaban = {};

  void cekJawaban(int indexSoal, int indexJawaban) {
    final benar = soal[indexSoal]['jawaban'] == indexJawaban;
    setState(() {
      jawaban[indexSoal] = indexJawaban;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(benar ? 'Jawaban kamu BENAR 🎉' : 'Jawaban kamu SALAH ❌'),
        backgroundColor: benar ? Colors.green : Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> simpanSemuaJawaban() async {
    for (var entry in jawaban.entries) {
      final indexSoal = entry.key;
      final indexJawaban = entry.value;

      await FirebaseFirestore.instance.collection('soal2').add({
        'jawaban': soal[indexSoal]['opsi'][indexJawaban],
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Jawaban berhasil disimpan'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text("Soal Kelas 2"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: soal.length,
        itemBuilder: (context, index) {
          final item = soal[index];
          return TweenAnimationBuilder(
            tween: Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ),
            duration: Duration(milliseconds: 500 + (index * 100)),
            builder: (context, Offset offset, child) {
              return Transform.translate(
                offset: offset * 50,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: 1,
                  child: child,
                ),
              );
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Soal ${index + 1}",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['pertanyaan'],
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ...List.generate(item['opsi'].length, (i) {
                      final isSelected = jawaban[index] == i;
                      final isCorrect = item['jawaban'] == i;
                      Color? tileColor;
                      if (isSelected) {
                        tileColor = isCorrect ? Colors.green[100] : Colors.red[100];
                      }

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: tileColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? (isCorrect ? Colors.green : Colors.red)
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: RadioListTile<int>(
                          title: Text(
                            item['opsi'][i],
                            style: GoogleFonts.poppins(),
                          ),
                          value: i,
                          groupValue: jawaban[index],
                          activeColor: Colors.deepPurple,
                          onChanged: (value) {
                            if (jawaban[index] == null) {
                              cekJawaban(index, value!);
                            }
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: simpanSemuaJawaban,
        icon: const Icon(Icons.save),
        label: const Text("Simpan"),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
