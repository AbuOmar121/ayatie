import 'package:cloud_firestore/cloud_firestore.dart';

class Ayat {
  final String aid;
  final int surahNo;
  final int ayahNo;

  Ayat({
    required this.aid,
    required this.surahNo,
    required this.ayahNo,
  });

  factory Ayat.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data()!;
    return Ayat(
      aid: snapshot.id,
      surahNo: data['surahNo'] ?? '',
      ayahNo: data['ayahNo'] ?? '',
    );
  }

  factory Ayat.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.data() is Map<String, dynamic>) {
      return Ayat.fromFirestore(
        snapshot as DocumentSnapshot<Map<String, dynamic>>,
        null,
      );
    }
    throw ArgumentError('Document data is not a Map<String, dynamic>');
  }

  Map<String, dynamic> toMap() {
    return {
      'surahNo': surahNo,
      'ayahNo': ayahNo,
    };
  }
}
