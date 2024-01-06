import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/models/transaction.dart';
import 'package:ibank/app/modules/history/controller/history_controller.dart';
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

  @override
  void initState() {
    tabController = TabController(length: _Filters.values.length, vsync: this);
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
            _TransactionsList(transactions),
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

  @override
  Widget build(BuildContext context) {
    Get.put(HistoryController());
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: UISettings.pagePadding.copyWith(bottom: 50),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          Transaction transaction = transactions[index];

          String status = getTransactionStatus(transaction);
          Color statusColor = getTransactionStatusColor(context, transaction);
          Color color = getTransactionColor(transaction);

          String? avatarImage;
          FluIcons? avatarIcon;

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
                FluOutline(
                  boxShadow: [BoxShadow(blurRadius: 30, spreadRadius: 3, color: Colors.black.withOpacity(.085))],
                  margin: const EdgeInsets.only(right: 8),
                  cornerRadius: 50,
                  gap: 3,
                  colors: [getTransactionColor(transaction).withOpacity(.5)],
                  child: FluAvatar(
                    image: avatarImage,
                    icon: avatarIcon,
                    size: UISettings.buttonSize - 5,
                    cornerRadius: UISettings.buttonCornerRadius + 5,
                    fillColor: context.colorScheme.primaryContainer,
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction.agency != null
                                  ? StringUtils(transaction.agency!.transactionTitle).capitalizeFirst!
                                  : StringUtils(transaction.receivers.map((user) => user.firstName).toList().join(', ')).capitalize!,
                              style: const TextStyle(fontSize: M3FontSizes.bodyLarge, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              status,
                              style: TextStyle(color: statusColor),
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
                        child: Text.rich(
                          TextSpan(
                              children: [TextSpan(text: '${transaction.type == TransactionType.incoming ? '+' : '-'}${transaction.amout.round()}f')]),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'neptune',
                            fontSize: M3FontSizes.bodyLarge,
                            color: color,
                          ),
                        ),
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
