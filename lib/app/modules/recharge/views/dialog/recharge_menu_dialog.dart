import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/generated/locales.g.dart';

class RechargeMenuDialog {
  static void showRechargeMenuDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return AlertDialog(
          title: Text('Credit transfer'),
          content: SizedBox(
            height: 80.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text('Transfert National'),
                GestureDetector(
                  onTap: () {
                    // showModalBottomSheet(
                    //     isScrollControlled: true,
                    //     context: context,
                    //     builder: (context) => _ModalBottomSheet(
                    //           sendType: LocaleKeys.strNationalTransfer.tr,
                    //           siOTPPage: AppGlobal.siOTPPage,
                    //           child: EnvoiModalBottomSheet(
                    //             sendType: LocaleKeys.strNationalTransfer.tr,
                    //           ),
                    //         ));
                  },
                  child: SizedBox(
                    height: 20,
                    child: Text('Credit'),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    // showModalBottomSheet(
                    //     isScrollControlled: true,
                    //     context: context,
                    //     builder: (context) => _ModalBottomSheet(
                    //           sendType: LocaleKeys.strInternationalTransfer.tr,
                    //           siOTPPage: AppGlobal.siOTPPage,
                    //           child: EnvoiInternationalBottomSheet(
                    //             sendType: LocaleKeys.strInternationalTransfer.tr,
                    //           ),
                    //         ));
                  },
                  child: SizedBox(
                    height: 20,
                    child: Text('Internet'),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
