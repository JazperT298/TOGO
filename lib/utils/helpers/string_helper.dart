// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StringHelper {
  static String formatNumberWithCommas(int number) {
    final format = NumberFormat('#,###');
    String formattedNumber = format.format(number);
    return formattedNumber.replaceAll(',', ' ');
  }

  static String formatStringWithSpace(String text, TextEditingController controller) {
    String newText = text.replaceAll(' ', '');
    String spacedText = newText.split('').join(' ');
    controller.value = controller.value.copyWith(
      text: spacedText,
      selection: TextSelection.collapsed(offset: spacedText.length),
    );
    return controller.value.text;
  }

  static String formatPhoneNumber(String number) {
    String cleanedNumber = number.replaceAll(RegExp(r'\D'), '');

    if (cleanedNumber.length >= 8) {
      return cleanedNumber.substring(3, 5) +
          ' ' +
          cleanedNumber.substring(5, 7) +
          ' ' +
          cleanedNumber.substring(7, 9) +
          ' ' +
          cleanedNumber.substring(9);
    } else {
      return number;
    }
  }

  static String formatMSISDN(String msisdn) {
    List<int> groupLengths = [3, 2, 2, 2, 2];
    int startIndex = 0;
    List<String> groups = [];

    for (int length in groupLengths) {
      String group = msisdn.substring(startIndex, startIndex + length);
      groups.add(group);
      startIndex += length;
    }
    return groups.join(' ');
  }

  static String parseTimerDuration(Duration duration) {
    String minutesString;
    if (duration.inSeconds > 59) {
      minutesString =
          '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else {
      minutesString =
          '${(duration.inHours % 60).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return minutesString;
  }

  static String capitalizeFirstLetter(String input) {
    if (input == null || input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  static String? getValue(String message, String key) {
    int keyIndex = message.indexOf(key);
    if (keyIndex == -1) {
      return null; // Key not found
    }

    int startIndex = keyIndex + key.length;
    int endIndex = message.indexOf('\r\n', startIndex);

    return message.substring(startIndex, endIndex).trim();
  }
}
//if user select flooz over ecobacnk

Map<String, String> extractValuesFromJson(String jsonString) {
  Map<String, dynamic> jsonData = json.decode(jsonString);
  String message = jsonData['message'];

  Map<String, String> extractedValues = {};

  extractedValues['compte'] = RegExp(r'Compte: (\d+)').firstMatch(message)?.group(1) ?? '';
  extractedValues['nom'] = RegExp(r'Nom: (\w+)').firstMatch(message)?.group(1) ?? '';
  extractedValues['prenoms'] = RegExp(r'Prenoms: (\w+)').firstMatch(message)?.group(1) ?? '';
  extractedValues['dob'] = RegExp(r'Date de naissance: (\d{2}/\d{2}/\d{4})').firstMatch(message)?.group(1) ?? '';
  extractedValues['soldeFlooz'] = RegExp(r'Solde Flooz: ([\d ,]+) FCFA').firstMatch(message)?.group(1) ?? '';
  extractedValues['commission'] = RegExp(r'Commission: ([\d ,]+) FCFA').firstMatch(message)?.group(1) ?? '';
  extractedValues['collecte'] = RegExp(r'Collecte: ([\d .]+) FCFA').firstMatch(message)?.group(1) ?? '';
  RegExp dateRegex = RegExp(r'Date: (\d+-\w+-\d+ \d+:\d+:\d+)');
  extractedValues['date'] = dateRegex.firstMatch(message)?.group(1) ?? '';
  RegExp jusquauRegex = RegExp(r'nJusqu\\u0027au\s*([^"]+)');
  extractedValues['jusquau'] = jusquauRegex.firstMatch(message)?.group(1) ?? '';

  // RegExp regExp = RegExp(r'Jusqu\\u0027au 29 Octobre, vos achats Cashpower via Flooz sont gratuits');
  // extractedValues['jusquau'] = regExp.firstMatch(message)?.group(0) ?? '';
  // extractedValues['jusquau'] = match.group(0)!;
  return extractedValues;
}

Map<String, String> extractValuesFromJson2(String message) {
  String amountPattern = r'Montant: (\d+ FCFA)';
  String fraisPattern = r'Frais HT: ([^\r\n]+)';
  String tafPattern = r'TAF: (\d+-[A-Za-z]+-\d+ \d+:\d+:\d+)';
  String nomPDVPattern = r'Nom PDV: ([^ \r\n]+)';
  String nouveauSoldePattern = r'Nouveau solde Flooz: ([^ \r\n]+)';
  String trxIdPattern = r'Trx id: (\d+)';

  RegExp amountRegExp = RegExp(amountPattern);
  RegExp fraisRegExp = RegExp(fraisPattern);
  RegExp tafRegExp = RegExp(tafPattern);
  RegExp nomRegExp = RegExp(nomPDVPattern);
  RegExp nouveauSoldeRegExp = RegExp(nouveauSoldePattern);
  RegExp trxIdRegExp = RegExp(trxIdPattern);

  Match? amountMatch = amountRegExp.firstMatch(message);
  Match? fraisMatch = fraisRegExp.firstMatch(message);
  Match? tafMatch = tafRegExp.firstMatch(message);
  Match? nomMatch = nomRegExp.firstMatch(message);
  Match? nouveauSoldeMatch = nouveauSoldeRegExp.firstMatch(message);
  Match? trxIdMatch = trxIdRegExp.firstMatch(message);

  String amount = amountMatch != null ? amountMatch.group(1)! : '';
  String frais = fraisMatch != null ? fraisMatch.group(1)! : '';
  String taf = tafMatch != null ? tafMatch.group(1)! : '';
  String nom = nomMatch != null ? nomMatch.group(1)! : '';
  String nouveauSolde = nouveauSoldeMatch != null ? nouveauSoldeMatch.group(1)! : '';
  String txnId = trxIdMatch != null ? trxIdMatch.group(1)! : '';

  return {
    'amount': amount,
    'trais': frais,
    'taf': taf,
    'nom': nom,
    'nouveauSolde': nouveauSolde,
    'txnId': txnId,
  };
}
