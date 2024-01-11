import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:ibank/app/components/line_separator.dart';
import 'package:ibank/utils/constants/app_global.dart';

class HistoryDialog {
  static void showHistoryDialog(context, history) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object

        return AlertDialog(
          insetPadding: const EdgeInsets.all(12), // Outside Padding
          contentPadding: const EdgeInsets.all(12), // Content Padding
          content: SizedBox(
            width: MediaQuery.of(context).size.width - 60,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Bénéficiaire',
                        style: TextStyle(fontSize: M3FontSizes.headlineTiny, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        history[0]['BENEFICIARE'].toString(),
                        style: TextStyle(
                          fontSize: M3FontSizes.headlineTiny,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Muntant',
                        style: TextStyle(fontSize: M3FontSizes.headlineTiny, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        history[0]['AMOUNT'].toString(),
                        style: TextStyle(
                          fontSize: M3FontSizes.headlineTiny,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Date',
                        style: TextStyle(fontSize: M3FontSizes.headlineTiny, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        history[0]['DATE'].toString(),
                        style: TextStyle(
                          fontSize: M3FontSizes.headlineTiny,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Heure',
                        style: TextStyle(fontSize: M3FontSizes.headlineTiny, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        history[0]['TIME'].toString(),
                        style: TextStyle(
                          fontSize: M3FontSizes.headlineTiny,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Txn ID',
                        style: TextStyle(fontSize: M3FontSizes.headlineTiny, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        history[0]['TXNID'].toString(),
                        style: TextStyle(
                          fontSize: M3FontSizes.headlineTiny,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Nouveau solde',
                        style: TextStyle(fontSize: M3FontSizes.headlineTiny, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        history[0]['NEWBALNCE'].toString(),
                        style: TextStyle(
                          fontSize: M3FontSizes.headlineTiny,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
