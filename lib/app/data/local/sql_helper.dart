// ignore_for_file: prefer_conditional_assignment, unnecessary_null_comparison, constant_identifier_names, use_build_context_synchronously, avoid_print, unrelated_type_equality_checks

import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibank/utils/constants/app_config.dart';
import 'package:ibank/utils/constants/sys_prop.dart';
import 'package:ibank/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pointycastle/api.dart' as crypto;

class SqlHelper {
  static Database? _database;
  static const String DATABASE_NAME = 'mcomm';

  // Ensure a singleton instance of the database
  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), DATABASE_NAME);

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create tables here
        await db.execute('''
          CREATE TABLE IF NOT EXISTS TBLPROPERTIES(
            PKEY INTEGER NOT NULL PRIMARY KEY,
            VALUE TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS TBLHISTORY(
            PKEY INTEGER NOT NULL PRIMARY KEY ASC AUTOINCREMENT,
            DATETIME INTEGER,
            MESSAGE TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS TBLBENEFICIARIES(
            PKEY INTEGER NOT NULL PRIMARY KEY ASC AUTOINCREMENT,
            DISPLAYNAME TEXT, FIRSTNAME TEXT, LASTNAME TEXT, IDNUMBER TEXT, COUNTRY TEXT, CITY TEXT, ADDRESS TEXT, BANK TEXT, BANKBRANCH TEXT, ACCOUNTNUMBER TEXT, CONTACTNUMBER TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS TBLSHOPCCART(
            PKEY INTEGER NOT NULL PRIMARY KEY ASC AUTOINCREMENT,
            NAME TEXT, DETAILS TEXT, BARCODE TEXT, STOCK TEXT, QUANTITY TEXT, PRICE TEXT,MERCHANT TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS TBLSHOPPINGMENU(
            PKEY INTEGER NOT NULL PRIMARY KEY ASC AUTOINCREMENT,
           MERCHANT TEXT,ID INTEGER NOT NULL, PARENTID INTEGER NOT NULL, NAME TEXT, DESCRIPTION TEXT, BARCODE TEXT, IMAGE TEXT, PRICE TEXT, TITLE TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS TBLSHOPPINGMENUVERSION(
            PKEY INTEGER NOT NULL PRIMARY KEY ASC AUTOINCREMENT,
           MERCHANT TEXT, VERSION TEXT
          );
        ''');
      },
    );
  }

  static void upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrade logic here
    // You can drop tables or perform other upgrade tasks
  }

  static Future<void> upgrade() async {
    final db = await database;

    // Perform upgrade logic
    await db.execute('DROP TABLE IF EXISTS TBLPROPERTIES;');
    await db.execute('DROP TABLE IF EXISTS TBLHISTORY;');
    // Drop other tables...

    // Call upgradeDatabase if necessary
    // upgradeDatabase(db, oldVersion, newVersion);
  }

  static void closeDatabase(Database db) {
    if (db.isOpen) db.close();
  }

  static Future<String> getProperty(int key, String defaultValue) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT VALUE FROM TBLPROPERTIES WHERE PKEY = ?',
        [key.toString()],
      );
      // if (result.isNotEmpty) {
      //   final encryptedValue = result[0]['VALUE'];
      //   final decryptedBytes = await decryptValue(encryptedValue);
      //   return utf8.decode(decryptedBytes);
      // }
      print('verifyMsisdn defaultValue 1 $result');
      print('verifyMsisdn defaultValue 1ss ${defaultValue.characters.toString().trim().replaceAll(".", "")}');

      // return defaultValue.replaceAll(".", "");
      // return result.toString().replaceAll(".", "");
      var results = defaultValue.characters.toString().trim().replaceAll(".", "");
      print('verifyMsisdn defaultValue 1s $results');
      return results;
    } catch (e) {
      print('getProperty ${e.toString()}');
      rethrow;
    }
  }

  static Future<bool> setProperty(int key, String value) async {
    final db = await database;

    try {
      // final bytes = utf8.encode(value);
      // final encryptedBytes = await encryptValue(bytes);
      // print('setProperty 1 $bytes');
      // print('setProperty 2 $encryptedBytes');
      final contentValues = {
        'VALUE': value, // base64.encode(encryptedBytes),
        'PKEY': key,
      };
      print('setProperty 3 $contentValues');
      final rowsUpdated = await db.update(
        'TBLPROPERTIES',
        contentValues,
        where: 'PKEY = ?',
        whereArgs: [key],
      );
      print('setProperty 4 $contentValues');
      if (rowsUpdated != 1) {
        final newRowId = await db.insert('TBLPROPERTIES', contentValues);
        return newRowId != -1;
      }

      return true;
    } catch (ex) {
      print('Error: setProperty $ex');
      return false;
    }
  }

  static Future<String?> getToken() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      // Request permission if not granted
      if (!(await _checkPermission())) {
        return null;
      }

      // if (deviceInfoPlugin == 'bypass') {
      //   return 'BuildConfig.BYPASS_TOKEN';
      //   /* Add your flavor-specific token here */
      // } else {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      print('getToken ${androidInfo.id}');
      return androidInfo.id;
      // }
    } on PlatformException {
      print('getToken ');
      return null;
    } catch (e) {
      print('getToken $e');
      rethrow;
    }
  }

  static Future<bool> setMessage(String message) async {
    final db = await database;

    try {
      final limit = await getProperty(SysProp.PROP_HISTORY_LIMIT, "100");
      final contentValues = {
        'MESSAGE': message,
        'DATETIME': DateTime.now().millisecondsSinceEpoch,
      };

      final newRowId = await db.insert('TBLHISTORY', contentValues);

      if (!StringUtils().isNullOrEmpty(limit) && int.parse(limit) > 0) {
        await db.rawDelete('DELETE FROM TBLHISTORY WHERE PKEY IN (SELECT PKEY FROM TBLHISTORY ORDER BY PKEY DESC LIMIT -1 OFFSET ?)', [limit]);
      }

      return newRowId != -1;
    } catch (ex) {
      print('Error: setMessage $ex');
      return false;
    }
  }

  static Future<List<String>> getMessages() async {
    final format = DateFormat('HH:mm, dd MMM yyyy', 'en_US');
    final db = await database;

    try {
      final result = await db.query(
        'TBLHISTORY',
        columns: ['MESSAGE', 'DATETIME'],
        orderBy: 'PKEY DESC',
      );

      final messages = <String>[];
      for (final row in result) {
        messages.add(row['MESSAGE'] as String);
        messages.add(format.format(DateTime.fromMillisecondsSinceEpoch(row['DATETIME'] as int)));
      }

      return messages;
    } catch (ex) {
      print('Error: getMessages $ex');
      return [];
    }
  }

  static Future<bool> setBeneficiary(String id, String display, String firstname, String lastname, String idnumber, String country, String city,
      String address, String bank, String bankbranch, String accountnumber, String contactnumber) async {
    final db = await database;

    try {
      final contentValues = {
        'DISPLAYNAME': display,
        'FIRSTNAME': firstname,
        'LASTNAME': lastname,
        'IDNUMBER': idnumber,
        'COUNTRY': country,
        'CITY': city,
        'ADDRESS': address,
        'BANK': bank,
        'BANKBRANCH': bankbranch,
        'ACCOUNTNUMBER': accountnumber,
        'CONTACTNUMBER': contactnumber,
      };

      final rowsUpdated = await db.update(
        'TBLBENEFICIARIES',
        contentValues,
        where: 'PKEY = ?',
        whereArgs: [id],
      );

      if (rowsUpdated != 1) {
        final newRowId = await db.insert('TBLBENEFICIARIES', contentValues);
        return newRowId != -1;
      }

      return true;
    } catch (ex) {
      print('Error: setBeneficiary $ex');
      return false;
    }
  }

  static Future<List<String>> getBeneficiaries() async {
    final db = await database;

    try {
      final result = await db.query(
        'TBLBENEFICIARIES',
        columns: ['DISPLAYNAME'],
        orderBy: 'DISPLAYNAME ASC',
      );

      final beneficiaries = result.map((row) => row['DISPLAYNAME'].toString()).toList();
      return beneficiaries;
    } catch (ex) {
      print('Error: getBeneficiaries $ex');
      return [];
    }
  }

  static Future<List<String>> getBeneficiary(String displayname) async {
    final db = await database;

    try {
      final result = await db.query(
        'TBLBENEFICIARIES',
        columns: [
          'PKEY',
          'DISPLAYNAME',
          'FIRSTNAME',
          'LASTNAME',
          'IDNUMBER',
          'COUNTRY',
          'CITY',
          'ADDRESS',
          'BANK',
          'BANKBRANCH',
          'ACCOUNTNUMBER',
          'CONTACTNUMBER'
        ],
        where: 'DISPLAYNAME = ?',
        whereArgs: [displayname],
      );

      if (result.isNotEmpty) {
        final beneficiary = result.map((row) => row.values.map((value) => value.toString()).toList()).toList();
        return beneficiary[0];
      }

      return [];
    } catch (ex) {
      print('Error: getBeneficiary $ex');
      return [];
    }
  }

  static Future<bool> deleteBeneficiary(String displayname) async {
    final db = await database;

    try {
      final rowsDeleted = await db.delete(
        'TBLBENEFICIARIES',
        where: 'DISPLAYNAME = ?',
        whereArgs: [displayname],
      );

      return rowsDeleted > 0;
    } catch (ex) {
      print('Error: deleteBeneficiary $ex');
      return false;
    }
  }

  static Future<void> checkDB(BuildContext context) async {
    String? token = await getToken();
    print('token from checkDB 1 $token');

    if (token == null) {
      // Handle the case where token cannot be obtained
      // Display an alert and exit the application
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Notify'),
          content: const Text('Enable all permissions to proceed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    } else {
      String dbToken = await getProperty(SysProp.PROP_TOKEN, "");
      print('token from checkDB 2 $dbToken');
      if (token != getProperty(SysProp.PROP_TOKEN, "")) {
        // await deleteTables();
        print('token from setProperty ${SysProp.PROP_TOKEN} token $token}');
        await setProperty(SysProp.PROP_TOKEN, token);

        if (StringUtils().isNullOrEmpty(AppConfig.mobilemsisdn)) {
          await setProperty(SysProp.PROP_MSISDN, "");
        } else {
          // Uncomment the line below if PROP_MSISDN is not used
          await setProperty(SysProp.PROP_MSISDN, AppConfig.mobilemsisdn);
        }
      }
    }
  }

  static Future<bool> checkDB2(BuildContext context) async {
    String? token = await getToken();
    print('token from checkDB 2 $token');
    String dbToken = await getProperty(SysProp.PROP_TOKEN, "");
    if (token != dbToken) {
      if (StringUtils().isNullOrEmpty(dbToken)) {
        // await deleteTables();
        if (StringUtils().isNullOrEmpty(AppConfig.mobilemsisdn)) {
          await setProperty(SysProp.PROP_MSISDN, "");
        } else {}
        return true;
      }
      return false;
    }
    return true;
  }

  static Future<void> deleteTables() async {
    final db = await database;

    try {
      await db.delete('TBLHISTORY');
      await db.delete('TBLBENEFICIARIES');
      await db.delete('TBLSHOPCCART');
      await setProperty(SysProp.PROP_TOKEN, '');
      await setProperty(SysProp.PROP_MSISDN, '');
      await setProperty(SysProp.PROP_MERCHANT, '');
      await setProperty(SysProp.PROP_VERSION_CODE, '');
      await setProperty(SysProp.PROP_VERSION_NAME, '');
    } catch (ex) {
      print('Error: deleteTables $ex');
    } finally {
      closeDatabase(db);
    }
  }

  static Future<List<int>> encryptValue(List<int> value) async {
    // Replace this with your AES encryption logic using pointycastle
    // Ensure you handle exceptions appropriately
    try {
      final keyBytes = Uint8List.fromList([
        0x2b,
        0x7e,
        0x15,
        0x16,
        0x28,
        0xae,
        0xd2,
        0xa6,
        0xab,
        0xf7,
        0x97,
        0x75,
        0x46,
        0x20,
        0x63,
        0xed,
        0xa8,
        0xcd,
        0xa7,
        0x73,
        0x21,
        0x34,
        0x6a,
        0x9d,
        0x35,
        0x69,
        0xa8,
        0x4f,
        0xe3,
        0xca,
        0xa3,
        0x2e
      ]);
      final ivBytes = Uint8List.fromList([0x1a, 0x5f, 0x2a, 0x5c, 0x04, 0x78, 0x56, 0x2e, 0xe8, 0xd5, 0x98, 0x24, 0x7b, 0x0a, 0xf2, 0xb8]);

      final keyParam = crypto.KeyParameter(keyBytes);
      final params = crypto.ParametersWithIV(keyParam, ivBytes);

      final cipher = crypto.BlockCipher('AES/CBC')..init(true, params);

      return cipher.process(Uint8List.fromList(value));
    } catch (e) {
      print('ERROR encryptValue');
      rethrow;
    }
  }

  static Future<List<int>> decryptValue(String encryptedValue) async {
    // Add your decryption logic here
    // Example: Use a package like pointycastle for AES decryption
    // Ensure you handle exceptions appropriately
    // Replace this with your AES decryption logic using pointycastle
    // Ensure you handle exceptions appropriately
    try {
      final keyBytes = Uint8List.fromList([
        0x2b,
        0x7e,
        0x15,
        0x16,
        0x28,
        0xae,
        0xd2,
        0xa6,
        0xab,
        0xf7,
        0x97,
        0x75,
        0x46,
        0x20,
        0x63,
        0xed,
        0xa8,
        0xcd,
        0xa7,
        0x73,
        0x21,
        0x34,
        0x6a,
        0x9d,
        0x35,
        0x69,
        0xa8,
        0x4f,
        0xe3,
        0xca,
        0xa3,
        0x2e
      ]);
      final ivBytes = Uint8List.fromList([0x1a, 0x5f, 0x2a, 0x5c, 0x04, 0x78, 0x56, 0x2e, 0xe8, 0xd5, 0x98, 0x24, 0x7b, 0x0a, 0xf2, 0xb8]);

      final keyParam = crypto.KeyParameter(keyBytes);
      final params = crypto.ParametersWithIV(keyParam, ivBytes);

      final cipher = crypto.BlockCipher('AES/CBC')..init(false, params);

      final encryptedBytes = base64.decode(encryptedValue);
      final decryptedBytes = Uint8List.fromList(cipher.process(encryptedBytes));

      return decryptedBytes;
    } catch (e) {
      print('ERROR decryptValue $e');
      rethrow;
    }
  }
}

Future<bool> _checkPermission() async {
  // Check if permission is granted
  // You may need to add the necessary permissions to your AndroidManifest.xml
  // e.g., <uses-permission android:name="android.permission.READ_PHONE_STATE" />
  // Replace with the actual permission needed for your use case.
  // For getting Android ID, READ_PHONE_STATE permission is not required.
  try {
    final status = await Permission.phone.status;
    if (status.isGranted) {
      return true;
    } else {
      final result = await Permission.phone.request();
      return result.isGranted;
    }
  } catch (e) {
    return false;
  }
}
