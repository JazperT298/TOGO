// ignore_for_file: constant_identifier_names

import 'dart:async';

class SmsInboxReceiverSchedule {
  static const int REPEAT_TIME_SEC = 2;
  static const int REPEAT_TIME_MILLI = 1000 * REPEAT_TIME_SEC;
  static bool started = false;

  static void startSchedule() {
    if (started) return;

    Timer.periodic(const Duration(seconds: REPEAT_TIME_SEC), (timer) {
      // Do the work you want to perform periodically here
      // For example, start your service
      // SmsInboxServiceStart().startService();
    });
    started = true;
  }
}
