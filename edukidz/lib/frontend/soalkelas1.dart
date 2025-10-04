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
      title: 'Latihan Soal Kelas 1',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const LatihanSoalPage(),
    );
  }
}

class LatihanSoalPage extends StatefulWidget {
  const LatihanSoalPage({super.key});

  @override
  State<LatihanSoalPage> createState() => _LatihanSoalPageState();
}

class _LatihanSoalPageState extends State<LatihanSoalPage> {
  List<Map<String, dynamic>> soal = [
    {
      'pertanyaan': 'Gambar seorang anak sedang bermain bola. Apa yang sedang dilakukan anak itu?',
      'opsi': ['Membaca buku', 'Bermain bola', 'Menulis di papan', 'Menggambar'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Gambar seekor kucing sedang makan. Kalimat yang tepat untuk gambar tersebut adalah:',
      'opsi': ['Kucing itu sedang tidur.', 'Kucing itu sedang berlari.', 'Kucing itu sedang makan.', 'Kucing itu sedang mandi.'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Gambar seorang anak sedang membaca buku. Pilih jawaban yang benar:',
      'opsi': ['Anak itu sedang bermain bola.', 'Anak itu sedang membaca buku.', 'Anak itu sedang berlari.', 'Anak itu sedang makan.'],
      'jawaban': 1,
    },
    {
      'pertanyaan': "Gambar buah apel. Kata yang sesuai dengan huruf awal 'A' adalah:",
      'opsi': ['Bola', 'Apel', 'Ikan', 'Ular'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Susun kalimat berikut menjadi kalimat yang benar: sore – bermain – Dia – lari',
      'opsi': ['Dia bermain sore lari.', 'Lari dia sore bermain.', 'Dia bermain lari sore.', 'Dia bermain lari sore.'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Apa arti dari tanda “+” dalam matematika?',
      'opsi': ['Mengurangkan', 'Mengalikan', 'Menambah', 'Membagi'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Jika ada 3 apel dan 2 apel lagi, berapa jumlah total apelnya?',
      'opsi': ['4', '5', '6', '3'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Gambar 4 jeruk dan 1 jeruk ditambahkan. Berapa hasilnya?',
      'opsi': ['3 jeruk', '4 jeruk', '5 jeruk', '6 jeruk'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Hitung: 2 + 4 = …',
      'opsi': ['5', '6', '7', '8'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Urutkan langkah penjumlahan yang benar:\nTotal hasil\nHitung objek kedua\nHitung objek pertama',
      'opsi': ['3 → 2 → 1', '2 → 3 → 1', '1 → 2 → 3', '1 → 3 → 2'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Frasa sapaan apa yang biasa digunakan pada pagi hari dalam bahasa Inggris?',
      'opsi': ['Good night', 'Good morning', 'Hello night', 'Good afternoon'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Bagaimana cara merespon jika seseorang bertanya "How are you?"',
      'opsi': ['Good morning', 'See you', 'I’m fine, thank you', 'Goodbye'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Pilihan yang merupakan greeting umum ketika bertemu teman adalah:',
      'opsi': ['Goodbye', 'Hello', 'I’m fine', 'Thank you'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Kalimat “Good night” digunakan untuk:',
      'opsi': ['Menyambut pagi', 'Mengucapkan selamat siang', 'Mengucapkan selamat tidur', 'Menyapa pada sore hari'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Jika kamu ingin menghentikan percakapan, kamu bisa mengucapkan:',
      'opsi': ['Goodbye', 'Hello', 'How are you?', 'I’m fine'],
      'jawaban': 0,
    },
  ];

  Map<int, int> jawabanUser = {};

  void cekJawaban(int indexSoal, int indexJawaban) {
    final bool benar = soal[indexSoal]['jawaban'] == indexJawaban;

    setState(() {
      jawabanUser[indexSoal] = indexJawaban;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(benar ? 'Jawaban benar!' : 'Jawaban salah!'),
        backgroundColor: benar ? Colors.green : Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> simpanSemuaJawaban() async {
    for (var entry in jawabanUser.entries) {
      final indexSoal = entry.key;
      final indexJawaban = entry.value;
      final benar = soal[indexSoal]['jawaban'] == indexJawaban;

      await FirebaseFirestore.instance.collection('soal1').add({
        'soal_index': indexSoal,
        'jawaban': indexJawaban,
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
        title: const Text("Latihan Soal Kelas 1"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
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
                            cekJawaban(index, value!);
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
