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
      title: 'Soal Kelas 5',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const LatihanSoalPage5(),
    );
  }
}

class LatihanSoalPage5 extends StatefulWidget {
  const LatihanSoalPage5({super.key});

  @override
  State<LatihanSoalPage5> createState() => _LatihanSoalPage5State();
}

class _LatihanSoalPage5State extends State<LatihanSoalPage5> {
  final List<Map<String, dynamic>> soal = [
    {
      'pertanyaan': 'Puisi akrostik adalah...',
      'opsi': [
        'Puisi dengan rima tetap',
        'Puisi yang setiap awal baris membentuk kata/peristiwa penting',
        'Puisi bebas tanpa aturan',
        'Puisi menggunakan syair lama'
      ],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Contoh judul puisi akrostik “UNIK” berarti…',
      'opsi': [
        'Ular Naga Indah Kuning',
        'Unta Nakal Iseng Kocak',
        'Unik Nama Indah Kamu',
        'Unggul Nampak Istimewa Kita'
      ],
      'jawaban': 3,
    },
    {
      'pertanyaan': 'Di puisi akrostik “AKU”, setiap huruf pertama baris puisi akan mengeja kata…',
      'opsi': [
        'UKA',
        'AKA',
        'AKU',
        'UAK'
      ],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Huruf kapital di awal baris puisi akrostik berfungsi untuk…',
      'opsi': [
        'Memperindah sajak',
        'Menandai huruf kunci',
        'Memperpanjang bait',
        'Menyambung rima'
      ],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Kata sifat (adjektiva) adalah kata yang…',
      'opsi': [
        'Menunjukkan waktu',
        'Menerangkan kata benda',
        'Menunjukkan kepemilikan',
        'Menggantikan subjek'
      ],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Kalimat “Baju itu sangat cantik” – kata “cantik” termasuk…',
      'opsi': [
        'Kata kerja',
        'Kata benda',
        'Kata sifat',
        'Kata tugas'
      ],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Manakah dari berikut ini bukan kata sifat?',
      'opsi': [
        'Indah',
        'Lincah',
        'Berlari',
        'Cepat'
      ],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Kalimat “Ibu membeli mobil baru” – kata “baru” menjelaskan…',
      'opsi': [
        'Subjek',
        'Objek',
        'Kata kerja',
        'Keterangan tempat'
      ],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Dalam puisi akrostik “UNIQUES”, puisi itu akan…',
      'opsi': [
        'Tiap baris huruf terakhir membentuk "UNIQUES"',
        'Tiap baris awal membentuk kata “UNIQUES”',
        'Menyebutkan satu huruf secara acak',
        'Tidak menggunakan huruf kapital'
      ],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Kalimat “Anak itu sangat rajin dan cerdas” – kata “rajin” dan “cerdas” adalah…',
      'opsi': [
        'Kata kerja',
        'Kata sifat',
        'Kata bilangan',
        'Kata ganti'
      ],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Bilangan desimal 3,75 berada di antara dua bilangan bulat, yaitu...',
      'opsi': ['3 dan 4', '2 dan 3', '4 dan 5', '3 dan 5'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Jika kita menambahkan 0,25 + 0,5, hasilnya adalah...',
      'opsi': ['0,75', '0,65', '0,85', '0,95'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Urutkan bilangan desimal dari terkecil ke terbesar: 2,4 – 2,04 – 2,400 – 2,041. Urutannya yang benar adalah...',
      'opsi': [
        '2,04 – 2,041 – 2,4 – 2,400',
        '2,04 – 2,4 – 2,041 – 2,400',
        '2,041 – 2,04 – 2,400 – 2,4',
        '2,4 – 2,040 – 2,041 – 2,400'
      ],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Dalam penulisan bilangan 7,305, angka 3 menunjukkan nilai...',
      'opsi': ['Tiga persepuluh', 'Tiga persepuluh ribu', 'Tiga perseratus', 'Tiga perseribu'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Hasil dari pengurangan: 5,6 – 2,75 adalah...',
      'opsi': ['2,85', '3,35', '2,75', '3,5'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Jika bilangan bulat ditambahkan bilangan desimal, misalnya 4 + 1,25 = ...',
      'opsi': ['5,25', '5,15', '5,20', '4,25'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Manakah yang merupakan desimal ekuivalen dari ¾?',
      'opsi': ['0,75', '0,65', '0,85', '0,95'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Hasil dari 6,02 + 3,007 adalah...',
      'opsi': ['9,027', '9,017', '9,027', '9,717'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Bilangan desimal mana yang terbesar?',
      'opsi': ['0,505', '0,55', '0,5005', '0,0555'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Jika kita mengalikan 2,5 × 4, bilangan hasilnya adalah...',
      'opsi': ['10', '8', '6,5', '9,5'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'What is the correct way to say hello in English?',
      'opsi': ['Goodbye', 'Hello', 'Night', 'Sorry'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Bagaimana cara menanyakan keadaan seseorang dengan sopan?',
      'opsi': ['What is your name?', 'How old are you?', 'How are you?', 'Where are you?'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Balasan yang tepat untuk “How are you?” adalah…',
      'opsi': ['I’m ten', 'I’m fine, thank you', 'I’m from school', 'I’m pencil'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Mana yang merupakan kata sapaan informal?',
      'opsi': ['Good morning', 'Hi', 'Good afternoon', 'Good night'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Apa arti dari “My name is Ani”?',
      'opsi': ['Nama saya Ani', 'Saya pergi ke Ani', 'Ani milik saya', 'Ani adalah teman saya'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Kalimat “I am happy” menunjukkan…',
      'opsi': ['Status pekerjaan', 'Perasaan senang', 'Usia', 'Tempat tinggal'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Ungkapan yang bukan termasuk greeting adalah…',
      'opsi': ['Good evening', 'Goodbye', 'Thank you', 'See you'],
      'jawaban': 2,
    },
    {
      'pertanyaan': 'Apa arti dari “See you tomorrow”?',
      'opsi': ['Sampai jumpa besok', 'Sampai jumpa kemarin', 'Sampai jumpa nanti', 'Sampai jumpa sekarang'],
      'jawaban': 0,
    },
    {
      'pertanyaan': 'Kapan biasanya kita menggunakan “Good afternoon”?',
      'opsi': ['Pagi hari', 'Siang hingga sore', 'Malam hari', 'Tengah malam'],
      'jawaban': 1,
    },
    {
      'pertanyaan': 'Bagaimana mengatakan salam perpisahan di malam hari?',
      'opsi': ['Good morning', 'Good night', 'Good afternoon', 'Hello'],
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

      await FirebaseFirestore.instance.collection('soal5').add({
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
        title: const Text("Latihan Soal Kelas 5"),
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
