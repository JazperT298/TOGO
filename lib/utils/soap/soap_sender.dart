// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, use_build_context_synchronously, unused_local_variable, deprecated_member_use, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/utils/constants/sys_prop.dart';
import 'package:ibank/utils/core/soap_config.dart';
import 'package:ibank/utils/helpers/flooz_helper.dart';
import 'package:ibank/utils/sms/sms_listener.dart';
import 'package:ibank/utils/sms/sms_option_enum.dart';
import 'package:ibank/utils/string_utils.dart';
import 'package:xml2json/xml2json.dart';
import 'package:xml/xml.dart' as xml;

class SoapSender {
  static final String soap_method_name = SoapConfig.soapMethodName;
  static final String soap_action = SoapConfig.soapAction;
  static final String soap_namespace = SoapConfig.soapNameSpace;
  // static final Pattern encrypted = Pattern.compile("<mpos>([^<]+)</mpos>");
  static String soap_url = SoapConfig.soapEndpoint;
  static String finalResponseString = "";
  static bool isLoading = false;

  static Future<void> sendSoap(
    BuildContext ctx,
    String message,
    String destination,
    SmsOption option,
    // SendSmsListener listener,
    String progressMessage,
    bool sendSMS,
  ) async {
    final sendSmsListenerss = SendSmsListeners();

    try {
      String progressWaiting;
      if (progressMessage == null || progressMessage.isEmpty) {
        progressWaiting = 'Sms Progress'; // Replace with your default progress message
      } else {
        progressWaiting = progressMessage;
      }

      CircularProgressIndicator? progressTemp;
      if (ctx == null) {
        return;
      }

      SqlHelper.checkDB2(ctx);
      String? token = await SqlHelper.getToken();
      String stringProperty = await SqlHelper.getProperty(SysProp.PROP_MSISDN, "");
      String? msisdn = StringUtil().isNullOrEmpty2(stringProperty, destination);
      String msg = message; //EncryptionHelper.encryptData(ctx, message);
      print('msg from sendSoap $msg');

      //Log.d("INFODETAILS","1: "+token+"2: "+msisdn+" PLAIN 3: "+message+"4: "+msg);
      print("INFODETAILS" "1: ${token}2: $msisdn PLAIN 3: ${message}4: $msg");

      Map<String, dynamic> parameters = <String, dynamic>{};
      parameters.assign("message", msg);
      parameters.assign("token", token);
      parameters.assign("sendsms", sendSMS ? "true" : "false");

      //Log.d("SOAP REQUEST",parameters.toString());
      // AppConfig.appendLog(ctx, "SOAP REQUEST", parameters.toString());
      print('response soap_url $soap_url');
      print('response soap_action $soap_action');
      print('response soap_namespace $soap_namespace');
      print('response soap_method_name $soap_method_name');
      print('response parameters $parameters');

      final responseString = await invokeSoap(soap_url, soap_action, soap_namespace, soap_method_name, msisdn, msg, token!, "false"); //parameters);
      finalResponseString = responseString;
      print('responseString $responseString');

      // Additional logic based on the responseString
      if (finalResponseString == "REGISTER") {
        print('responseString 1 $responseString');
        SqlHelper.getToken();
      } else if (finalResponseString == 'Data request failed') {
        showToast(ctx, responseString);
      } else {
        final responseJson = parseSoapResponseToJson(responseString);
        print('responseString 2 $responseJson');
        String profile = responseJson.containsKey("profile") ? responseJson["profile"] : "";
        String description = responseJson.containsKey("description") ? responseJson["description"] : "";
        String refid = responseJson.containsKey("refid") ? responseJson["refid"] : "";
        String msg = responseJson.containsKey("message") ? responseJson["message"] : "";
        String status = responseJson.containsKey("status") ? responseJson["status"] : "";

        print("Profile: $profile");
        print("Description: $description");
        print("refid: $refid");
        print("Message: $msg");
        print("Status: $status");

        FloozHelper.setUserType(profile);
        FloozHelper.setMessage(msg);
      }

      if (sendSmsListenerss == null || !sendSmsListenerss.onResponse("mCashier", responseString)) {
        sendSmsListenerss.onResponse("mCashier", responseString);
      }
    } catch (e) {
      // Handle exceptions
      if (sendSmsListenerss == null || !sendSmsListenerss.onFailed('')) {
        sendSmsListenerss.onFailed('');
      }
      debugPrint('Exception Message: sendSoap ${e.toString()}');
    } finally {
      isLoading = false;
    }
  }

  static Future<String> invokeSoap(
      String url, String soapAction, String namespace, String methodName, String msisdn, String msg, String token, String sendsms) async {
    final connect = GetConnect();
    try {
      final soapActionUrl = '$url/$methodName';
      final headers = {'Content-Type': 'application/xml'};
      print('soapActionUrl $methodName');
      print('soapActionUrl $msisdn');
      print('soapActionUrl $msg');
      print('soapActionUrl $token');
      print('soapActionUrl $sendsms');

      final soapEnvelope = buildSoapEnvelope(namespace, methodName, "22896047878", msg, token, sendsms);
      print('soapActionUrl $soapEnvelope');
      final response = await connect.post(url, headers: headers, soapEnvelope);
      print('soapActionUrl ${response.body}');

      // return parseSoapResponse(response.body).toString();
      return response.bodyString.toString();
      // return parseSoapResponseToJson(response.body).toString();
    } catch (e) {
      debugPrint('Exception Message: ${e.toString()}');
      return 'Data request failed';
    }
  }

