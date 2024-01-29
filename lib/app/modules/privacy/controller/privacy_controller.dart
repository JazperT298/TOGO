import 'package:get/get.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/routes/app_routes.dart';

class PrivacyController extends GetxController {
  RxBool isLoadingPrivacy = false.obs;

  void privacyAcceptButtonClick() async {
    isLoadingPrivacy(true);
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.find<StorageServices>().isPrivacyCheck(isPrivacyCheck: true);
      // Get.offAllNamed(AppRoutes.LOGINSUCCESS);
      Get.offAllNamed(AppRoutes.LOGINSECURITYCODE);
    });
    isLoadingPrivacy(false);
  }
}
