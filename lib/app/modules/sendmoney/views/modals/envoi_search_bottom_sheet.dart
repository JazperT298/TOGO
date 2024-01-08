// ignore_for_file: unused_element, avoid_print

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:ibank/app/data/models/user.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/core/users.dart';

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
  User? selectedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favorites = widget.favorites;
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
                    fontSize: M3FontSizes.headlineSmall,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  'Selectionner une personne.',
                  style: TextStyle(
                    fontSize: M3FontSizes.headlineMedium,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Choisissez le contact à qui vous voulez envoyer de l’argent.',
                    style: TextStyle(
                      fontSize: M3FontSizes.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FluTextField(
                  hint: "Nom ou numéro de téléphone",
                  hintStyle: const TextStyle(fontSize: M3FontSizes.titleMedium),
                  height: 50,
                  cornerRadius: 15,
                  keyboardType: TextInputType.name,
                  fillColor: context.colorScheme.primaryContainer,
                  textStyle: context.textTheme.bodyMedium,
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
                  itemCount: favorites.length,
                  itemBuilder: ((context, index) {
                    final option = favorites[index];
                    return FluButton(
                      onPressed: () {
                        setState(() {
                          if (selectedUser == users[index]) {
                            selectedUser = null; // Deselect the user
                          } else {
                            selectedUser = users[index]; // Select the user
                            print('selected User ${selectedUser!.fullName}');
                            print('selected User ${selectedUser!.phoneNumber}');
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
                            child: Container(
                                height: context.width * .15,
                                width: context.width * .15,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: FluAvatar(
                                  image: option.avatar,
                                  overlayOpacity: .2,
                                  circle: true,
                                )),
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
                                        option.fullName,
                                        style: TextStyle(
                                            fontSize: M3FontSizes.headlineSmall, fontWeight: FontWeight.w600, color: context.colorScheme.onSurface),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          option.phoneNumber.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: M3FontSizes.headlineSmall,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  selectedUser == users[index]
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
                      onPressed: selectedUser != null
                          ? () {
                              print('selected User 2 ${selectedUser!.fullName}');
                              print('selected User 2 ${selectedUser!.phoneNumber}');
                              Navigator.pop(context, selectedUser);
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
}
