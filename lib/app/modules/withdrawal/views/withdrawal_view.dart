// ignore_for_file: unused_element

import 'package:flukit/flukit.dart';
import 'package:get/get.dart';

// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ibank/generated/locales.g.dart';
// import 'package:get/get.dart';
// import 'package:ibank/app/modules/transfer/views/transfer_view.dart';
// import 'package:ibank/app/routes/app_routes.dart';
// import 'package:ibank/main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../utils/configs.dart';
import '../../../routes/app_routes.dart';
import '../controller/withdrawal_controller.dart';

// class WithdrawalView extends StatefulWidget {
//   const WithdrawalView({super.key});

//   @override
//   State<WithdrawalView> createState() => _WithdrawalViewState();
// }

// class _WithdrawalViewState extends State<WithdrawalView> {
//   late CameraController controller;
//   void validateMerchantId() {
//     Get.toNamed(AppRoutes.TRANSFER);
//     Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => const TransferView(
//               type: TransferViewType.withdraw,
//             )));
//   }

//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(cameras[0], ResolutionPreset.max);
//     controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             // Handle access errors here.
//             break;
//           default:
//             // Handle other errors here.
//             break;
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }

class WithdrawalView extends StatefulWidget {
  const WithdrawalView({Key? key}) : super(key: key);

  @override
  State<WithdrawalView> createState() => _WithdrawalViewState();
}

class _WithdrawalViewState extends State<WithdrawalView> {
  final controller = Get.find<WithdrawalController>();
  Barcode? result;
  QRViewController? qrcontroller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   }
  //   controller!.resumeCamera();
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value == true
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: UISettings.pagePadding,
                        child: InkWell(
                          onTap: () {
                            // controller.addPendingCashout();
                          },
                          child: Text(
                            LocaleKeys.strWalletWithdrawalDesc.tr.toUpperCase(),
                            //   "RETRAIT",
                            style: const TextStyle(color: Colors.orange),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: UISettings.pagePadding,
                        child: Obx(
                          () => Text(
                            "${LocaleKeys.strWithdrawMoneyDesc.tr} ${controller.nickname.value}",
                            style: const TextStyle(
                              fontSize: M3FontSizes.headlineSmall,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.08,
                          right: MediaQuery.of(context).size.width * 0.07,
                        ),
                        child: Text(
                          LocaleKeys.strCollectionDetails
                              .tr, //  "Details du retrait Flooz Point de vente",
                          style: const TextStyle(
                            fontSize: M3FontSizes.labelMedium,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                          padding: UISettings.pagePadding,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02,
                              left: MediaQuery.of(context).size.width * 0.02,
                            ),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 193, 224, 238),
                                borderRadius: BorderRadius.circular(20)),
                            child: Obx(
                              () => Text(
                                controller.nickname.value,
                                style: const TextStyle(
                                  fontSize: M3FontSizes.labelLarge,
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.08,
                          right: MediaQuery.of(context).size.width * 0.07,
                        ),
                        child: Text(
                          LocaleKeys.strAmount.tr, //   "Montant",
                          style: const TextStyle(
                            fontSize: M3FontSizes.labelMedium,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                          padding: UISettings.pagePadding,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02,
                              left: MediaQuery.of(context).size.width * 0.02,
                            ),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 193, 224, 238),
                                borderRadius: BorderRadius.circular(20)),
                            child: Obx(
                              () => Text(
                                controller.amount.value,
                                style: const TextStyle(
                                  fontSize: M3FontSizes.labelLarge,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.48,
                      ),
                      Padding(
                        padding: UISettings.pagePadding,
                        child: FluButton.text(
                          LocaleKeys.strContinue.tr, //    'Continuer',
                          suffixIcon: FluIcons.arrowRight,
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            Get.toNamed(AppRoutes.WITHDRAWALOTP);
                          },
                          height: 55,
                          width: MediaQuery.of(context).size.width * 16,
                          cornerRadius: UISettings.minButtonCornerRadius,
                          backgroundColor: context.colorScheme.primary,
                          foregroundColor: context.colorScheme.onPrimary,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  context.colorScheme.primary.withOpacity(.35),
                              blurRadius: 25,
                              spreadRadius: 3,
                              offset: const Offset(0, 5),
                            )
                          ],
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: M3FontSizes.bodyLarge),
                        ),
                      ),
                      // Expanded(flex: 4, child: _buildQrView(context)),
                      // Expanded(
                      //   flex: 1,
                      //   child: FittedBox(
                      //     fit: BoxFit.contain,
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children: <Widget>[
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           children: <Widget>[
                      //             Container(
                      //               margin: const EdgeInsets.all(8),
                      //               child: ElevatedButton(
                      //                 onPressed: () async {
                      //                   sampleSoapRequest();
                      //                   // await controller?.pauseCamera();
                      //                 },
                      //                 child: const Text('pause',
                      //                     style: TextStyle(fontSize: 20)),
                      //               ),
                      //             ),
                      //             Container(
                      //               margin: const EdgeInsets.all(8),
                      //               child: ElevatedButton(
                      //                 onPressed: () async {
                      //                   await controller?.resumeCamera();
                      //                 },
                      //                 child: const Text('resume',
                      //                     style: TextStyle(fontSize: 20)),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrcontroller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
