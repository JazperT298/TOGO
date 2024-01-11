import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices extends GetxController {
  final storage = GetStorage();

  // saveCredentials({
  //   required String id,
  //   required String username,
  //   required String password,
  //   required String firstname,
  //   required String lastname,
  //   required bool isNormalAccount,
  //   required String contactno,
  // }) {
  //   storage.write("id", id);
  //   storage.write("username", username);
  //   storage.write("password", password);
  //   storage.write("firstname", firstname);
  //   storage.write("lastname", lastname);
  //   storage.write("contactno", contactno);
  //   storage.write("isNormalAccount", isNormalAccount);
  // }

  // removeStorageCredentials() {
  //   storage.remove("id");
  //   storage.remove("username");
  //   storage.remove("password");
  //   storage.remove("firstname");
  //   storage.remove("lastname");
  //   storage.remove("contactno");
  //   storage.remove("isNormalAccount");
  // }

  // save_to_cart({required List cartList}) async {
  //   storage.write("cart", cartList);
  // }

  saveHistoryTransaction({
    required String message,
    required String service,
  }) async {
    if (storage.read('history') == null) {
      List data = [];
      Map map = {
        "service": service,
        "message": message,
        "date": DateTime.now().toString()
      };
      data.add(map);
      storage.write("history", jsonEncode(data));

      log(storage.read('history'));
    } else {
      var stringdata = storage.read('history');
      var decodedData = jsonDecode(stringdata);
      Map map = {
        "service": service,
        "message": message,
        "date": DateTime.now().toString()
      };
      decodedData.add(map);
      storage.write("history", jsonEncode(decodedData));
      log(storage.read('history'));
    }
  }
}
