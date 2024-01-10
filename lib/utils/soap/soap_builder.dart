import 'package:xml/xml.dart' as xml;

class SoapBuilder {
  static String addNumberFromReceiverSoapRequest({
    String? msisdn,
    String? message,
    String? token,
    String? sendsms,
  }) {
    final envelope = xml.XmlBuilder();
    envelope.element('Envelope', namespaces: {
      'i': 'http://www.w3.org/2001/XMLSchema-instance',
      'd': 'http://www.w3.org/2001/XMLSchema',
      'c': 'http://schemas.xmlsoap.org/soap/encoding/',
      'v': 'http://schemas.xmlsoap.org/soap/envelope/',
    }, nest: () {
      envelope.element('Header', nest: () {});
      envelope.element('Body', namespaces: {
        'n0': 'http://applicationmanager.tlc.com',
      }, nest: () {
        envelope.element('n0:RequestToken', nest: () {
          envelope.element('msisdn',
              attributes: {
                'i:type': 'd:string',
              },
              nest: msisdn);
          envelope.element('message',
              attributes: {
                'i:type': 'd:string',
              },
              nest: message);
          envelope.element('token',
              attributes: {
                'i:type': 'd:string',
              },
              nest: token);
          envelope.element('sendsms',
              attributes: {
                'i:type': 'd:string',
              },
              nest: sendsms);
        });
      });
    });

    return envelope.buildDocument().toXmlString(pretty: true);
  }
}
