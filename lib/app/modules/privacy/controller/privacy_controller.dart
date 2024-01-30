import 'package:get/get.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/routes/app_routes.dart';

class PrivacyController extends GetxController {
  RxBool isLoadingPrivacy = false.obs;

  void privacyAcceptButtonClick() async {
    FullScreenLoading.fullScreenLoadingWithText('Processing request...');
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.find<StorageServices>().isPrivacyCheck(isPrivacyCheck: true);
      // Get.offAllNamed(AppRoutes.LOGINSUCCESS);
      Get.offAllNamed(AppRoutes.LOGINSECURITYCODE);
    });
  }
}
