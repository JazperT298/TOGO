// ignore_for_file: unnecessary_null_comparison, avoid_print, unused_local_variable

import 'dart:typed_data';

class StringUtils {
  // // char[] base64Table = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".toCharArray();
  late String base64Table = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

  // Convert the base64Table string to a list of characters
  // List<int> base64TableList = base64Table.runes.toList();

  // // Example: Encoding a string to base64
  // String originalString = "Hello, World!";
  // List<int> bytes = originalString.codeUnits;
  // String encodedString = base64Encode(bytes, base64TableList);

  // print("Original String: $originalString");
  // print("Encoded String: $encodedString");

  // // Example: Decoding a base64 string
  // String decodedString = base64Decode(encodedString, base64TableList);
  // print("Decoded String: $decodedString");

  String base64Encode(List<int> bytes, List<int> base64Table) {
    StringBuffer result = StringBuffer();
    int padding = 0;

    for (int i = 0; i < bytes.length; i += 3) {
      int num = (bytes[i] & 0xFF) << 16;
      if (i + 1 < bytes.length) num |= (bytes[i + 1] & 0xFF) << 8;
      if (i + 2 < bytes.length) num |= bytes[i + 2] & 0xFF;

      for (int j = 0; j < 4; j++) {
        if (i + j * 3 < bytes.length) {
          int index = (num & 0xFC0000) >> 18;
          result.write(String.fromCharCode(base64Table[index]));
          num <<= 6;
        } else {
          result.write('=');
          padding++;
        }
      }
    }

    return result.toString();
  }

  String base64Decode(String encodedString, List<int> base64Table) {
    StringBuffer result = StringBuffer();
    List<int> bytes = encodedString.runes.toList();

    for (int i = 0; i < bytes.length; i += 4) {
      int num = 0;

      for (int j = 0; j < 4; j++) {
        int index = base64Table.indexOf(bytes[i + j]);
        num = (num << 6) | index;
      }

      for (int j = 2; j >= 0; j--) {
        if (i + j * 3 < bytes.length) {
          int byteValue = (num & (0xFF << (j * 8))) >> (j * 8);
          result.write(String.fromCharCode(byteValue));
        }
      }
    }

    return result.toString();
  }

  bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  String isNullOrEmpty2(String? value, String defaultValue) {
    if (value == null || value.isEmpty || value.trim() == "") {
      return defaultValue;
    } else {
      return value;
    }
  }

  String setText(String? value, String desiredValue, String defaultValue) {
    if (value == null || value.isEmpty || value.trim() == "") {
      return defaultValue;
    } else {
      return desiredValue;
    }
  }

  String hexEncode(List<int> input) {
    StringBuffer result = StringBuffer();

    for (int byteValue in input) {
      result.write(hexTable[(byteValue & 0xff) >> 4]);
      result.write(hexTable[byteValue & 0x0f]);
    }

    return result.toString();
  }

  List<String> hexTable = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'];

  List<int> hexDecode(String input) {
    try {
      const int mask = 0xff;
      List<int> result = Uint8List((input.length / 2).ceil());
      int resultIndex = 0;

      for (int i = 0; i < input.length;) {
        int a = hexByte[input.codeUnitAt(i++)];
        int b = hexByte[input.codeUnitAt(i++)];
        result[resultIndex++] = ((a << 4) | b) & mask;
      }

      return result;
    } catch (e) {
      print('ERROR $hexDecode');
      rethrow;
    }
  }

  List<int> hexByte = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    70,
    71,
    72,
    73,
    74,
    75,
    76,
    77,
    78,
    79,
    80,
    81,
    82,
    83,
    84,
    85,
    86,
    87,
    88,
    89,
    90,
    91,
    92,
    93,
    94,
    95,
    96,
    97,
    98,
    99,
    100,
    101,
    102,
    103,
    104,
    105,
    106,
    107,
    108,
    109,
    110,
    111,
    112,
    113,
    114,
    115,
    116,
    117,
    118,
    119,
    120,
    121,
    122,
    123,
    124,
    125,
    126,
    127,
    128,
    129,
    130,
    131,
    132,
    133,
    134,
    135,
    136,
    137,
    138,
    139,
    140,
    141,
    142,
    143,
    144,
    145,
    146,
    147,
    148,
    149,
    150,
    151,
    152,
    153,
    154,
    155,
    156,
    157,
    158,
    159,
    160,
    161,
    162,
    163,
    164,
    165,
    166,
    167,
    168,
    169,
    170,
    171,
    172,
    173,
    174,
    175,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    187,
    188,
    189,
    190,
    191,
    192,
    193,
    194,
    195,
    196,
    197,
    198,
    199,
    200,
    201,
    202,
    203,
    204,
    205,
    206,
    207,
    208,
    209,
    210,
    211,
    212,
    213,
    214,
    215,
    216,
    217,
    218,
    219,
    220,
    221,
    222,
    223,
    224,
    225,
    226,
    227,
    228,
    229,
    230,
    231,
    232,
    233,
    234,
    235,
    236,
    237,
    238,
    239,
    240,
    241,
    242,
    243,
    244,
    245,
    246,
    247,
    248,
    249,
    250,
    251,
    252,
    253,
    254,
    255
  ];
}

String maskString(String text, int start, int end, String maskChar) {
  try {
    if (text == null || text.isEmpty) {
      return "";
    }

    if (start < 0) {
      start = 0;
    }

    if (end > text.length) {
      end = text.length;
    }

    if (start > end) {
      return text;
    }

    int maskedLength = end - start;

    if (maskedLength == 0) return text;

    String maskedSubstring = List.filled(maskedLength, maskChar).join();

    return text.substring(0, start) + maskedSubstring + text.substring(start + maskedLength);
  } catch (e) {
    print(e.toString());
    return text;
  }
}

int difference(String? text1, String? text2) {
  if (isNullOrEmpty(text1) && isNullOrEmpty(text2)) return 0;

  int count = 0;

  if (text1!.length > text2!.length) {
    for (int i = 0; i < text1.length; i++) {
      var holder = text1[i];

      if (i < text2.length) {
        if (text2[i] != holder) {
          count++;
        }
      } else {
        // count excess characters from text1
        count++;
      }
    }
  } else if (text2.length > text1.length) {
    for (int i = 0; i < text2.length; i++) {
      var holder = text2[i];

      if (i < text1.length) {
        if (text1[i] != holder) {
          count++;
        }
      } else {
        // count excess characters from text2
        count++;
      }
    }
  } else {
    for (int i = 0; i < text1.length; i++) {
      var holder = text1[i];
      if (text2[i] != holder) {
        count++;
      }
    }
  }

  return count;
}

bool isNullOrEmpty(String? value) {
  return value == null || value.isEmpty;
}
