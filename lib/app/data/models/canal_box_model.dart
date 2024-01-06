// ignore_for_file: prefer_initializing_formals

class CanalBoxModel {
  String? accountNumber;
  String? cardName;
  String? cardNumber;

  CanalBoxModel();

  CanalBoxModel.withData(String accountNumber, String cardName, String cardNumber) {
    this.accountNumber = accountNumber;
    this.cardName = cardName;
    this.cardNumber = cardNumber;
  }

  String? getAccountNumber() {
    return accountNumber;
  }

  void setAccountNumber(String? accountNumber) {
    this.accountNumber = accountNumber;
  }

  String? getCardName() {
    return cardName;
  }

  void setCardName(String? cardName) {
    this.cardName = cardName;
  }

  String? getCardNumber() {
    return cardNumber;
  }

  void setCardNumber(String? cardNumber) {
    this.cardNumber = cardNumber;
  }
}
