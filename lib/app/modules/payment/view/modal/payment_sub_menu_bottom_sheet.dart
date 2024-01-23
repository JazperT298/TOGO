import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/models/wallet.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class PaymentSubMenuBottomSheet {
  static void showBottomSheetPaymentSubMenu(BuildContext context) {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(Container(
      height: 75.h,
      width: 100.w,
      decoration:
          const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: SingleChildScrollView(
        padding: UISettings.pagePadding.copyWith(
          top: MediaQuery.of(context).size.height * .025,
          bottom: MediaQuery.of(context).size.height * .025,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment'.toUpperCase(),
              style: TextStyle(
                color: const Color(0xFFfb6708),
                fontWeight: FontWeight.w600,
                fontSize: 11.sp,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              'Energy and water',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Rorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
                style: TextStyle(
                  fontSize: 10.sp,
                ),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Row(
              children: [
                FluLine(
                  width: 30.w,
                  color: const Color(0xFFfb6708),
                ),
                CircleAvatar(
                  radius: 1.w,
                  backgroundColor: const Color(0xFFfb6708),
                )
              ],
            ),
            SizedBox(
              height: 1.5.h,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.walletChild.children.length,
                itemBuilder: (context, index) {
                  final option = controller.walletChild.children[index];

                  return FluButton(
                    // onPressed: toNextStep,
                    backgroundColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
                    child: Row(
                      children: [
                        FluArc(
                          startOfArc: 90,
                          angle: 80,
                          strokeWidth: 1,
                          color: context.colorScheme.primaryContainer,
                          child: Container(
                              height: MediaQuery.of(context).size.width * .15,
                              width: MediaQuery.of(context).size.width * .15,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: FluIcon(
                                option.icon,
                                color: Colors.black,
                              )),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    option.name,
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12.sp),
                                  ),
                                ),
                                Text(
                                  option.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                        FluIcon(
                          FluIcons.arrowRight1,
                          size: 16,
                          color: context.colorScheme.onBackground,
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    ));
  }
}
