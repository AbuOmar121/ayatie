import 'package:flutter/material.dart';
import 'package:flutter_application_2/backend/spring/models/ayat_model.dart';
import 'package:flutter_application_2/backend/spring/services/ayat_service.dart';

class AyatListScreen extends StatefulWidget {
  const AyatListScreen({super.key});

  @override
  State<AyatListScreen> createState() => _AyatListScreenState();
}

class _AyatListScreenState extends State<AyatListScreen> {
  final ayatService = AyatService();
  late Future<List<Ayat>> futureAyat;

  @override
  void initState() {
    super.initState();
    futureAyat = ayatService.getAllAyat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayat List')),
      body: FutureBuilder<List<Ayat>>(
        future: futureAyat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Ayat found'));
          } else {
            final ayatList = snapshot.data!;
            return ListView.builder(
              itemCount: ayatList.length,
              itemBuilder: (context, index) {
                final ayah = ayatList[index];
                return ListTile(
                  title: Text('Surah ${ayah.surahNo}, Ayah ${ayah.ayahNo}'),
                  subtitle: Text('Cluster: ${ayah.cid}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