  static String buildSoapEnvelope(String namespace, String methodName, String msisdn, String msg, String token, String sendsms) {
    final soapEnvelope = '''<v:Envelope
            xmlns:i="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:d="http://www.w3.org/2001/XMLSchema"
            xmlns:c="http://schemas.xmlsoap.org/soap/encoding/"
            xmlns:v="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:web="$namespace">
             	<v:Header/>
              <v:Body>
                <n0:RequestToken
                  xmlns:n0="$namespace">
                  <msisdn i:type="d:string"><![CDATA[$msisdn]]></msisdn>
                  <message i:type="d:string"><![CDATA[$msg]]></message>
                  <token i:type="d:string"><![CDATA[$token]]></token>
                  <sendsms i:type="d:string"><![CDATA[$sendsms]]></sendsms>
                </n0:RequestToken>
              </v:Body>
            </v:Envelope>''';
    return soapEnvelope.trim();
  }

  static Map<String, dynamic> parseSoapResponseToJson(String soapResponse) {
    try {
      var document = xml.XmlDocument.parse(soapResponse);
      var soapBody = document.findAllElements('soapenv:Body').single;
      var requestTokenResponse = soapBody.findAllElements('ns1:RequestTokenResponse').single;
      var requestTokenReturn = requestTokenResponse.findAllElements('RequestTokenReturn').single;

      var jsonString = requestTokenReturn.text;

      // Replace HTML entities
      jsonString = jsonString.replaceAll('&quot;', '"');

      // Convert to JSON
      Map<String, dynamic> json = jsonDecode(jsonString);
      print('resposne $json');
      return json;
    } catch (ex) {
      print('parseSoapResponseToJson $ex');
      rethrow;
    }
  }

  static Map<String, dynamic> parseSoapResponse(String soapResponse) {
    final xml2json = Xml2Json();
    xml2json.parse(soapResponse);
    final jsonString = xml2json.toParker();
    final decodedJson = json.decode(jsonString);
    // final soapBody = document.findAllElements('soapenv:Body').first;
    // final result = soapBody.findElements('web:$soap_method_name').first;

    // You might want to print the jsonString to see its structure.
    // print(jsonString);

    // Assuming soapenv is the SOAP envelope namespace and web is the namespace for your web service.
    final soapBody = decodedJson['soapenv:Envelope']['soapenv:Body'];
    final result = soapBody['web:$soap_method_name'];

    print('response 6 $soapBody');
    // Check if result is null or not, depending on your SOAP response structure.
    print('response 6 $result');
    // return result.toString(); // Return an empty string if result is null.
    // print('response 6 $soapBody');
    return soapBody;
    //   final document = xml.XmlDocument.parse(soapResponse);

    //   // Find the <soapenv:Body> element
    //   final bodyElement = document.findAllElements('soapenv:Body', namespace: 'http://schemas.xmlsoap.org/soap/envelope/').first;

    //   // Parse XML
    //   // final document = xml.XmlDocument.parse(xmlString);

    //   // Convert XML to JSON
    //   final jsonData = _parseXmlElement(bodyElement);

    //   // Print the resulting JSON
    //   print('response 8 ${json.encode(jsonData)}');
    //   return jsonData.toString();
  }

  // static Map<String, dynamic> _parseXmlElement(xml.XmlElement element) {
  //   final Map<String, dynamic> result = {};

  //   // Process child elements
  //   for (var child in element.children) {
  //     if (child is xml.XmlElement) {
  //       final Map<String, dynamic> childData = _parseXmlElement(child);

  //       // Check if the child element name is already present in the result
  //       if (result.containsKey(child.name.toString())) {
  //         // If present, convert the value to a list
  //         dynamic existingValue = result[child.name.toString()];

  //         if (existingValue is List) {
  //           existingValue.add(childData);
  //         } else {
  //           result[child.name.toString()] = [existingValue, childData];
  //         }
  //       } else {
  //         // If not present, add it to the result
  //         result[child.name.toString()] = childData;
  //       }
  //     } else if (child is xml.XmlText) {
  //       // Process text content
  //       result['text'] = child.text;
  //     }
  //   }

  //   return result;
  // }

  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // static void printAllXmlTags(String xmlString) {
  //   final document = xml.XmlDocument.parse(xmlString);
  //   print('response 7 $document');
  //   printXmlTags(document);
  // }

  // static void printXmlTags(xml.XmlNode node) {
  //   if (node is xml.XmlElement) {
  //     print('Tag: ${node.name.local}');
  //     for (var attribute in node.attributes) {
  //       print('  Attribute: ${attribute.name.local} = ${attribute.value}');
  //     }
  //     node.children.forEach(printXmlTags);
  //   }
  // }

  // static Map<String, dynamic> _parseXml(xml.XmlNode node) {
  //   if (node is xml.XmlElement) {
  //     Map<String, dynamic> map = {
  //       'name': node.name.local,
  //     };

  //     for (var attribute in node.attributes) {
  //       map[attribute.name.local] = attribute.value;
  //     }

  //     for (var child in node.children) {
  //       var childMap = _parseXml(child);
  //       var childName = childMap['name'];

  //       if (map.containsKey(childName)) {
  //         if (map[childName] is List) {
  //           map[childName].add(childMap);
  //         } else {
  //           map[childName] = [map[childName], childMap];
  //         }
  //       } else {
  //         map[childName] = childMap;
  //       }
  //     }

  //     return map;
  //   } else {
  //     return {};
  //   }
  // }
}
