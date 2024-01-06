// ignore_for_file: prefer_interpolation_to_compose_strings, unused_import

import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:ibank/utils/common/obfuscate.dart';
import 'package:ibank/utils/string_utils.dart';
import 'package:pointycastle/pointycastle.dart';

class EncryptionHelper {
  //  static const String encoding = "UTF-8";
  // static const String algorithmAES = "AES";
  // static const String trasformationAES = "AES/CBC/PKCS5Padding";
  // static const String trasformationRSA = "RSA/ECB/PKCS1Padding";

  static final String encoding = Obfuscate.decode([0xD5, 0xD5, 0xC4, 0xAE, 0xBC]); // UTF-8
  static final String algorithmAES = Obfuscate.decode([0xC1, 0xC4, 0xD1]); // AES
  static final String algorithmRSA = Obfuscate.decode([0xD2, 0xD2, 0xC3]); // RSA
  static final String trasformationAES = Obfuscate.decode([
    0xC1,
    0xC4,
    0xD1,
    0xAC,
    0xC7,
    0xC7,
    0xC5,
    0xA8,
    0xD8,
    0xC2,
    0xC9,
    0xD8,
    0xB9,
    0xDD,
    0xEF,
    0xEB,
    0xF4,
    0xF8,
    0xFC,
    0xF4
  ]); // AES/CBC/PKCS5Padding
  static final String trasformationRSA = Obfuscate.decode([
    0xD2,
    0xD2,
    0xC3,
    0xAC,
    0xC1,
    0xC6,
    0xC4,
    0xA8,
    0xD8,
    0xC2,
    0xC9,
    0xD8,
    0xBD,
    0xDD,
    0xEF,
    0xEB,
    0xF4,
    0xF8,
    0xFC,
    0xF4
  ]); // RSA/ECB/PKCS1Padding
  static final List<int> aes = [
    0xB6,
    0x28,
    0x0F,
    0x63,
    0x3A,
    0x86,
    0x2E,
    0x98,
    0xD9,
    0x51,
    0x55,
    0xA9,
    0xC9,
    0x03,
    0xF7,
    0x3A,
    0x3B,
    0x8C,
    0x91,
    0x7D,
    0xAE,
    0x30,
    0x0E,
    0x5E,
    0x8E,
    0x02,
    0xC0,
    0x2F,
    0x9F,
    0xBD,
    0xBD,
    0x3A
  ];
  static final List<int> shiftEnCode = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    55,
    48,
    57,
    50,
    49,
    52,
    51,
    54,
    53,
    56,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    87,
    74,
    86,
    65,
    71,
    77,
    81,
    85,
    89,
    84,
    73,
    68,
    79,
    88,
    83,
    76,
    70,
    66,
    80,
    90,
    82,
    67,
    69,
    72,
    75,
    78,
    0,
    0,
    0,
    0,
    0,
    0,
    87,
    74,
    86,
    65,
    71,
    77,
    81,
    85,
    89,
    84,
    73,
    68,
    79,
    88,
    83,
    76,
    70,
    66,
    80,
    90,
    82,
    67,
    69,
    72,
    75,
    78,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  static Cipher? encryptRSACipher;
  static int? blocksizeRsa;
  static Cipher? encryptRSACipherData;
  static int? blocksizeRsaData;
  static Cipher? encryptCipher;
  static Cipher? decryptCipher;

  // static String encrypt(BuildContext ctx, String s) {
  //   List<int> plain = utf8.encode(s);
  //   List<int> encoded = ShiftEncode(ctx, plain);
  //   encoded = xor(encoded);
  //   return 'c' + base64Encode(RSAEncrypt(encoded)!);
  // }

  // static String encryptData(BuildContext ctx, String s) {
  //   List<int> plain = utf8.encode(s);
  //   List<int> encoded = ShiftEncode(ctx, plain);
  //   encoded = xor(encoded);
  //   List<int> encrypted = RSAEncryptData(encoded)!;
  //   return 'd' + base64Encode(encrypted);
  // }

  // static String encryptAes(String s) {
  //   List<int> plain = utf8.encode(s);
  //   List<int> encoded = ShiftEncode(null, plain); //add nonce
  //   encoded = xor(encoded);
  //   List<int> enchiper = aesEncrypt(encoded)!;
  //   return 'b' + base64Encode(enchiper);
  // }

