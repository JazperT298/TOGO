import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/newfav/controller/newfav_controller.dart';
import 'package:ibank/utils/configs.dart';

class NewFavView extends GetView<NewFavController> {
  const NewFavView({super.key});

  Future<List<Contact>> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (fully fetched)
      return await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
    } else {
      return [];
    }
  }

  void onContactTap(BuildContext context, Contact contact) {
    // KRouter.to(context, Routes.transfer);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(NewFavController());
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: UISettings.pagePadding.copyWith(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FluButton.icon(
                        FluIcons.arrowLeft,
                        size: UISettings.minButtonSize,
                        cornerRadius: UISettings.minButtonCornerRadius,
                        onPressed: () => Get.back(),
                      ),
                      const Spacer(),
                      FluButton.text(
                        "Ajouter favoris",
                        suffixIcon: FluIcons.arrowRight,
                        iconSize: 16,
                        height: UISettings.minButtonSize,
                        cornerRadius: UISettings.minButtonCornerRadius,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        margin: const EdgeInsets.only(left: 10),
                        backgroundColor: context.colorScheme.primary,
                        foregroundColor: context.colorScheme.onPrimary,
                        // onPressed: () => KRouter.to(context, Routes.transfer),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Text(
                    'Ajouter une\npersonne favorite.'.toUpperCase(),
                    style: const TextStyle(fontSize: M3FontSizes.displaySmall, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    StringUtils('Selectionnez un contact ou ajouter un numero de telephone.').capitalizeFirst!,
                    style: TextStyle(color: context.colorScheme.onSurface),
                  ),
                  FluTextField(
                    hint: 'Nom ou numero de telephone',
                    suffixIcon: FluIcons.searchStatus,
                    height: UISettings.buttonSize,
                    cornerRadius: UISettings.buttonCornerRadius,
                    margin: const EdgeInsets.only(top: 25),
                    textStyle: const TextStyle(fontSize: M3FontSizes.bodyMedium),
                    fillColor: context.colorScheme.surface,
                  ),
                ],
              ),
            ),
            FluLine(
              height: 1,
              width: double.infinity,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .025),
            ),
            Expanded(
              child: FutureBuilder<List<Contact>>(
                future: getContacts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final contacts = snapshot.data!;

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: UISettings.pagePadding.copyWith(top: MediaQuery.of(context).size.height * .025),
                      itemCount: contacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final contact = contacts[index];

                        return FluButton(
                          onPressed: () => onContactTap(context, contact),
                          backgroundColor: Colors.transparent,
                          margin: EdgeInsets.only(top: index != 0 ? 15 : 0),
                          child: Row(
                            children: [
                              FluOutline(
                                margin: const EdgeInsets.only(right: 10),
                                colors: [context.colorScheme.surface],
                                cornerRadius: 50,
                                child: const FluAvatar(
                                  size: UISettings.minButtonSize,
                                ),
                              ),
                              Text(
                                contact.displayName,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const Column(
                      children: [
                        SizedBox(height: 2, child: LinearProgressIndicator()),
                      ],
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
