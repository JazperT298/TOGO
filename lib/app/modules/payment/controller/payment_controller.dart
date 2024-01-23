import 'package:flukit/flukit.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/models/wallet.dart';

class PaymentController extends GetxController {
  WalletAction walletChild = [
    WalletAction(
      name: 'CEET',
      description: '',
      icon: FluIcons.electricity,
    ),
    WalletAction(
      name: 'Cash Power',
      description: '',
      icon: FluIcons.electricity,
    ),
    WalletAction(
      name: 'TDE',
      description: '',
      icon: FluIcons.sun,
    ),
    WalletAction(
      name: 'Solergie',
      description: '',
      icon: FluIcons.sun,
    ),
    WalletAction(
      name: 'BBox Cizo',
      description: '',
      icon: FluIcons.wallet,
    ),
    WalletAction(
      name: 'Soleva',
      description: '',
      icon: FluIcons.watch,
    ),
    WalletAction(
      name: 'Moon',
      description: '',
      icon: FluIcons.moon,
    ),
  ] as WalletAction;
}
