import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SurahAyahDialog extends StatefulWidget {
  final Function(int surahNo, String surahName, int ayahNo)? onSelected;

  const SurahAyahDialog({super.key, this.onSelected});

  @override
  State<SurahAyahDialog> createState() => _SurahAyahDialogState();
}

class _SurahAyahDialogState extends State<SurahAyahDialog> {
  List<Map<String, dynamic>> surahs = [];
  bool loading = true;

  Map<String, dynamic>? selectedSurah;
  int? selectedAyahNo;

  @override
  void initState() {
    super.initState();
    fetchSurahs();
  }

  Future<void> fetchSurahs() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('surdata')
        .orderBy('رقم السورة')
        .get();

    surahs = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'SurahNo': data['رقم السورة'],
        'SurahName': data['اسم السورة'],
        'AyatNo': data['عدد الآيات'],
      };
    }).toList();

    setState(() {
      loading = false;
    });
  }

  List<int> getAyahNumbers(int ayatCount) {
    return List.generate(ayatCount, (i) => i + 1);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Text('اختيار سورة وآية'),
      content: loading
          ? const SizedBox(
          height: 100, child: Center(child: CircularProgressIndicator()))
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownSearch<Map<String, dynamic>>(
            items: surahs,
            itemAsString: (item) =>
            "${item['SurahNo']}. ${item['SurahName']}",
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "اختر السورة",
                border: OutlineInputBorder(),
              ),
            ),
            popupProps: const PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  labelText: 'بحث',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                selectedSurah = value;
                selectedAyahNo = null;
              });
            },
          ),
          const SizedBox(height: 15),
          if (selectedSurah != null)
            DropdownSearch<int>(
              items:
              getAyahNumbers(selectedSurah!['AyatNo'] as int),
              selectedItem: selectedAyahNo,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "اختر رقم الآية",
                  border: OutlineInputBorder(),
                ),
              ),
              popupProps: const PopupProps.menu(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    labelText: 'بحث',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              onChanged: (value) {
                selectedAyahNo = value;
              },
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedSurah != null && selectedAyahNo != null) {
              widget.onSelected?.call(
                selectedSurah!['SurahNo'] as int,
                selectedSurah!['SurahName'] as String,
                selectedAyahNo!,
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('تأكيد'),
        ),
      ],
    );
  }
}
