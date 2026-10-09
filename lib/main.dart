
import 'package:flutter/material.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatefulWidget {
  const MiniKatalogApp({super.key});

  @override
  State<MiniKatalogApp> createState() => _MiniKatalogAppState();
}

class _MiniKatalogAppState extends State<MiniKatalogApp> {
  final List<Map<String, dynamic>> sepetUrunleri = [];

  void sepeteEkle(Map<String, dynamic> urun) {
    setState(() {
      sepetUrunleri.add(urun);
    });
  }

  void sepettenSil(int index) {
    setState(() {
      sepetUrunleri.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Katalog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
         seedColor: const Color(0xFF8D6E63),
        ),
        useMaterial3: true,
      ),
      home: AnaSayfa(
        sepeteEkle: sepeteEkle,
        sepetUrunleri: sepetUrunleri,
        sepettenSil: sepettenSil,
      ),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  final void Function(Map<String, dynamic>) sepeteEkle;
  final List<Map<String, dynamic>> sepetUrunleri;
  final void Function(int) sepettenSil;

  const AnaSayfa({
    super.key,
    required this.sepeteEkle,
    required this.sepetUrunleri,
    required this.sepettenSil,
  });

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  
final List<Map<String, dynamic>> urunler = [
  {
    'isim': 'Basic Tişört',
    'fiyat': 399,
    'ikon': Icons.checkroom,
    'aciklama': 'Günlük kullanım için rahat ve şık basic tişört.',
    'kategori': 'Giyim',
  },
  {
    'isim': 'Örgü Kazak',
    'fiyat': 899,
    'ikon': Icons.dry_cleaning,
    'aciklama': 'Serin havalar için yumuşak ve rahat örgü kazak.',
    'kategori': 'Giyim',
  },
  {
    'isim': 'Kot Pantolon',
    'fiyat': 1199,
    'ikon': Icons.straighten,
    'aciklama': 'Günlük kombinler için modern kesimli kot pantolon.',
    'kategori': 'Giyim',
  },
  {
    'isim': 'Omuz Çantası',
    'fiyat': 1499,
    'ikon': Icons.shopping_bag,
    'aciklama': 'Günlük kombinlerinizi tamamlayan şık omuz çantası.',
    'kategori': 'Çanta ve Aksesuar',
  },
  {
    'isim': 'Güneş Gözlüğü',
    'fiyat': 699,
    'ikon': Icons.wb_sunny,
    'aciklama': 'Tarzınızı tamamlayan modern güneş gözlüğü.',
    'kategori': 'Çanta ve Aksesuar',
  },
  {
    'isim': 'Kolye',
    'fiyat': 499,
    'ikon': Icons.diamond,
    'aciklama': 'Kombinlerinize zarif bir dokunuş katan kolye.',
    'kategori': 'Çanta ve Aksesuar',
  },
  {
    'isim': 'Spor Ayakkabı',
    'fiyat': 1799,
    'ikon': Icons.directions_run,
    'aciklama': 'Günlük yürüyüşler ve rahat kombinler için spor ayakkabı.',
    'kategori': 'Ayakkabı',
  },
  {
    'isim': 'Elbise',
    'fiyat': 1299,
    'ikon': Icons.woman,
    'aciklama': 'Özel günlerde ve günlük kullanımda tercih edilebilecek elbise.',
    'kategori': 'Giyim',
  },
];

  String aramaMetni = '';
  
  String seciliKategori = 'Tümü';

  @override
  Widget build(BuildContext context) {
    
final filtrelenmisUrunler = urunler.where((urun) {
  final isimUyuyor = urun['isim']
      .toString()
      .toLowerCase()
      .contains(aramaMetni.trim().toLowerCase());

  final kategoriUyuyor = seciliKategori == 'Tümü' ||
      urun['kategori'] == seciliKategori;

  return isimUyuyor && kategoriUyuyor;
}).toList();

    return Scaffold(
      appBar: AppBar(
       
title: const Text(
  'MODA KATALOĞU',
  style: TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  ),
),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Sepetim',
            icon: Badge(
              label: Text('${widget.sepetUrunleri.length}'),
              isLabelVisible: widget.sepetUrunleri.isNotEmpty,
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SepetSayfasi(
                    sepetUrunleri: widget.sepetUrunleri,
                    sepettenSil: widget.sepettenSil,
                  ),
                ),
              ).then((_) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tarzını Keşfet ✨',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tarzını tamamlayan parçalar burada.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ürün ara...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: aramaMetni.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            aramaMetni = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (deger) {
                setState(() {
                  aramaMetni = deger;
                });
              },
            ),

            
SizedBox(
  height: 42,
  child: ListView(
    scrollDirection: Axis.horizontal,
    children: 
['Tümü', 'Giyim', 'Çanta ve Aksesuar', 'Ayakkabı']
        .map((kategori) {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          label: Text(kategori),
          selected: seciliKategori == kategori,
          onSelected: (secildi) {
            setState(() {
              seciliKategori = kategori;
            });
          },
        ),
      );
    }).toList(),
  ),
),
const SizedBox(height: 16),



            const SizedBox(height: 24),
            const Text(
              'Ürünler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: filtrelenmisUrunler.isEmpty
                  ? const Center(
                      child: Text('Aradığınız ürün bulunamadı.'),
                    )
                  : GridView.builder(
                      itemCount: filtrelenmisUrunler.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final urun = filtrelenmisUrunler[index];

                       
return Card(
  elevation: 4,
  shadowColor: const Color(0xFFD7C2B7),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18),
  ),
  clipBehavior: Clip.antiAlias,
  child: Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFFF3E8DF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            urun['ikon'] as IconData,
            size: 40,
           color: const Color(0xFF8D6E63),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          urun['isim'].toString(),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${urun['fiyat']} TL',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF8D6E63),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UrunDetaySayfasi(
                    urun: urun,
                    sepeteEkle: widget.sepeteEkle,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8D6E63),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Detayları Gör'),
          ),
        ),
      ],
    ),
  ),
);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class UrunDetaySayfasi extends StatelessWidget {
  final Map<String, dynamic> urun;
  final void Function(Map<String, dynamic>) sepeteEkle;

  const UrunDetaySayfasi({
    super.key,
    required this.urun,
    required this.sepeteEkle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
appBar: AppBar(
  backgroundColor: const Color(0xFF8D6E63),
  foregroundColor: Colors.white,
  title: const Text('Ürün Detayı'),
),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
Icon(
  urun['ikon'] as IconData,
  size: 100,
  color: const Color(0xFF8D6E63),
),
              const SizedBox(height: 24),
              Text(
                urun['isim'].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${urun['fiyat']} TL',
                style: const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Color(0xFF8D6E63),
),
              ),
              const SizedBox(height: 24),
              Text(
                urun['aciklama'].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                style: FilledButton.styleFrom(
  backgroundColor: const Color(0xFF8D6E63),
  foregroundColor: Colors.white,
),
                onPressed: () {
                  sepeteEkle(urun);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ürün sepete eklendi!'),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Sepete Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SepetSayfasi extends StatefulWidget {
  final List<Map<String, dynamic>> sepetUrunleri;
  final void Function(int) sepettenSil;

  const SepetSayfasi({
    super.key,
    required this.sepetUrunleri,
    required this.sepettenSil,
  });

  @override
  State<SepetSayfasi> createState() => _SepetSayfasiState();
}

class _SepetSayfasiState extends State<SepetSayfasi> {
  @override
  Widget build(BuildContext context) {
    final toplamFiyat = widget.sepetUrunleri.fold<int>(
      0,
      (toplam, urun) => toplam + (urun['fiyat'] as int),
    );

    return Scaffold(
      appBar: AppBar(
  backgroundColor: const Color(0xFF8D6E63),
  foregroundColor: Colors.white,
  title: const Text('Sepetim'),
),
      body: widget.sepetUrunleri.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
  Icons.shopping_cart_outlined,
  size: 70,
  color: const Color(0xFF8D6E63),
),
                  SizedBox(height: 16),
                  Text(
                    'Sepetiniz boş.',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.sepetUrunleri.length,
                    itemBuilder: (context, index) {
                      final urun = widget.sepetUrunleri[index];

                      return ListTile(
                        leading: Icon(
  urun['ikon'] as IconData,
  size: 35,
  color: const Color(0xFF8D6E63),
),
                        title: Text(
  urun['isim'].toString(),
  style: const TextStyle(fontWeight: FontWeight.bold),
),
                        subtitle: Text('${urun['fiyat']} TL'),
                        trailing: IconButton(
                          icon: const Icon(
  Icons.delete_outline,
  color: Color(0xFF8D6E63),
),
                          tooltip: 'Sepetten çıkar',
                          onPressed: () {
                            widget.sepettenSil(index);
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),
               
Padding(
  padding: const EdgeInsets.all(20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Toplam:',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8D6E63),
        ),
      ),
      Text(
        '$toplamFiyat TL',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8D6E63),
        ),
      ),
    ],
  ),
),
              ],
            ),
    );
  }
}