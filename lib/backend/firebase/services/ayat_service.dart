import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/backend/firebase/models/ayat_model.dart';

class AyatService{
  final CollectionReference<Map<String, dynamic>> ayatRef =
  FirebaseFirestore.instance.collection('fullquraan');

  Future<DocumentReference> addCluster(Ayat ayah) async {
    return await ayatRef.add(ayah.toMap());
  }

  Stream<List<Ayat>> getClusters() {
    return ayatRef.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Ayat.fromDocumentSnapshot(doc))
          .toList();
    });
  }

  Future<void> deleteCluster(String ayahId) async {
    await ayatRef.doc(ayahId).delete();
  }

  Future<void> updateCluster(String ayahId, Map<String, dynamic> data) async {
    await ayatRef.doc(ayahId).update(data);
  }
}