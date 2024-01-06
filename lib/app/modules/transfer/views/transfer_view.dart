// ignore_for_file: sort_child_properties_last, unused_element

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/transfer_confirm_widget.dart';
import 'package:ibank/app/modules/transfer/controller/transfer_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';

enum TransferViewType {
  create,
  normal,
  withdraw,
}

class TransferView extends GetView<TransferController> {
  const TransferView({super.key, this.type = TransferViewType.normal});

  final TransferViewType type;

  @override
  Widget build(BuildContext context) {
    Get.put(TransferController());
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: UISettings.pagePadding.copyWith(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FluButton.icon(
                        FluIcons.arrowLeft,
                        size: UISettings.minButtonSize,
                        cornerRadius: UISettings.minButtonCornerRadius,
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: type == TransferViewType.normal || type == TransferViewType.withdraw
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (type == TransferViewType.withdraw ? 'Retiré auprès de' : 'Envoyez À:').toUpperCase(),
                                    style: TextStyle(
                                      fontSize: M3FontSizes.bodySmall,
                                      fontWeight: FontWeight.w600,
                                      color: context.colorScheme.onBackground.withOpacity(.5),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Hero(
                                    tag: '<title>',
                                    child: Text(
                                      (type == TransferViewType.withdraw ? 'L\'agence K' : 'Agbogawo Loïc').toUpperCase(),
                                      style: TextStyle(
                                        fontSize: M3FontSizes.headlineMedium,
                                        fontWeight: FontWeight.bold,
                                        color: context.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '+228 99 21 50 55'.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: context.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              )
                            : const FluTextField(
                                hint: "Numero de telephone",
                                height: UISettings.buttonSize,
                                textStyle: TextStyle(fontSize: M3FontSizes.titleMedium),
                              ),
                      ),
                      FluLine(
                        height: 15,
                        width: 1,
                        color: context.colorScheme.outlineVariant,
                        margin: const EdgeInsets.only(left: 5),
                      ),
                      FluButton.icon(
                        FluIcons.plus,
                        size: UISettings.minButtonSize,
                        cornerRadius: UISettings.minButtonCornerRadius,
                        backgroundColor: Colors.transparent,
                        foregroundColor: context.colorScheme.onBackground.withOpacity(.5),
                        alignment: Alignment.centerRight,
                        iconSize: 26,
                        splashFactory: NoSplash.splashFactory,
                        onPressed: () => Get.toNamed(AppRoutes.NEWFAV),
                      ),
                    ],
                  ),
                  FluLine(
                    height: 1,
                    width: double.infinity,
                    color: context.colorScheme.outlineVariant.withOpacity(.5),
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .025),
                  ),
                  FluLine(
                    height: 3,
                    width: MediaQuery.of(context).size.width * .05,
                    color: context.colorScheme.secondary,
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .025),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '15000'.toUpperCase(),
                          style: TextStyle(
                            fontSize: M3FontSizes.displaySmall,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.secondary,
                          ),
                        ),
                      ),
                      FluLine(
                        height: 15,
                        width: 1,
                        color: context.colorScheme.outlineVariant,
                        margin: const EdgeInsets.only(left: 5),
                      ),
                      FluButton.text(
                        "CFA",
                        width: UISettings.minButtonSize,
                        cornerRadius: UISettings.minButtonCornerRadius,
                        backgroundColor: Colors.transparent,
                        foregroundColor: context.colorScheme.onBackground.withOpacity(.5),
                        alignment: Alignment.centerRight,
                        iconSize: 26,
                        splashFactory: NoSplash.splashFactory,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FluLine(
              height: 1,
              width: double.infinity,
              color: context.colorScheme.outlineVariant.withOpacity(.5),
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .025),
            ),
            if (context.isKeyboardHidden)
              Expanded(
                child: Container(
                  color: context.colorScheme.surface,
                  child: const Column(
                    children: [
                      _KeyboardRow(["1", "2", "3"]),
                      _KeyboardRow(["4", "5", "6"]),
                      _KeyboardRow(["7", "8", "9"]),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: _KeyboardButton(".")),
                            Expanded(child: _KeyboardButton("0")),
                            Expanded(
                                child: _KeyboardButton(
                              "",
                              child: FluIcon(FluIcons.arrowLeft),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            FluButton(
              onPressed: () => type == TransferViewType.withdraw
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TransferConfirmation(
                            type: TransferConfirmationType.withdraw,
                          )))
                  : showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const TransferConfirmation();
                      }),
              height: UISettings.buttonSize + 10,
              cornerRadius: UISettings.buttonCornerRadius,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: UISettings.pagePadding.copyWith(top: MediaQuery.of(context).size.height * .015),
              backgroundColor: context.colorScheme.primary,
              foregroundColor: context.colorScheme.onPrimary,
              child: Row(
                children: [
                  const Text(
                    'Continuer',
                    style: TextStyle(
                      fontSize: M3FontSizes.bodyLarge,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  FluIcon(
                    FluIcons.arrowRight,
                    color: context.colorScheme.onPrimary,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyboardRow extends StatelessWidget {
  const _KeyboardRow(this.values, {super.key});

  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(child: _KeyboardButton(values[0])),
          Expanded(child: _KeyboardButton(values[1])),
          Expanded(child: _KeyboardButton(values[2])),
        ],
      ),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  const _KeyboardButton(this.value, {this.child, super.key});

  final String value;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return child != null
        ? FluButton(
            child: child!,
            expand: true,
            cornerRadius: 0,
            backgroundColor: Colors.transparent,
          )
        : FluButton.text(
            value,
            expand: true,
            cornerRadius: 0,
            backgroundColor: Colors.transparent,
          );
  }
}
