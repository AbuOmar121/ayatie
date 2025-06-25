// /api/clusters
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_2/backend/spring/models/clusters_model.dart';

class ClustersService{
  static const String baseUrl = 'http://10.0.2.2:8080/api/clusters';

  Stream<List<Clusters>> getAllClusters(Duration interval) async* {
    while (true) {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List jsonList = json.decode(response.body);
        yield jsonList.map((e) => Clusters.fromMap(e)).toList();
      } else {
        yield [];
      }

      await Future.delayed(interval);
    }
  }


  Future<void> addCluster(Clusters cluster) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cluster.toMap()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add cluster');
    }
  }

}