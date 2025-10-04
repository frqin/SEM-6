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
      title: 'Soal Kelas 3',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const LatihanSoalPage3(),
    );
  }
}

class LatihanSoalPage3 extends StatefulWidget {
  const LatihanSoalPage3({super.key});

  @override
  State<LatihanSoalPage3> createState() => _LatihanSoalPage3State();
}

class _LatihanSoalPage3State extends State<LatihanSoalPage3> {
  final List<Map<String, dynamic>> soal = [
    {
      'pertanyaan': 'Siapa dua karakter utama yang diperkenalkan di awal video?',
      'opsi': ['Dafa dan Lulu', 'Dira dan Cika', 'Dafa dan Cika', 'Lulu dan Dira'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Topik pembelajaran utama dalam video ini adalah mengenali ...',
      'opsi': ['Unsur subjek dan predikat', 'Jenis-jenis kalimat', 'Kata depan', 'Sinonim dan antonim'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Subjek dalam sebuah kalimat biasanya berupa ...',
      'opsi': ['Kata kerja', 'Orang atau benda yang melakukan aksi', 'Tempat kejadian', 'Waktu'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Kalimat “Dira menulis tugas” memiliki subjek “Dira” dan predikat ...',
      'opsi': ['tugas', 'menulis', 'Dira', 'menulis tugas'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Predikat dalam kalimat berfungsi untuk menjelaskan ...',
      'opsi': ['Siapa pelakunya', 'Apa yang dilakukan subjek', 'Dimana lokasi', 'Kapan waktu kejadian'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Apa pengertian bilangan pecahan?',
      'opsi': [
        'Bilangan yang lebih besar dari satu',
        'Bagian dari keseluruhan atau hasil pembagian suatu benda menjadi bagian-bagian sama besar',
        'Bilangan yang tidak dapat ditulis dalam bentuk desimal',
        'Hasil penjumlahan dua bilangan bulat'
      ],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Dalam pecahan, yang membagi keseluruhan disebut …',
      'opsi': ['Pembilang', 'Penyebut', 'Hasil', 'Pembalik'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Jika sebuah kue dibagi menjadi 4 potong sama besar dan kita mengambil 1 potong, nilai pecahannya adalah …',
      'opsi': ['4/1', '1/4', '1/3', '3/4'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Mana dari berikut ini merupakan pecahan senilai yang tepat?',
      'opsi': ['1/2 = 2/3', '2/4 = 1/2', '3/4 = 6/8', '1/3 = 2/5'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Pecahan mana yang menunjukkan bagian lebih kecil?',
      'opsi': ['1/2', '1/3', '2/3', '3/4'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Apa arti kalimat “I like apples”?',
      'opsi': ['Aku suka apel', 'Aku suka pisang', 'Aku makan apel', 'Aku punya apel'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Bagaimana bentuk tanya dari “You are happy”?',
      'opsi': ['Are you happy?', 'You are happy?', 'You happy are?', 'Is you happy?'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Makna dari “She can swim” adalah …',
      'opsi': ['Dia bisa berenang', 'Dia suka berenang', 'Dia sedang berenang', 'Dia tidak bisa berenang'],
      'jawaban': 0,
    },
    {
      'pertanyaan': '“We go to school” menunjukkan …',
      'opsi': ['Aksi pergi sekarang', 'Aktivitas sehari-hari', 'Perintah kepada orang lain', 'Kemampuan berbicara'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Kalimat “They are my friends” menggunakan “they” untuk menunjukkan …',
      'opsi': ['Satu orang', 'Dua orang atau lebih', 'Anak perempuan', 'Masa depan'],
      'jawaban': 1,
    },
  ];

  Map<int, int> jawabanUser = {};

  void cekJawaban(int indexSoal, int indexJawaban) {
    setState(() {
      jawabanUser[indexSoal] = indexJawaban;
    });

    final benar = soal[indexSoal]['jawaban'] == indexJawaban;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(benar ? 'Jawaban Benar!' : 'Jawaban Salah!'),
        backgroundColor: benar ? Colors.green : Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> simpanKeFirestore() async {
    for (var entry in jawabanUser.entries) {
      final indexSoal = entry.key;
      final indexJawaban = entry.value;
      final benar = soal[indexSoal]['jawaban'] == indexJawaban;

      await FirebaseFirestore.instance.collection('soal3').add({
        'soal_index': indexSoal,
        'jawaban': soal[indexSoal]['opsi'][indexJawaban],
        'status': benar ? 'benar' : 'salah',
        'waktu': FieldValue.serverTimestamp(),
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
        title: const Text("Latihan Soal Kelas 3"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: soal.length,
        itemBuilder: (context, index) {
          final item = soal[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                    final isSelected = jawabanUser[index] == i;
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
                        groupValue: jawabanUser[index],
                        activeColor: Colors.deepPurple,
                        onChanged: (value) {
                          if (jawabanUser[index] == null) {
                            cekJawaban(index, value!);
                          }
                        },
                      ),
                    );
                  })
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: simpanKeFirestore,
        icon: const Icon(Icons.save),
        label: const Text("Simpan"),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
