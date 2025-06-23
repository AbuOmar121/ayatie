import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase/models/clusters_model.dart';
import 'package:flutter_application_2/firebase/services/cluster_service.dart';
import 'package:flutter_application_2/screens/ayah.dart';
import 'package:flutter_application_2/screens/popups/add_cluster.dart';
import 'package:flutter_application_2/screens/splash.dart';
import 'package:flutter_application_2/screens/to_firebase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ClustersService service = ClustersService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ادارة التصنيفات',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 33,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showAddClusterDialog(context),
            icon: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 30),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          icon: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 30),
        ),
      ),
      body: StreamBuilder<List<Clusters>>(
        stream: service.getClusters(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: SplashDialog());
          }
          if (snapshot.data == null) {
            return Center(child: Text("there is no Clusters"));
          }

          final items = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children:
                  items
                      .map(
                        (item) => Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: Offset(5, 20),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Ayah(c: item),
                                  ),
                                );
                              },
                              title: Text(
                                item.cname,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showAddClusterDialog(
                                        context,
                                        cluster: item,
                                      );
                                    },
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      service.deleteCluster(item.cid);
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          );
        },
      ),
    );
  }
}
