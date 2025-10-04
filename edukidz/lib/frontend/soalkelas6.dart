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
      title: 'Soal Kelas 6',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const LatihanSoalPage6(),
    );
  }
}

class LatihanSoalPage6 extends StatefulWidget {
  const LatihanSoalPage6({super.key});

  @override
  State<LatihanSoalPage6> createState() => _LatihanSoalPage6State();
}

class _LatihanSoalPage6State extends State<LatihanSoalPage6> {
  final List<Map<String, dynamic>> soal = [
    // Soal Bahasa Indonesia
    {
      "pertanyaan": "Apa tema utama pada Tema 6 kelas 6?",
      "opsi": ["Lingkungan dan kebersihan", "Moral dalam cerita", "Peristiwa alam dan bencana", "Teknologi modern"],
      "jawaban": 0
    },
    {
      "pertanyaan": "Salah satu subtema di Tema 6 adalah…",
      "opsi": ["Kebersamaaan di sekolah", "Bencana alam di sekitar kita", "Manfaat teknologi", "Cerita fabel"],
      "jawaban": 1
    },
    {
      "pertanyaan": "Jenis teks yang dibahas di video termasuk…",
      "opsi": ["Cerpen", "Puisi bebas", "Laporan hasil pengamatan", "Biografi"],
      "jawaban": 2
    },
    {
      "pertanyaan": "Apa fungsi utama laporan hasil pengamatan?",
      "opsi": ["Menceritakan pengalaman pribadi", "Menyampaikan data hasil observasi", "Menghibur pembaca", "Memberi nasihat"],
      "jawaban": 1
    },
    {
      "pertanyaan": "Langkah pertama dalam membuat laporan pengamatan adalah…",
      "opsi": ["Menyimpulkan temuan", "Membuat judul laporan", "Menentukan objek dan tujuan observasi", "Mencatat hasil wawancara"],
      "jawaban": 2
    },
    {
      "pertanyaan": "Dalam laporan hasil pengamatan, bagian metode berisi…",
      "opsi": ["Kesimpulan akhir", "Cara atau langkah observasi", "Daftar pustaka", "Ucapan terima kasih"],
      "jawaban": 1
    },
    {
      "pertanyaan": "Bagian hasil dan pembahasan biasanya memuat…",
      "opsi": ["Data observasi dan penjelasan", "Referensi teori", "Estimasi biaya", "Profil penulis"],
      "jawaban": 0
    },
    {
      "pertanyaan": "Salah satu ciri teks laporan hasil pengamatan adalah…",
      "opsi": ["Menggunakan bahasa kiasan", "Disajikan dalam bentuk narasi panjang", "Faktual dan sistematis", "Mengandung dialog imajinatif"],
      "jawaban": 2
    },
    {
      "pertanyaan": "Pada bagian kesimpulan laporan, penulis biasanya…",
      "opsi": ["Menyebut ujung cerita", "Menyampaikan pesan moral", "Menyimpulkan hasil utama observasi", "Mengajak pembaca berdebat"],
      "jawaban": 2
    },
    {
      "pertanyaan": "Menurut video, penulis laporan sebaiknya menyertakan…",
      "opsi": ["Gambar ilustrasi tanpa keterangan", "Data lengkap dan sumber referensi", "Pendapat subjektif penulis", "Cerita pengalaman masa kecil"],
      "jawaban": 1
    },

    // Soal Matematika Pecahan
    {"pertanyaan": "Berapa hasil dari 2/3 × 3/4?", "opsi": ["5/7", "1/2", "1/4", "1/3"], "jawaban": 1},
    {"pertanyaan": "Hitung 5/6 × 2/5.", "opsi": ["5/12", "2/6", "1/3", "1/6"], "jawaban": 2},
    {"pertanyaan": "3/4 × 8 = ?", "opsi": ["6", "24", "4", "2"], "jawaban": 0},
    {"pertanyaan": "Hasil 7/9 × 3/7 adalah…", "opsi": ["3/9", "1/3", "7/21", "21/63"], "jawaban": 1},
    {"pertanyaan": "Jika x = 4/5 × 5/2, nilai x = …", "opsi": ["2", "10/25", "20/10", "1"], "jawaban": 0},
    {"pertanyaan": "6/7 × 14 = …", "opsi": ["12", "18", "24", "14"], "jawaban": 0},
    {"pertanyaan": "Hasil 5/8 × 4/5 =", "opsi": ["5/32", "4/8", "1/2", "1/4"], "jawaban": 2},
    {"pertanyaan": "9/10 × 0,5 = …", "opsi": ["0,45", "4,5", "0,55", "0,9"], "jawaban": 0},
    {"pertanyaan": "Hasil 3 × 2/9 =", "opsi": ["3/2", "2/3", "6/9", "2/27"], "jawaban": 1},
    {"pertanyaan": "Jika kamu mengalikan 7/8 × 2/3, hasilnya adalah…", "opsi": ["14/24", "7/24", "16/11", "14/11"], "jawaban": 0},

    // Soal Bahasa Inggris Past Tense
    {"pertanyaan": "What is the past tense of “go”?", "opsi": ["Go", "Goed", "Went", "Gone"], "jawaban": 2},
    {"pertanyaan": "Choose the correct simple past form of “eat” in the sentence: “She ___ breakfast this morning.”", "opsi": ["Eats", "Ate", "Eaten", "Eating"], "jawaban": 1},
    {"pertanyaan": "Which sentence is in simple past tense?", "opsi": ["He writes a letter.", "He wrote a letter.", "He will write a letter.", "He is writing a letter."], "jawaban": 1},
    {"pertanyaan": "Past tense of “make” is…", "opsi": ["Maked", "Made", "Make", "Making"], "jawaban": 1},
    {"pertanyaan": "Complete the sentence: “They ___ a movie yesterday.”", "opsi": ["watch", "watches", "watched", "watching"], "jawaban": 2},
    {"pertanyaan": "What is the past form of “see”?", "opsi": ["See", "Saw", "Seen", "Seed"], "jawaban": 1},
    {"pertanyaan": "Fill in: “I ___ my homework last night.”", "opsi": ["do", "did", "done", "doing"], "jawaban": 1},
    {"pertanyaan": "Which is correct?", "opsi": ["She buyed a book.", "She bought a book.", "She buy a book.", "She buys a book."], "jawaban": 1},
    {"pertanyaan": "Past tense of “run” is…", "opsi": ["Run", "Runned", "Ran", "Running"], "jawaban": 2},
    {"pertanyaan": "Choose the correct past form: “We ___ to the park last weekend.”", "opsi": ["go", "went", "gone", "going"], "jawaban": 1},
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

      await FirebaseFirestore.instance.collection('soal6').add({
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
        title: const Text("Latihan Soal Kelas 6"),
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
