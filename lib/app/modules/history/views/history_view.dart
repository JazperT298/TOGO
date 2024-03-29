// ignore_for_file: prefer_const_constructors, avoid_print, unused_element

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/data/models/transaction.dart';
import 'package:ibank/app/modules/history/controller/history_controller.dart';
import 'package:ibank/app/modules/history/views/dialog/history_dialog.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/core/transactions.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late List<Map<String, dynamic>>? history = [];

  @override
  void initState() {
    tabController = TabController(length: _Filters.values.length, vsync: this);
    Get.find<HistoryController>().getHistory();

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle
          .copyWith(statusBarIconBrightness: Brightness.dark),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: UISettings.pagePadding.copyWith(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.strHistory.tr.toUpperCase(),
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF687997),
                        fontSize: 14),
                  ),
                  Text(
                    'Monitor your operations.'.toUpperCase(),
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF27303F),
                        fontSize: 26),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Horem ipsum dolor sit amet, consectetur adipiscing elit.",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 2.5.h),
                  FluTextField(
                    hint: "Search for a transaction",
                    height: 50,
                    cornerRadius: 15,
                    keyboardType: TextInputType.name,
                    fillColor: Color(0xFFF4F5FA),
                    cursorColor: Color(0xFF27303F),
                    hintStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF27303F),
                        fontSize: 14),
                    textStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14),
                    suffixIcon: FluIcons.refresh,
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Expanded(
                        child: TabBar(
                            controller: tabController,
                            isScrollable: true,
                            onTap: (index) {
                              print(index);
                              Get.find<HistoryController>()
                                  .onClickHover(index: index);
                            },
                            indicator:
                                const RectangularIndicator(cornerRadius: 50),
                            labelColor: context.colorScheme.onPrimary,
                            unselectedLabelColor:
                                context.colorScheme.onBackground,
                            splashFactory: NoSplash.splashFactory,
                            labelPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            tabs: _Filters.values.map((filter) {
                              return Tab(
                                  text: StringUtils(filter.label)
                                      .capitalizeFirst!);
                            }).toList()),
                      ),
                      // const FluButton.icon(
                      //   FluIcons.filter,
                      //   size: UISettings.minButtonSize,
                      // )
                    ],
                  ),
                ],
              ),
            ),
            FluLine(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .025),
            ),
            _TransactionsList(
              transactions,
            ),
          ],
        ),
      )),
    );
  }
}

/// Transactions list widget.
class _TransactionsList extends GetView<HistoryController> {
  final List<Transaction> transactions;

  const _TransactionsList(this.transactions, {Key? key}) : super(key: key);

  Color getTransactionColor(Transaction transaction) {
    if (transaction.status == TransactionStatus.waiting) {
      return Colors.orange;
    } else if (transaction.status == TransactionStatus.canceled ||
        transaction.status == TransactionStatus.failed) {
      return Colors.red;
    } else {
      switch (transaction.type) {
        case TransactionType.incoming:
          return Colors.green;
        case TransactionType.outgoing:
        case TransactionType.agency:
          return Colors.red;
      }
    }
  }

  Color getTransactionStatusColor(
      BuildContext context, Transaction transaction) {
    switch (transaction.status) {
      case TransactionStatus.waiting:
        return Colors.yellow;
      case TransactionStatus.canceled:
      case TransactionStatus.failed:
        return Colors.red;
      default:
        return context.colorScheme.onBackground;
    }
  }

  String getTransactionStatus(Transaction transaction) {
    switch (transaction.status) {
      case TransactionStatus.ok:
        return Flu.timeago(transaction.createdAt)
            .split('ago')
            .join()
            .replaceFirst('a moment', 'un instant...');
      case TransactionStatus.waiting:
        return 'En cours...';
      case TransactionStatus.failed:
        return 'Echoué ...';
      case TransactionStatus.canceled:
        return 'Annulé ...';
    }
  }

  static String? _extractValue(String text, String key) {
    // Find the index of the key in the text
    int keyIndex = text.indexOf(key);

    if (keyIndex != -1) {
      // Extract the substring after the key
      String valueSubstring = text.substring(keyIndex + key.length);

      // Find the index of the next newline character to determine the end of the value
      int endIndex = valueSubstring.indexOf('\n');

      // Extract the value
      String value = endIndex != -1
          ? valueSubstring.substring(0, endIndex).trim()
          : valueSubstring.trim();

      return value;
    }

    return null; // Key not found
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: UISettings.pagePadding.copyWith(bottom: 50),
          itemCount: controller.historytransactions.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                HistoryDialog.showNewHistoryDialog(
                    context: context,
                    message: controller.historytransactions[index].message,
                    service: controller.historytransactions[index].service,
                    beneficiary:
                        controller.historytransactions[index].beneficiary,
                    amount: controller.historytransactions[index].amount,
                    fees: controller.historytransactions[index].fees,
                    tax: controller.historytransactions[index].tax,
                    ttc: controller.historytransactions[index].ttc,
                    operationDate:
                        controller.historytransactions[index].operationDate,
                    operationHour:
                        controller.historytransactions[index].operationHour,
                    txnID: controller.historytransactions[index].txnID,
                    newBalance:
                        controller.historytransactions[index].newBalance,
                    status: controller.historytransactions[index].status);
              },
              child: Container(
                margin: EdgeInsets.only(top: index == 0 ? 0 : 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 12),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.historytransactions[index].service,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  controller.historytransactions[index].message,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 11.sp),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "${DateFormat.yMMMMd().format(controller.historytransactions[index].date)} ${DateFormat.jm().format(controller.historytransactions[index].date)}", //  transactionss['TIME'].toString(),
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 11.sp),
                                ),
                                const SizedBox(height: 17),
                                Divider()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

enum _Filters { today, recents, month }

extension on _Filters {
  String get label {
    switch (this) {
      case _Filters.today:
        return LocaleKeys.strToday.tr;
      case _Filters.month:
        return LocaleKeys.strThisMonth.tr;
      case _Filters.recents:
        return LocaleKeys.strWeek.tr;
      default:
        return name;
    }
  }
}
