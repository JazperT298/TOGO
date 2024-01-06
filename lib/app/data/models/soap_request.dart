class SoapRequest {
  static String buildSoapRequest(String action, String requestBody) {
    return '''
      <?xml version="1.0" encoding="utf-8"?>
      <soapenv:Envelope
        xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
        xmlns:web="http://www.example.com/">
        <soapenv:Header/>
        <soapenv:Body>
          <web:$action>
            $requestBody
          </web:$action>
        </soapenv:Body>
      </soapenv:Envelope>
    ''';
  }
}
