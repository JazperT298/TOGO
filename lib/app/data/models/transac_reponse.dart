import 'dart:convert';

class TransacResponse {
  String refid;
  int msgid;
  String message;
  String senderbalance;

  TransacResponse({
    required this.refid,
    required this.msgid,
    required this.message,
    required this.senderbalance,
  });

  // factory TransacResponse.fromJson(Map<String, dynamic> json) {
  //   String processedMessage = json['message']
  //       .replaceAll('\r\n', '')
  //       .replaceAll('Montant:', '"Montant":')
  //       .replaceAll('Beneficiaire:', '"Beneficiaire":')
  //       .replaceAll('Date:', '"Date":') // Format "Date" field
  //       .replaceAll('Nouveau solde Flooz:', '"Nouveau solde Flooz":') // Format "Nouveau solde Flooz" field
  //       .replaceAll('Txn ID:', '"Txn ID":') // Format "Txn ID" field
  //       .replaceAll('Jusqu\\u0027au', '"Jusqu\\u0027au');
  //   Map<String, dynamic> processedJson = json..['message'] = processedMessage;
  //   return TransacResponse(
  //     refid: processedJson['refid'],
  //     msgid: processedJson['msgid'],
  //     messageData: MessageData.fromJson(processedJson['message']),
  //     senderbalance: processedJson['senderbalance'],
  //   );
  // }
  factory TransacResponse.fromJson(Map<String, dynamic> json) {
    return TransacResponse(
      refid: json['refid'],
      msgid: json['msgid'],
      // messageData: MessageData.fromJson(json['message']),
      message: json['message'],
      senderbalance: json['senderbalance'],
    );
  }
}

class MessageData {
  String montant;
  String beneficiaire;
  String date;
  String nouveauSoldeFlooz;
  String txnId;
  String jusquau;

  MessageData({
    required this.montant,
    required this.beneficiaire,
    required this.date,
    required this.nouveauSoldeFlooz,
    required this.txnId,
    required this.jusquau,
  });

  factory MessageData.fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return MessageData(
      montant: json['Montant'],
      beneficiaire: json['Beneficiaire'],
      date: json['Date'],
      nouveauSoldeFlooz: json['Nouveau solde Flooz'],
      txnId: json['Txn ID'],
      jusquau: json['Jusqu\u0027au'],
    );
  }
}
