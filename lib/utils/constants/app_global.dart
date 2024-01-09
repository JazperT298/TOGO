// ignore_for_file: non_constant_identifier_names, constant_identifier_names

class AppGlobal {
  static bool IS_ACC_CHECKING_ENABLED = true;
  static bool IS_INACTIVITY_ENABLED = true;
  static bool IS_INACTIVITY_TRIGGERED = false;
  bool IS_MINIMIZED = false;
  bool FROM_BACKGROUND = false;
  static int SESSION_TIMEOUT = 300;

  static const int PICK_CONTACT = 100;
  static const int SCAN_BARCODE = 101;
  static const int SCAN_QRCODE = 201;
  static const int SCAN_RESCAN = 102;
  static const int NOTIFY_DIALOG_ID = 1;
  static const int PROGRESS_DIALOG_ID = 2;
  static const int DOWNLOAD_DIALOG_ID = 3;
  static const int BURGER_MENU_ID = 4;

  static bool isSendVerificationLoading = false;
  static bool isEditedTransferNational = true;
  static bool isSubscribedTransferNational = false;
  static bool isOtherNetTransferNational = false;
  static bool siOTPPage = true;
  static dynamic phonenumberspan;
  static String addressBookDisplayName = "";
  static StringBuffer notifymessage = StringBuffer();
  static StringBuffer message = StringBuffer();
  static StringBuffer shortcode = StringBuffer();

  static String beneficiare = "";
  static String date = "";
  static String time = "";

  static String amount = "";
  static String remainingBal = "";
  static String txn = "";
  static String numbers = "";
}
