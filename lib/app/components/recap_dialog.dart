// class ShowRecapDialog {
//   static void showRecapOperationDialog(context, msisdn, amounts, trimString) async {
//     // flutter defined function
//     final controller = Get.put(SendMoneyController());
//     print("Amount: $trimString");

//     Map<String, String> extractedValues = extractValues(trimString);

//     String amount = extractedValues['amount'] ?? '';
//     String beneficiaire = extractedValues['beneficiaire'] ?? '';
//     String date = extractedValues['date'] ?? '';
//     String nouveauSolde = extractedValues['nouveauSolde'] ?? '';
//     String txnId = extractedValues['txnId'] ?? '';
//     List<String> separatedDateTime = separateDateTime(date);
//     String dates = separatedDateTime[0];
//     String times = separatedDateTime[1];
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return alert dialog object

//         return AlertDialog(
//           insetPadding: EdgeInsets.all(12), // Outside Padding
//           contentPadding: EdgeInsets.all(12),

//           content: Container(
//             width: MediaQuery.of(context).size.width - 60,
//             height: 440,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 const SizedBox(height: 8),
//                 Text(
//                   "Operation Recap",
//                   style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 24),
//                 ),
//                 const SizedBox(height: 24),
//                 Text(
//                   'Bénéficiaire'.toUpperCase(),
//                   style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
//                 ),
//                 const SizedBox(height: 18),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Name',
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         'N/A',
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Number',
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         msisdn,
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 const LineSeparator(color: Colors.grey),
//                 const SizedBox(height: 24),
//                 Text(
//                   'DETAILS'.toUpperCase(),
//                   style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
//                 ),
//                 const SizedBox(height: 18),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Frais',
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         controller.fees.value.isEmpty
//                             ? '0 FCFA'
//                             : '${StringHelper.formatNumberWithCommas(int.parse(controller.fees.value.replaceAll(',', '')))} FCFA',
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Montant',
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         controller.amountController.text.isEmpty
//                             ? '0 FCFA'
//                             : StringHelper.formatNumberWithCommas(int.parse(controller.amountController.text)),
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 const LineSeparator(color: Colors.grey),
//                 const SizedBox(height: 24),
//                 Text(
//                   'Operation information'.toUpperCase(),
//                   style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
//                 ),
//                 const SizedBox(height: 18),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Date',
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         DateFormat('dd/MM/yyyy').format(DateTime.parse(AppGlobal.dateNow)),
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Hour',
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         DateFormat('hh:mm:ss').format(DateTime.parse(AppGlobal.timeNow)),
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Txn ID',
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         txnId.isEmpty ? '' : txnId,
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Nouveau solde',
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         nouveauSolde.isEmpty ? '' : '$nouveauSolde FCFA',
//                         style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
