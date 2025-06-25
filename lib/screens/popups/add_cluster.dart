import 'package:flutter/material.dart';
// import 'package:flutter_application_2/backend/spring/models/clusters_model.dart';
// import 'package:flutter_application_2/backend/spring/services/clusters_service.dart';
import 'package:flutter_application_2/backend/firebase/models/clusters_model.dart';
import 'package:flutter_application_2/backend/firebase/services/cluster_service.dart';

void showAddClusterDialog(BuildContext context, {Clusters? cluster, Function? onSuccess}) {
  final TextEditingController _controller =
  TextEditingController(text: cluster?.cname ?? '');

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(cluster == null ? 'اضافة تصنيف' : 'تعديل تصنيف'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(
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
            child: Text(cluster == null ? 'إضافة' : 'تعديل'),
            onPressed: () async {
              final cname = _controller.text.trim();
              if (cname.isNotEmpty) {
                if (cluster == null) {
                  // Add
                  final newCluster = Clusters(cid: cluster!.cid, cname: cname);
                  await ClustersService().addCluster(newCluster);
                } else {
                  // Update

                }

                Navigator.of(context).pop();

                if (onSuccess != null) {
                  onSuccess(); // reload data if needed
                }
              }
            },
          ),
        ],
      );
    },
  );
}
