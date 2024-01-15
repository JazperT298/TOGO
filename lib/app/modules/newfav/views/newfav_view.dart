// ignore_for_file: unused_field, use_build_context_synchronously, avoid_print

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/newfav/controller/newfav_controller.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_colors.dart';

class NewFavView extends StatefulWidget {
  const NewFavView({super.key});

  @override
  State<NewFavView> createState() => _NewFavViewState();
}

class _NewFavViewState extends State<NewFavView> {
  late TextEditingController nameController = TextEditingController();
  List<Contact>? _contacts;
  bool _permissionDenied = false;
  late List<Contact> displayedContacts;
  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);

      print('_permissionDenied $_permissionDenied');
    } else {
      var contacts = await FlutterContacts.getContacts();
      contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
      setState(() {
        displayedContacts = contacts;
        _contacts = contacts;
      });
      print('_contacts $_contacts');
    }
  }

  void onContactTap(BuildContext context, Contact contact) {
    // KRouter.to(context, Routes.transfer);
  }
  void filterContacts(String query) {
    setState(() {
      displayedContacts = _contacts!.where((contact) => contact.displayName.toLowerCase().contains(query.toLowerCase()) == true).toList();
    });
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
                    inputController: nameController,
                    suffixIcon: FluIcons.searchStatus,
                    height: UISettings.buttonSize,
                    cornerRadius: UISettings.buttonCornerRadius,
                    onChanged: (query) {
                      filterContacts(query);
                    },
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
            Expanded(child: bodyContact()),
            // Expanded(
            //   child: FutureBuilder<List<Contact>>(
            //     future: getContacts(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         final contacts = snapshot.data!;
            //         print('snapshot $snapshot');
            //         return ListView.builder(
            //           physics: const BouncingScrollPhysics(),
            //           padding: UISettings.pagePadding.copyWith(top: MediaQuery.of(context).size.height * .025),
            //           itemCount: contacts.length,
            //           itemBuilder: (BuildContext context, int index) {
            //             final contact = contacts[index];

            //             return FluButton(
            //               onPressed: () => onContactTap(context, contact),
            //               backgroundColor: Colors.transparent,
            //               margin: EdgeInsets.only(top: index != 0 ? 15 : 0),
            //               child: Row(
            //                 children: [
            //                   FluOutline(
            //                     margin: const EdgeInsets.only(right: 10),
            //                     colors: [context.colorScheme.surface],
            //                     cornerRadius: 50,
            //                     child: const FluAvatar(
            //                       size: UISettings.minButtonSize,
            //                     ),
            //                   ),
            //                   Text(
            //                     contact.displayName,
            //                     style: const TextStyle(fontWeight: FontWeight.w600),
            //                   ),
            //                 ],
            //               ),
            //             );
            //           },
            //         );
            //       } else if (snapshot.hasError) {
            //         return const Text('Error');
            //       } else {
            //         return const Column(
            //           children: [
            //             SizedBox(height: 2, child: LinearProgressIndicator()),
            //           ],
            //         );
            //       }
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget bodyContact() {
    if (_permissionDenied) return const Center(child: Text('Permission denied'));
    if (_contacts == null) return const Center(child: CircularProgressIndicator());
    return ListView.builder(
      itemCount: displayedContacts.length,
      physics: const BouncingScrollPhysics(),
      padding: UISettings.pagePadding.copyWith(top: MediaQuery.of(context).size.height * .025),
      itemBuilder: (context, i) => ListTile(
        title: FluButton(
          backgroundColor: Colors.transparent,
          margin: EdgeInsets.only(top: i != 0 ? 15 : 0),
          child: Row(
            children: [
              // FluOutline(
              //   margin: const EdgeInsets.only(right: 10),
              //   colors: [context.colorScheme.surface],
              //   cornerRadius: 50,
              //   child: const FluAvatar(
              //     size: UISettings.minButtonSize,
              //   ),
              // ),
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
                  height: MediaQuery.of(context).size.width * .15,
                  width: MediaQuery.of(context).size.width * .15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.getRandomColor(),
                  ),
                  child: Center(
                    child: Text(
                      displayedContacts[i].displayName.substring(0, 1),
                      style: const TextStyle(
                        color: Colors.white, // You can change the text color
                        fontSize: 24.0, // You can adjust the font size
                      ),
                    ),
                  ),
                ),
              ),
              // FluArc(
              //   startOfArc: 90,
              //   angle: 80,
              //   strokeWidth: 1,
              //   color: context.colorScheme.primaryContainer,
              //   child: Container(

              // child: Container(
              //   height: MediaQuery.of(context).size.height * .15,
              //   width: MediaQuery.of(context).size.width * .15,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: AppColors.getRandomColor(),
              //   ),
              //   child: Center(
              //     child: Text(
              //       _contacts![i].displayName.substring(0, 1),
              //       style: const TextStyle(
              //         color: Colors.white, // You can change the text color
              //         fontSize: 24.0, // You can adjust the font size
              //       ),
              //     ),
              //   ),
              // ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayedContacts[i].displayName,
                      style: TextStyle(fontSize: M3FontSizes.bodyLarge, fontWeight: FontWeight.w600, color: context.colorScheme.onSurface),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        // option.phoneNumber.toString(),

                        _contacts![i].phones.isEmpty ? " " : _contacts![i].phones[0].number.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: M3FontSizes.titleSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // onTap: () async {
        //   final fullContact = await FlutterContacts.getContact(_contacts![i].id);
        //   await Navigator.of(context).push(MaterialPageRoute(builder: (_) => ContactPage(fullContact!)));
        // },
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  final Contact contact;
  const ContactPage(this.contact, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(contact.displayName)),
      body: Column(children: [
        Text('First name: ${contact.name.first}'),
        Text('Last name: ${contact.name.last}'),
        Text('Phone number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'),
        Text('Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
      ]));
}
