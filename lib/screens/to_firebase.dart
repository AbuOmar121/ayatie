import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _loadAndUploadCSV(BuildContext context) async {
    try {
      // Load CSV from assets
      final csvString = await rootBundle.loadString('assets/dataset.csv');
      final List<List<dynamic>> csvData =
      const CsvToListConverter().convert(csvString);

      final headers = csvData.first;
      final rows = csvData.skip(1);

      // Optional: delete existing data
      final collection = FirebaseFirestore.instance.collection('quraan');
      final snapshots = await collection.get();
      for (final doc in snapshots.docs) {
        await doc.reference.delete();
      }

      // Upload new data
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (final row in rows) {
        Map<String, dynamic> data = {};
        for (int i = 0; i < headers.length; i++) {
          data[headers[i].toString()] = row[i];
        }
        batch.set(collection.doc(), data);
      }
      await batch.commit();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CSV data uploaded to Firestore!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: \$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CSV to Firestore')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => _loadAndUploadCSV(context),
          icon: const Icon(Icons.upload_file),
          label: const Text("Upload CSV from Assets"),
        ),
      ),
    );
  }
}
