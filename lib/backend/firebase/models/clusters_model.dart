import 'package:cloud_firestore/cloud_firestore.dart';

class Clusters {
  final String cid;
  final String cname;

  Clusters({
    required this.cid,
    required this.cname,
  });

  factory Clusters.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data()!;
    return Clusters(
      cid: snapshot.id,
      cname: data['cname'] ?? '',
    );
  }

  factory Clusters.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.data() is Map<String, dynamic>) {
      return Clusters.fromFirestore(
        snapshot as DocumentSnapshot<Map<String, dynamic>>,
        null,
      );
    }
    throw ArgumentError('Document data is not a Map<String, dynamic>');
  }

  Map<String, dynamic> toMap() {
    return {
      'cname': cname,
    };
  }
}
