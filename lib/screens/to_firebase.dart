import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:csv/csv.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CSV to Firestore',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '(JUST FOR DEVELOPER)',
              style: TextStyle(
                color: Color(0xFFFF0000),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 16,),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  // 1. اقرأ المحتوى من assets
                  final csvContent = await rootBundle.loadString('assets/dataset.csv');

                  // 2. خزّنه مؤقتًا
                  final dir = await getTemporaryDirectory();
                  final file = File('${dir.path}/dataset.csv');
                  await file.writeAsString(csvContent);

                  // 3. ارفع الملف للسيرفر
                  var uri = Uri.parse("http://10.0.2.2:8080/api/csv/upload");

                  var request = http.MultipartRequest('POST', uri);
                  request.files.add(await http.MultipartFile.fromPath('file', file.path));
                  var response = await request.send();

                  if (response.statusCode == 200) {
                    print("✔️ Upload successful");
                  } else {
                    print("❌ Upload failed with status: ${response.statusCode}");
                  }
                } catch (e) {
                  print('❌ Error uploading CSV: $e');
                }
              },
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload CSV from Assets"),
            ),
            SizedBox(height: 16,),
            Text(
              'ممكن يخرب اذا كبست',
              style: TextStyle(
                color: Color(0xFFFF0000),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 16,),
            Text(
              'لغايات البرمجة فقط',
              style: TextStyle(
                color: Color(0xFFFF0000),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
