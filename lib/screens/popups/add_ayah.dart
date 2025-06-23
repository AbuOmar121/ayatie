import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase/models/ayat_model.dart';
import 'package:flutter_application_2/firebase/services/ayat_service.dart';

void showAddAyahDialog(BuildContext context, {Function? onSuccess}) {
  final TextEditingController _controller = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text('إضافة الآية'),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'اسم التصنيف',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('إلغاء'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('إضافة'),
            onPressed: () async {
              final cname = _controller.text.trim();
              if (cname.isNotEmpty) {
                final newCluster = Ayat(aid: '',ayahNo: 0,surahNo: 0);
                await AyatService().addCluster(newCluster);

                Navigator.of(context).pop();

                if (onSuccess != null) {
                  onSuccess(); // to reload list or do something after adding
                }
              }
            },
          ),
        ],
      );
    },
  );
}
