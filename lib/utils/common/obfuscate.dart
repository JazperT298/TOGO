// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/pointycastle.dart';

class Obfuscate {
  static final String encoding = decode([0xD5, 0xD5, 0xC4, 0xAE, 0xBC]);
  static final String algorithmAES = decode([0xC1, 0xC4, 0xD1]);
  static final String trasformationAES =
      decode([0xC1, 0xC4, 0xD1, 0xAC, 0xC7, 0xC7, 0xC5, 0xA8, 0xD8, 0xC2, 0xC9, 0xD8, 0xB9, 0xDD, 0xEF, 0xEB, 0xF4, 0xF8, 0xFC, 0xF4]);

  static PaddedBlockCipherImpl? decoderCipher;

  static Uint8List encode(String str) {
    try {
      Uint8List data = Uint8List.fromList(utf8.encode(str));
      for (int i = 0; i < data.length; i++) {
        data[i] = (data[i] ^ (0x80 + (i % 0x80))) & 0xFF;
      }
      return data;
    } catch (e) {
      print(e);
    }
    return Uint8List(0);
  }

  static String decode(List<int> data) {
    try {
      for (int i = 0; i < data.length; i++) {
        data[i] = (data[i] ^ (0x80 + (i % 0x80))) & 0xFF;
      }
      return utf8.decode(data);
    } catch (e) {
      print(e);
    }
    return '';
  }

  static String aesDecoder(Uint8List input) {
    try {
      return utf8.decode(aesDefuscate(input));
    } catch (e) {
      print(e);
    }
    return '';
  }

  static Uint8List aesDefuscate(Uint8List input) {
    try {
      if (decoderCipher == null) {
        decoderCipher = PaddedBlockCipherImpl(
          CBCBlockCipher as Padding,
          AESFastEngine(),
        );
        decoderCipher!.init(
          false,
          ParametersWithIV(
            KeyParameter(Uint8List.fromList(List<int>.generate(16, (i) => i))),
            Uint8List.fromList(List<int>.generate(16, (i) => i)),
          ) as PaddedBlockCipherParameters<CipherParameters?, CipherParameters?>,
        );
      }
      return decoderCipher!.process(Uint8List.fromList(input));
    } catch (e) {
      print(e);
      decoderCipher = null;
    }
    return Uint8List(0);
  }
}
