import 'package:ibank/app/data/models/canal_box_model.dart';
import 'package:ibank/app/data/models/meter_model.dart';
import 'package:ibank/app/data/models/tontine_group_model.dart';

class FloozHelper {
  static List<String>? accountnumber;
  static List<String>? cardnumber;
  static String? accountnumberString;
  static String? cardnumberString;
  static String? amount;
  static String? token;
  static String? numcontract;
  static String? idbase;
  static String? numsubscriber;
  static String? catalogue;
  static String? offercode;
  static String? optioncodelist;
  static String? durationcode;
  static String? status;
  static String? message;
  static String? userType;
  static List<String>? menuItems;
  static List<TontineGroupModel>? tontineGroups;
  static List<CanalBoxModel>? canalBoxes;
  static List<MeterModel>? meters;
  static List<String>? accounts;

  static String? getMessage() {
    return message;
  }

  static void setMessage(String? msg) {
    message = msg;
  }

  static String? getStatus() {
    return status;
  }

  static void setStatus(String? s) {
    status = s;
  }

  static String? getCatalogue() {
    return catalogue;
  }

  static void setCatalogue(String? c) {
    catalogue = c;
  }

  static String? getOffercode() {
    return offercode;
  }

  static void setOffercode(String? code) {
    offercode = code;
  }

  static String? getOptioncodelist() {
    return optioncodelist;
  }

  static void setOptioncodelist(String? codes) {
    optioncodelist = codes;
  }

  static String? getDurationcode() {
    return durationcode;
  }

  static void setDurationcode(String? code) {
    durationcode = code;
  }

  static String? getAccountnumberString() {
    return accountnumberString;
  }

  static void setAccountnumberString(String? str) {
    accountnumberString = str;
  }

  static String? getCardnumberString() {
    return cardnumberString;
  }

  static void setCardnumberString(String? str) {
    cardnumberString = str;
  }

  static List<String>? getAccountnumber() {
    return accountnumber;
  }

  static void setAccountnumber(List<String>? strings) {
    accountnumber = strings;
  }

  static List<String>? getCardnumber() {
    return cardnumber;
  }

  static void setCardnumber(List<String>? strings) {
    cardnumber = strings;
  }

  static String? getAmount() {
    return amount;
  }

  static void setAmount(String? amt) {
    amount = amt;
  }

  static String? getToken() {
    return token;
  }

  static void setToken(String? t) {
    token = t;
  }

  static String? getNumcontract() {
    return numcontract;
  }

  static void setNumcontract(String? num) {
    numcontract = num;
  }

  static String? getIdbase() {
    return idbase;
  }

  static void setIdbase(String? id) {
    idbase = id;
  }

  static String? getNumsubscriber() {
    return numsubscriber;
  }

  static void setNumsubscriber(String? num) {
    numsubscriber = num;
  }

  static String? getUserType() {
    return userType;
  }

  static void setUserType(String? type) {
    userType = type;
  }

  static List<String>? getMenuItems() {
    return menuItems;
  }

  static void setMenuItems(List<String>? items) {
    menuItems = items;
  }

  static List<TontineGroupModel>? getTontineGroups() {
    return tontineGroups;
  }

  static void setTontineGroups(List<TontineGroupModel>? groups) {
    tontineGroups = groups;
  }

  static List<CanalBoxModel>? getCanalBoxes() {
    return canalBoxes;
  }

  static void setCanalBoxes(List<CanalBoxModel>? boxes) {
    canalBoxes = boxes;
  }

  static List<MeterModel>? getMeters() {
    return meters;
  }

  static void setMeters(List<MeterModel>? meterList) {
    meters = meterList;
  }

  static List<String>? getAccounts() {
    return accounts;
  }

  static void setAccounts(List<String>? accList) {
    accounts = accList;
  }
}
