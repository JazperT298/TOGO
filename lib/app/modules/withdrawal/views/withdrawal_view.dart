import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/transfer/views/transfer_view.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/main.dart';

class WithdrawalView extends StatefulWidget {
  const WithdrawalView({super.key});

  @override
  State<WithdrawalView> createState() => _WithdrawalViewState();
}

class _WithdrawalViewState extends State<WithdrawalView> {
  late CameraController controller;
  void validateMerchantId() {
    Get.toNamed(AppRoutes.TRANSFER);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const TransferView(
              type: TransferViewType.withdraw,
            )));
  }

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
