### Flutter Moov Money Flooz Project

A project created in flutter using GetX. 

### Project Version and Installation

- To run this project download Flutter SDK Version `3.13.5` and set Flutter SDK Path from settings.

- use `flutter pub get` command into this directory:
    - root directory of project=

- use `flutter pub run` command to run on running device.

### Localization :

* For translations will use here [get_cli](https://pub.dev/packages/get_cli)
* Create your language json files inside `assets/locales` folder as below:
```
    |- assets/
        |-locales/
            |- en.json
            |- es.json
            |- fr.json
```

    - Here file name should be in the language code as defined above for English , Spanis and French.

* Define your whole app strings into this json files as per the language.

*  To install `get_cli` execute below commands one by one:

1. ```dart pub global activate get_cli```
2. ```flutter pub global activate get_cli```

* Now will generate string keys using below command, that will generate `locales.g.dart` file inside out `lib` folder.

  ```get generate locales assets/locales```

* After this define `translationsKeys` in our main app which is located inside `main.dart`.
    ```
        GetMaterialApp(
            translationsKeys: AppTranslation.translations,
        )
  ```

* Now in whole app use translations string like this -> `LocaleKeys.welcomeBack.tr`:
    ```
        CustomText(
              text: LocaleKeys.welcomeBack.tr,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              size: 14,
            ),
    ```

* So, here as written in above code `AppTranslation` & `LocaleKeys` this both are generated class and located inside `lib/generated/locales.g.dart`.
* Do not change anything inside this generated files, if you want to add new strings then you can add into your json files which are located inside `assets/locales/` and then generate new `LocaleKeys` for that.
