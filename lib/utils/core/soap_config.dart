// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoapConfig {
  static String soapEndpoint = "https://flooznfctest.moov-africa.tg/WebReceive?wsdl";
  static String soapAction = ''; // Replace with your SOAP action
  static String soapNameSpace = "http://applicationmanager.tlc.com";
  static String soapMethodName = "RequestToken";

  static get xml => null;
  static late final GetConnect connect;

  static Future<Object?> invoke(BuildContext context, Map<String, dynamic> parameters) async {
    return await invoke3(soapEndpoint, soapAction, soapNameSpace, soapMethodName, parameters, 0);
  }

  static Future<Object?> invoke2(
      BuildContext context, String url, String soapaction, String namespace, String methodname, Map<String, dynamic> parameters) {
    return invoke3(url, soapaction, namespace, methodname, parameters, 0);
  }

  static Future<Object?> invoke3(
    String url,
    String soapAction,
    String namespace,
    String methodName,
    Map<String, dynamic> parameters,
    int stack,
  ) async {
    try {
      print("URL: $url");

      final request = xml.XmlBuilder();
      request.element(xml.XmlName(namespace, methodName), nest: () {
        parameters.forEach((key, value) {
          request.element(xml.XmlName(namespace, key), nest: () {
            request.text(value.toString());
          });
        });
      });

      final response = await connect.post(
        Uri.parse(url).toString(),
        headers: {
          'Content-Type': 'text/xml; charset=utf-8',
          'SOAPAction': soapAction,
        },
        request.buildDocument().toXmlString(pretty: true),
      );

      final responseBody = response.body;

      // Parse the XML response
      final xmlDocument = xml.XmlDocument.parse(responseBody);

      final soapBody = xmlDocument.findElements('soap:Body').first;
      final responseElement = soapBody.firstChild;
      final responseValue = responseElement.text;

      print("SOAP XML REQUEST: ${response.body}");
      print("SOAP XML RESPONSE: $responseBody");
      print("SOAP RESPONSE: $responseValue");

      if (response.statusCode == 200) {
        if (responseValue == 'INVALID OTP') {
          return 'OTP is invalid';
        } else if (responseValue == 'OTP EXPIRED') {
          return 'OTP has expired';
        } else {
          return responseValue;
        }
      } else {
        return 'Data request failed';
      }
    } catch (e) {
      print('SOAP RESPONSE: $e');

      if (stack < 2) {
        return invoke3(url, soapAction, namespace, methodName, parameters, stack + 1);
      }

      return null;
    }
  }
}
