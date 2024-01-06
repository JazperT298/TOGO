// ignore_for_file: unused_local_variable

import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/utils/constants/app_config.dart';
import 'package:ibank/utils/constants/sys_prop.dart';
import 'package:ibank/utils/handlers/message_handler.dart';

class EulaOTAHandler implements Handler {
  static RegExp syntax = RegExp(r"^REGIS:([^:]+):([^:]+):([^:]+):([^:]+):([^:]+):(.+)$");

  @override
  Future<bool> parseMessage(Message msg) async {
    Match? match = syntax.firstMatch(msg.msg);

    if (match == null) {
      return false;
    }

    // String status = match.group(1);
    String refid = match.group(2)!;

    SqlHelper.setProperty(SysProp.PROP_MSISDN, match.group(3)!);
    SqlHelper.setProperty(SysProp.PROP_BANK_FIRSTNAME, match.group(4)!);
    SqlHelper.setProperty(SysProp.PROP_BANK_LASTNAME, match.group(5)!);
    SqlHelper.setProperty(SysProp.PROP_TOKEN, SqlHelper.getToken() as String);
    String message = match.group(6)!;

    // SqlHelper.setHistoryMessage(msg.ctx, refid, message);
    // msg.msg = message;
    SqlHelper.setProperty(SysProp.PROP_VERSION_CODE, AppConfig.app_version_code);
    SqlHelper.setProperty(SysProp.PROP_VERSION_NAME, AppConfig.app_version_name);

    // SqlHelper.setProperty(msg.ctx, SysProp.PROP_FIRST_INSTALL, "0"); // Empty string if fresh install
    // AppSessionManager.newInstance(msg.ctx).setFirstInstall(false); // New EULA flow

    return true;
  }
}
