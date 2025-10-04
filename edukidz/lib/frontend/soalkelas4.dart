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
      title: 'Soal Kelas 4',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const LatihanSoalPage4(),
    );
  }
}

class LatihanSoalPage4 extends StatefulWidget {
  const LatihanSoalPage4({super.key});

  @override
  State<LatihanSoalPage4> createState() => _LatihanSoalPage4State();
}

class _LatihanSoalPage4State extends State<LatihanSoalPage4> {
  final List<Map<String, dynamic>> soal = [
    {
      'pertanyaan': 'Apa tujuan utama dari materi “mengidentifikasi ide pokok” dalam teks?',
      'opsi': ['Menentukan tema umum teks', 'Menemukan kalimat utama tiap paragraf', 'Menyimpulkan cerita', 'Menulis judul teks'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Ciri kalimat utama adalah…',
      'opsi': ['Selalu di paragraf ketiga', 'Mengandung hal paling penting pada paragraf', 'Menggunakan kata depan', 'Singkat dan tidak jelas'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Kalimat berikut termasuk kalimat utama, kecuali…',
      'opsi': ['“Bu Ani sangat rajin memberi tugas.”', '“Setiap sore ia mengajar di perpustakaan.”', '“Dia suka membaca buku lama.”', '“Itu membuat suasana nyaman.”'],
      'jawaban': 3,
    },
    {
      'pertanyaan': 'Apa fungsi kalimat penjelas dalam paragraf?',
      'opsi': ['Mengganti kalimat utama', 'Menambah atau memperjelas informasi kalimat utama', 'Menambahkan judul baru', 'Menyimpulkan keseluruhan teks'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Manakah yang merupakan kalimat penjelas dari kalimat utama “Bu Ani rajin mengajar setiap hari”?',
      'opsi': ['“Ia mengajar sejak pagi hingga sore.”', '“Sekolah itu berada di dekat rumah.”', '“Siswa suka bertanya padanya.”', '“Setiap murid mengerjakan PR.”'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Apa pengertian bilangan pecahan?',
      'opsi': ['Bilangan yang lebih besar dari satu', 'Bagian dari keseluruhan atau hasil pembagian suatu benda menjadi bagian-bagian sama besar', 'Bilangan yang tidak dapat ditulis dalam bentuk desimal', 'Hasil penjumlahan dua bilangan bulat'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Pada halaman 101–102 dibahas diagram garis. Apa fungsi utama diagram garis?',
      'opsi': ['Menunjukkan perubahan data dari waktu ke waktu', 'Menyajikan perbandingan kategori data', 'Menampilkan hubungan antar variabel', 'Mengelompokkan data secara urut'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Jika suatu diagram garis awalnya pada titik (Januari, 20) dan naik ke (Februari, 35), apa yang ditunjukkan?',
      'opsi': ['Data menurun', 'Data naik sekitar 15', 'Data tetap', 'Data tidak dapat dihitung'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Sumbu horizontal pada diagram garis biasa mewakili apa?',
      'opsi': ['Nilai kategori data', 'Waktu atau periode', 'Frekuensi', 'Skala keseluruhan'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Sumbu vertikal pada diagram garis digunakan untuk…',
      'opsi': ['Membagi data', 'Menyusun kategori', 'Menentukan nilai numerik', 'Mengindikasikan urutan waktu'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Apa arti kata “hello”?',
      'opsi': ['Selamat tinggal', 'Halo', 'Apa kabar', 'Terima kasih'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Bagaimana cara merespons “How are you?” secara sopan?',
      'opsi': ['I’m thirty', 'I’m fine, thank you', 'I’m school', 'I’m pencil'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Pilihan yang bukan termasuk kata sapaan (greeting) dalam Bahasa Inggris adalah…',
      'opsi': ['Good morning', 'Goodbye', 'Thank you', 'Good night'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Apa arti dari ungkapan “Thank you”?',
      'opsi': ['Tolong', 'Terima kasih', 'Maaf', 'Selamat'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Jika seseorang mengatakan “Good night”, yang tepat untuk dibalas adalah…',
      'opsi': ['Good afternoon', 'Good morning', 'Good night', 'Hello'],
      'jawaban': 2,
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

      await FirebaseFirestore.instance.collection('soal4').add({
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
        title: const Text("Latihan Soal Kelas 4"),
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