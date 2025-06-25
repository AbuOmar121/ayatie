import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_2/backend/spring/models/ayat_model.dart';

class AyatService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/ayat';

  Future<List<Ayat>> getAllAyat() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonList = json.decode(response.body);
      return jsonList.map((e) => Ayat.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load ayat');
    }
  }

  Future<void> addAyat(Ayat ayat) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(ayat.toMap()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add ayat');
    }
  }
}
