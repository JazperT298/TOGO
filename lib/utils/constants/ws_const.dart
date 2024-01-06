///[WsConst] this class is used to store web service urls
class WsConst {
  WsConst._();

  static const publicKey =
      "MIGSMA0GCSqGSIb3DQEBAQUAA4GAADB9AnYApuNUgQXg+H7BLNRt8yTUhqJ2H1a2uWtPEHK8H88vgLg8sl2CV6Zmt70Xm+Fmv8+AgNkzwmHjBIz2s9hads5SDSIvjW8GuiMXn+JpLafsj/ftvVlgdz0Q+Gmws9m5oVpL/C4GhqC1lNXmEqxC5k9hpmzo/6KrAgMBAAE=";

  //UAT = https://flooznfctest.moov-africa.tg/WebReceive?wsdl
  static const baseURL = "https://flooznfctest.moov-africa.tg/WebReceive?wsdl";
  // UAT = kyctest/inquiry
  // PROD = gatewayprod/8ctRjbhxpq9L37V3nPRR
  static const verifyMsisdn = "kyctest/inquiry";
  // UAT = kyctest/register
  // PROD = gatewayprod/8tJW3SnJnsdeDMcXHg4R
  static const register = "kyctest/register";
}
