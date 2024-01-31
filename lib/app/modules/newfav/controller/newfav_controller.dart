// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/models/user.dart';

class NewFavController extends GetxController {
  RxList<User> favorites = <User>[].obs;
  RxList<String> userFullnames = <String>[].obs;
  RxList<String> userNumbers = <String>[].obs;

  RxList<Contact> contacts = <Contact>[].obs;
  RxList<Contact> displayedContacts = <Contact>[].obs;

  RxBool permissionDenied = false.obs;

  RxString formatPhone = ''.obs;
  RxString countryCode = ''.obs;

  User? selectedUser;
  // Contact? selectedContacts;
  final selectedContacts = Contact().obs;
  RxInt selectedByUser = 0.obs;

  var nameController = TextEditingController().obs;
  @override
  void onInit() {
    fetchContacts();
    super.onInit();
  }

  Future fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      permissionDenied.value = true;

      log('_permissionDenied ${permissionDenied.value}');
    } else {
      var myContacts = await FlutterContacts.getContacts();
      myContacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
      contacts.value = myContacts;
      displayedContacts.value = myContacts;
      log('_contacts ${contacts.value}');
    }
  }

  void filterContacts(String query) {
    displayedContacts.value = contacts.value.where((contact) => contact.displayName.toLowerCase().contains(query.toLowerCase()) == true).toList();
  }
}
