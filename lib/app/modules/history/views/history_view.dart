// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/app/data/models/transaction.dart';
import 'package:ibank/app/modules/history/controller/history_controller.dart';
import 'package:ibank/app/modules/history/views/dialog/history_dialog.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/core/transactions.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> with SingleTickerProviderStateMixin {
  final controller = Get.put(HistoryController());
  late final TabController tabController;
  late List<Map<String, dynamic>>? history = [];

  @override
  void initState() {
    tabController = TabController(length: _Filters.values.length, vsync: this);
    getHistory();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void getHistory() async {
    try {
      history = await SqlHelper.getAllTransactions();
      setState(() {});
      log('jsonEncode(history) $history');
      jsonEncode(history);
      log('jsonEncode(history) ${jsonEncode(history)}');
    } catch (e) {
      print('HISTORY $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(statusBarIconBrightness: Brightness.dark),
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
                  const Text(
                    'history',
                    style: TextStyle(
                      fontFamily: 'neptune',
                    ),
                  ),
                  Text(
                    'Transactions history.'.toUpperCase(),
                    style: TextStyle(
                      fontSize: M3FontSizes.displaySmall,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: TabBar(
                            controller: tabController,
                            isScrollable: true,
                            indicator: const RectangularIndicator(cornerRadius: 50),
                            labelColor: context.colorScheme.onPrimary,
                            unselectedLabelColor: context.colorScheme.onBackground,
                            splashFactory: NoSplash.splashFactory,
                            labelPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            tabs: _Filters.values.map((filter) {
                              return Tab(text: StringUtils(filter.label).capitalizeFirst!);
                            }).toList()),
                      ),
                      const FluButton.icon(
                        FluIcons.filter,
                        size: UISettings.minButtonSize,
                      )
                    ],
                  ),
                ],
              ),
            ),
            FluLine(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
            ),
            GestureDetector(
                onTap: () {
                  HistoryDialog.showHistoryDialog(context, history);
                },
                child: _TransactionsList(transactions, history!)),
          ],
        ),
      )),
    );
  }
}

/// Transactions list widget.
class _TransactionsList extends GetView<HistoryController> {
  final List<Transaction> transactions;
  final List<Map<String, dynamic>> transacHistory;

  const _TransactionsList(this.transactions, this.transacHistory, {Key? key}) : super(key: key);

  Color getTransactionColor(Transaction transaction) {
    if (transaction.status == TransactionStatus.waiting) {
      return Colors.orange;
    } else if (transaction.status == TransactionStatus.canceled || transaction.status == TransactionStatus.failed) {
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

  Color getTransactionStatusColor(BuildContext context, Transaction transaction) {
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
        return Flu.timeago(transaction.createdAt).split('ago').join().replaceFirst('a moment', 'un instant...');
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
      String value = endIndex != -1 ? valueSubstring.substring(0, endIndex).trim() : valueSubstring.trim();

      return value;
    }

    return null; // Key not found
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HistoryController());
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: UISettings.pagePadding.copyWith(bottom: 50),
        itemCount: transacHistory.length,
        itemBuilder: (context, index) {
          Transaction transaction = transactions[index];
          final transactionss = transacHistory[index];
          String status = getTransactionStatus(transaction);
          Color statusColor = getTransactionStatusColor(context, transaction);
          Color color = getTransactionColor(transaction);

          String? avatarImage;
          FluIcons? avatarIcon;
          String? montant = _extractValue(transactionss.toString(), "Montant:");
          String? nouveauSoldeFlooz = _extractValue(transactionss.toString(), "Nouveau solde Flooz:");
          String? txnId = _extractValue(transactionss.toString(), "Txn ID:");

          print("Montant: $montant");
          print("Nouveau solde Flooz: $nouveauSoldeFlooz");
          print("Txn ID: $txnId");
          if (transaction.agency != null) {
            avatarIcon = transaction.agency!.icon;
          } else {
            avatarImage = transaction.receivers.first.avatar;
          }

          return Container(
            margin: EdgeInsets.only(top: index == 0 ? 0 : 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // FluOutline(
                //   boxShadow: [BoxShadow(blurRadius: 30, spreadRadius: 3, color: Colors.black.withOpacity(.085))],
                //   margin: const EdgeInsets.only(right: 8),
                //   cornerRadius: 50,
                //   gap: 3,
                //   colors: [getTransactionColor(transaction).withOpacity(.5)],
                //   child: FluAvatar(
                //     image: avatarImage,
                //     icon: avatarIcon,
                //     size: UISettings.buttonSize - 5,
                //     cornerRadius: UISettings.buttonCornerRadius + 5,
                //     fillColor: context.colorScheme.primaryContainer,
                //   ),
                // ),
                // FluArc(
                //   startOfArc: 90,
                //   angle: 80,
                //   strokeWidth: 1,
                //   color: context.colorScheme.primaryContainer,
                //   // child: Container(
                //   //     height: context.width * .15,
                //   //     width: context.width * .15,
                //   //     margin: const EdgeInsets.all(5),
                //   //     decoration: BoxDecoration(
                //   //       color: context.colorScheme.primaryContainer,
                //   //       borderRadius: BorderRadius.circular(50),
                //   //     ),
                //   //     child: FluAvatar(
                //   //       image: option.avatar,
                //   //       overlayOpacity: .2,
                //   //       circle: true,
                //   //     )),
                //   child: Container(
                //     height: MediaQuery.of(context).size.width * .15,
                //     width: MediaQuery.of(context).size.width * .15,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: AppColors.getRandomColor(),
                //     ),
                //     child: Center(
                //       child: Text(
                //         transactionss.toString().substring(0, 1),
                //         style: const TextStyle(
                //           color: Colors.white, // You can change the text color
                //           fontSize: 24.0, // You can adjust the font size
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
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
                              txnId!.substring(0, txnId.length - 1),
                              maxLines: 2,
                              // transaction.agency != null
                              //     ? StringUtils(transaction.agency!.transactionTitle).capitalizeFirst!
                              //     : StringUtils(transaction.receivers.map((user) => user.firstName).toList().join(', ')).capitalize!,
                              style: const TextStyle(fontSize: M3FontSizes.bodyLarge, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              nouveauSoldeFlooz!,
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      FluLine(
                        height: 18,
                        width: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: context.colorScheme.onBackground.withOpacity(.3),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - (UISettings.pagePaddingSize * 2)) * .2,
                        child: Text(
                          montant!.substring(0, montant.length - 1),
                          style: const TextStyle(fontSize: M3FontSizes.bodyLarge, fontWeight: FontWeight.w600),
                        ),
                        // Text.rich(
                        //   TextSpan(
                        //       children:
                        //       [TextSpan(text: '${transaction.type == TransactionType.incoming ? '+' : '-'}${transaction.amout.round()}f')]),
                        //   textAlign: TextAlign.end,
                        //   style: TextStyle(
                        //     fontFamily: 'neptune',
                        //     fontSize: M3FontSizes.bodyLarge,
                        //     color: color,
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

enum _Filters { recents, today, month }

extension on _Filters {
  String get label {
    switch (this) {
      case _Filters.today:
        return "Aujourd'hui";
      case _Filters.month:
        return "Ce mois";
      default:
        return name;
    }
  }
}
