// ignore_for_file: unused_element, avoid_print, unnecessary_null_comparison, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:ibank/app/data/models/user.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_colors.dart';
import 'package:ibank/utils/core/users.dart';
import 'package:permission_handler/permission_handler.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Container(
          height: isKeyboardVisible ? context.height * 0.90 : context.height * 0.80,
          decoration: BoxDecoration(
            color: context.colorScheme.background,
          ),
          child: EnvoiSearchBottomSheet(favorites: users..shuffle()));
    });
  }
}

class EnvoiSearchBottomSheet extends StatefulWidget {
  const EnvoiSearchBottomSheet({super.key, required this.favorites});
  final List<User> favorites;
  @override
  State<EnvoiSearchBottomSheet> createState() => _EnvoiSearchBottomSheetState();
}

class _EnvoiSearchBottomSheetState extends State<EnvoiSearchBottomSheet> {
  late final List<User> favorites;
  late final List<String> userFullnames;
  late final List<String> userNumbers;

  List<Contact>? _contacts = [];
  bool _permissionDenied = false;

  User? selectedUser;
  Contact? selectedContacts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favorites = widget.favorites;

    // _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);

      print('_permissionDenied $_permissionDenied');
    } else {
      var contacts = await FlutterContacts.getContacts();
      contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
      setState(() => _contacts = contacts);
      print('_contacts $_contacts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Stack(
        children: [
          SingleChildScrollView(
            padding: UISettings.pagePadding.copyWith(
              top: context.height * .025,
              bottom: context.height * .025,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ENVOI',
                  style: TextStyle(
                    color: context.colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: M3FontSizes.bodyMedium,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  'Selectionner une personne.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Choisissez le contact à qui vous voulez envoyer de l’argent.',
                    style: TextStyle(
                      fontSize: M3FontSizes.titleSmall,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FluTextField(
                  hint: "Nom ou numéro de téléphone",
                  height: 50,
                  cornerRadius: 15,
                  keyboardType: TextInputType.name,
                  fillColor: context.colorScheme.primaryContainer,
                  hintStyle: const TextStyle(fontSize: M3FontSizes.titleSmall),
                  textStyle: const TextStyle(fontSize: M3FontSizes.titleSmall),
                  suffixIcon: FluIcons.refresh,
                ),
                FluLine(
                  height: 1,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: context.height * .025),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _contacts!.length, // favorites.length,
                  itemBuilder: ((context, index) {
                    final option = favorites[index];
                    return FluButton(
                      onPressed: () {
                        setState(() {
                          if (selectedContacts == _contacts![index]) {
                            selectedContacts = null; // Deselect the user
                          } else {
                            selectedContacts = _contacts![index]; // Select the user
                            print('selected User ${selectedContacts!.displayName}');
                            print('selected number $selectedContacts');
                            print('selected ${selectedContacts!.phones.map((phone) => phone.toString()).join(", ")}');
                          }
                        });
                      },
                      backgroundColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
                      child: Row(
                        children: [
                          FluArc(
                            startOfArc: 90,
                            angle: 80,
                            strokeWidth: 1,
                            color: context.colorScheme.primaryContainer,
                            // child: Container(
                            //     height: context.width * .15,
                            //     width: context.width * .15,
                            //     margin: const EdgeInsets.all(5),
                            //     decoration: BoxDecoration(
                            //       color: context.colorScheme.primaryContainer,
                            //       borderRadius: BorderRadius.circular(50),
                            //     ),
                            //     child: FluAvatar(
                            //       image: option.avatar,
                            //       overlayOpacity: .2,
                            //       circle: true,
                            //     )),
                            child: Container(
                              height: context.width * .15,
                              width: context.width * .15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.getRandomColor(),
                              ),
                              child: Center(
                                child: Text(
                                  option.firstName.substring(0, 1),
                                  style: const TextStyle(
                                    color: Colors.white, // You can change the text color
                                    fontSize: 24.0, // You can adjust the font size
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // option.fullName,
                                        _contacts![index].displayName.toString(),
                                        style: TextStyle(
                                            fontSize: M3FontSizes.bodyLarge, fontWeight: FontWeight.w600, color: context.colorScheme.onSurface),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          // option.phoneNumber.toString(),

                                          _contacts![index].phones.isEmpty ? " " : _contacts![index].phones[0].number.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: M3FontSizes.titleSmall,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  selectedContacts == _contacts![index]
                                      ? const FluIcon(FluIcons.checkCircleUnicon, color: Colors.green)
                                      : const FluIcon(FluIcons.checkCircleUnicon, color: Colors.transparent)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 55)
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: isKeyboardVisible ? false : true,
                child: Container(
                  height: 65,
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: UISettings.pagePadding.copyWith(top: 8, left: 24, right: 24),
                    child: FluButton.text(
                      'Saisir le montant',
                      suffixIcon: FluIcons.arrowRight,
                      iconStrokeWidth: 1.8,
                      onPressed: selectedContacts != null
                          ? () {
                              String formatPhone = formatPhoneNumber(selectedContacts!.phones[0].number.trim());
                              String countryCode = selectedContacts!.phones[0].number.substring(0, 3);
                              // print('selected User 2  $formatPhone');
                              print('selected User 2 ${selectedContacts!.phones[0].number}');

                              Navigator.pop(
                                context,
                                {
                                  'formatPhone': formatPhone,
                                  'countryCode': countryCode,
                                },
                              );
                            }
                          : null,
                      height: 50,
                      width: context.width * 16,
                      cornerRadius: UISettings.minButtonCornerRadius,
                      backgroundColor: context.colorScheme.primary,
                      foregroundColor: context.colorScheme.onPrimary,
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.primary.withOpacity(.35),
                          blurRadius: 25,
                          spreadRadius: 3,
                          offset: const Offset(0, 5),
                        )
                      ],
                      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
                    ),
                  ),
                ),
              ))
        ],
      );
    });
  }

  String formatPhoneNumber(String number) {
    // Remove any non-digit characters from the input number
    String cleanedNumber = number.replaceAll(RegExp(r'\D'), '');

    // Check if the cleaned number has a length of at least 8
    if (cleanedNumber.length >= 8) {
      // Remove the first three digits and then apply the desired formatting
      return cleanedNumber.substring(3, 5) +
          ' ' +
          cleanedNumber.substring(5, 7) +
          ' ' +
          cleanedNumber.substring(7, 9) +
          ' ' +
          cleanedNumber.substring(9);
    } else {
      // If the input is not valid, return the original number
      return number;
    }
  }
}
