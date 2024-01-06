// ignore_for_file: prefer_initializing_formals

class MeterModel {
  String? accountNumber;
  String? msisdn;

  MeterModel();

  MeterModel.withData(String accountNumber, String msisdn) {
    this.accountNumber = accountNumber;
    this.msisdn = msisdn;
  }

  String? getAccountNumber() {
    return accountNumber;
  }

  void setAccountNumber(String? accountNumber) {
    this.accountNumber = accountNumber;
  }

  String? getMsisdn() {
    return msisdn;
  }

  void setMsisdn(String? msisdn) {
    this.msisdn = msisdn;
  }
}
