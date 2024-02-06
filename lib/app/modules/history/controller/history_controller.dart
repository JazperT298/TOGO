// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/data/models/history_model.dart';

class HistoryController extends GetxController {
  RxList<History> historytransactions = <History>[].obs;
  RxList<History> historytransactionsMasterList = <History>[].obs;

  RxInt currentIndex = 0.obs;

  void getHistory() async {
    print("Called");
    try {
      if (Get.find<StorageServices>().storage.read('history') == null) {
        print(Get.find<StorageServices>().storage.read('history'));
      } else {
        var stringhistory = Get.find<StorageServices>().storage.read('history');
        historytransactionsMasterList.assignAll(historyFromJson(stringhistory));
        historytransactions.clear();
        DateTime now = DateTime.now();
        for (var i = 0; i < historytransactionsMasterList.length; i++) {
          if (now.year == historytransactionsMasterList[i].date.year &&
              now.month == historytransactionsMasterList[i].date.month &&
              now.day == historytransactionsMasterList[i].date.day) {
            historytransactions.add(historytransactionsMasterList[i]);
          }
        }
        historytransactions.sort((b, a) => a.date.compareTo(b.date));
      }
    } catch (e) {
      print('HISTORY $e');
    }
  }

  onClickHover({required int index}) async {
    if (index == 0) {
      historytransactions.clear();
      DateTime now = DateTime.now();
      for (var i = 0; i < historytransactionsMasterList.length; i++) {
        if (now.year == historytransactionsMasterList[i].date.year &&
            now.month == historytransactionsMasterList[i].date.month &&
            now.day == historytransactionsMasterList[i].date.day) {
          historytransactions.add(historytransactionsMasterList[i]);
        }
      }
      historytransactions.sort((b, a) => a.date.compareTo(b.date));
    }
    if (index == 1) {
      historytransactions.clear();
      DateTime now = DateTime.now();
      for (var i = 0; i < historytransactionsMasterList.length; i++) {
        var daysCount =
            now.difference(historytransactionsMasterList[i].date).inDays;
        if (daysCount <= 7) {
          historytransactions.add(historytransactionsMasterList[i]);
        }
      }
      historytransactions.sort((b, a) => a.date.compareTo(b.date));
    }
    if (index == 2) {
      historytransactions.clear();
      DateTime now = DateTime.now();
      for (var i = 0; i < historytransactionsMasterList.length; i++) {
        var daysCount =
            now.difference(historytransactionsMasterList[i].date).inDays;
        if (daysCount <= 30) {
          historytransactions.add(historytransactionsMasterList[i]);
        }
      }
      historytransactions.sort((b, a) => a.date.compareTo(b.date));
    }
  }

  @override
  void onInit() {
    getHistory();
    super.onInit();
  }
}