  // static List<int> xor(List<int> data) {
  //   for (int i = 0; i < data.length; i++) {
  //     data[i] = (data[i] ^ 0x87) & 0xFF;
  //   }
  //   return data;
  // }

//   static List<int> ShiftEncode(BuildContext? ctx, List<int> input) {
//     //Disable ShiftEncode
//     /*for(short i = 0; i < input.length; i++)
//         if(shiftEnCode[input[i] & 0xff] != 0)
//             input[i] = shiftEnCode[input[i] & 0xff];
//     */
//     String? val = SqlHelper.getProperty( SysProp.PROP_SMS_COUNTER, "") as String;
//     List<int> nonce;
//     int len = 1;
//     if (StringUtils().isNullOrEmpty(val)) {
//       nonce = SecureRandom().nextBytes(len);
//     } else {
//       nonce = StringUtils().hexDecode(val);
//       nonce[0] = (nonce[0] + 1) & 0x7F;
//     }
//     Uint8List buff = Uint8List(0);
//     buff += Uint8List.fromList(nonce); //Add Nonce
//     buff += Uint8List.fromList(input);
//     val = StringUtils().hexEncode(Uint8List.fromList(nonce));
//     SqlHelper.setProperty( SysProp.PROP_SMS_COUNTER, val);
//     return buff;
//   }

//   static List<int>? RSAEncrypt(List<int> input) {
//     //Add header
//     Uint8List buff = Uint8List(0);
//     //buff += Uint8List.fromList([0x03]);
//     if (encryptRSACipher == null) {
//       try {
//         RSAPublicKey key = (RSAPublicKey) SmsPublicKey();
//         encryptRSACipher = Cipher(trasformationRSA); // RSA/ECB/PKCS1Padding
//         encryptRSACipher!.init(Cipher.ENCRYPT_MODE, key);
//         blocksizeRsa = key.getModulus().bitLength ~/ 8;
//       } catch (e) {
//         print(e);
//         return null;
//       }
//     }
//     try {
//       List<int> bytes = List<int>.filled(blocksizeRsa - 11, 0);
//       ByteData b = ByteData.sublistView(Uint8List.fromList(input));
//       int remaining = b.lengthInBytes;
//       int offset = 0;
//       while (remaining > 0) {
//         if (remaining > bytes.length) {
//           for (int i = 0; i < bytes.length; i++) {
//             bytes[i] = b.getUint8(offset + i);
//           }
//           buff += Uint8List.fromList(encryptRSACipher!.doFinal(Uint8List.fromList(bytes)));
//           offset += bytes.length;
//         } else {
//           for (int i = 0; i < remaining; i++) {
//             bytes[i] = b.getUint8(offset + i);
//           }
//           buff += Uint8List.fromList(encryptRSACipher!.doFinal(Uint8List.fromList(bytes.sublist(0, remaining))));
//           offset += remaining;
//         }
//         remaining = b.lengthInBytes - offset;
//       }
//     } catch (e) {
//       encryptRSACipher = null;
//       print(e);
//       return null;
//     }
//     return buff;
//   }

//   static List<int>? RSAEncryptData(List<int> input) {
//     //Add header
//     Uint8List buff = Uint8List(0);
//     //buff += Uint8List.fromList([0x03]);
//     if (encryptRSACipherData == null) {
//       try {
//         encryptRSACipherData = Cipher(trasformationRSA);
//         RSAPublicKey keyData = (RSAPublicKey) DataPublicKey();
//         encryptRSACipherData!.init(Cipher.ENCRYPT_MODE, keyData);
//         blocksizeRsaData = keyData.getModulus().bitLength ~/ 8;
//       } catch (e) {
//         print(e);
//         return null;
//       }
//     }
//     try {
//       List<int> bytes = List<int>.filled(blocksizeRsaData - 11, 0);
//       ByteData b = ByteData.sublistView(Uint8List.fromList(input));
//       int remaining = b.lengthInBytes;
//       int offset = 0;
//       while (remaining > 0) {
//         if (remaining > bytes.length) {
//           for (int i = 0; i < bytes.length; i++) {
//             bytes[i] = b.getUint8(offset + i);
//           }
//           buff += Uint8List.fromList(encryptRSACipherData!.doFinal(Uint8List.fromList(bytes)));
//           offset += bytes.length;
//         } else {
//           for (int i = 0; i < remaining; i++) {
//             bytes[i] = b.getUint8(offset + i);
//           }
//           buff += Uint8List.fromList(encryptRSACipherData!.doFinal(Uint8List.fromList(bytes.sublist(0, remaining))));
//           offset += remaining;
//         }
//         remaining = b.lengthInBytes - offset;
//       }
//     } catch (e) {
//       encryptRSACipherData = null;
//       print(e);
//       return null;
//     }
//     return buff;
//   }
//   static List<int> aesEncrypt(List<int> input) {
//     try {
//       if (encryptCipher == null) {
//         encryptCipher = Cipher(trasformationAES);
//         encryptCipher.init(true, SmsEncryptKey(), IvParameterSpec(getIv(encryptCipher.blockSize)));
//       }
//       return encryptCipher.doFinal(Uint8List.fromList(input));
//     } catch (e) {
//       encryptCipher = null;
//       print(e);
//       return [];
//     }
//   }
// static List<int> aesDecrypt(List<int> input) {
//   try {
//     if (decryptCipher == null) {
//       decryptCipher = Cipher(trasformationAES);
//       decryptCipher!.init(false, SmsEncryptKey(), IvParameterSpec(getIv(decryptCipher.blockSize)));
//     }
//     return Uint8List.fromList(decryptCipher.doFinal(Uint8List.fromList(input)));
//   } catch (e) {
//     decryptCipher = null;
//     print(e);
//    return [];
//   }
// }
//   static Uint8List getIv(int blocksize) {
//     return Uint8List(blocksize);
//   }
}
