import 'package:flutter/material.dart';
// import 'package:flutter_application_2/backend/spring/models/clusters_model.dart';
import 'package:flutter_application_2/backend/firebase/models/clusters_model.dart';
import 'package:flutter_application_2/screens/popups/add_ayah.dart';

class Ayah extends StatefulWidget {
  final Clusters c;
  const Ayah({super.key, required this.c});

  @override
  State<Ayah> createState() => _AyahState();
}

class _AyahState extends State<Ayah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.c.cname}',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 33,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => SurahAyahDialog(
                  onSelected: (surahNo, surahName, ayahNo) {

                  },
                ),
              );
            },
            icon: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 30),
          ),
        ],
      ),
      body: Center(child: Text(widget.c.cname)),
    );
  }
}
