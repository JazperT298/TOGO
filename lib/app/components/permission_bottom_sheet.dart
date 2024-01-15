// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// Future<void> showPermissionBottomSheet(BuildContext context) async {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             // _buildPermissionButton(context, Permission.location, 'Location'),
//             // _buildPermissionButton(context, Permission.storage, 'Storage'),
//             // Add more permissions as needed
//           ],
//         ),
//       );
//     },
//   );
// }
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> showPermissionDeniedDialog(BuildContext context, Permission permission) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Permission Denied'),
        content: Text('Please grant ${permission.toString()} permission to use this feature.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
