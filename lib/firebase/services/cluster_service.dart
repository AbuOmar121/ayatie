import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/firebase/models/clusters_model.dart';

class ClustersService {
  final CollectionReference<Map<String, dynamic>> clustersRef =
  FirebaseFirestore.instance.collection('clusters');

  Future<DocumentReference> addCluster(Clusters cluster) async {
    return await clustersRef.add(cluster.toMap());
  }

  Stream<List<Clusters>> getClusters() {
    return clustersRef.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Clusters.fromDocumentSnapshot(doc))
          .toList();
    });
  }

  Future<void> deleteCluster(String clusterId) async {
    await clustersRef.doc(clusterId).delete();
  }

  Future<void> updateCluster(String clusterId, Map<String, dynamic> data) async {
    await clustersRef.doc(clusterId).update(data);
  }
}