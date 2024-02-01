// ignore_for_file: unused_element, unused_import

import 'dart:developer';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/login/controller/login_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class LoginProfileView extends StatefulWidget {
  const LoginProfileView({super.key});

  @override
  State<LoginProfileView> createState() => _LoginProfileViewState();
}

class _LoginProfileViewState extends State<LoginProfileView> {
  final controller = Get.put(LoginController());
  String _selectedImage = '';
  bool isGalleryImage = false;
  File? imageFile;

  String? imageName;

  int selectedImageIndex = -1; // Initialize with an index that represents no selection
  String selectedImage = '';
  List<String> imageList = [
    AppImages.profileIcon1,
    AppImages.profileIcon2,
    AppImages.profileIcon3,
    AppImages.profileIcon4,
    AppImages.profileIcon5,
    AppImages.profileIcon6,
    AppImages.profileIcon7,
    AppImages.profileIcon8,
    AppImages.profileIcon9,
    AppImages.profileIcon10,
    AppImages.profileIcon11,
    AppImages.profileIcon12,
    AppImages.profileIcon13,
    AppImages.profileIcon14,
    AppImages.profileIcon15,
    AppImages.profileIcon16,
    AppImages.profileIcon17,
    AppImages.profileIcon18,
    AppImages.profileIcon19,
    AppImages.profileIcon20,
  ];

  ///[_cropImage] call cropping after picking image
  Future<void> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _selectedImage,
      aspectRatioPresets: Platform.isAndroid ? [CropAspectRatioPreset.square] : [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: const Color(0xFF124DE5),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            hideBottomControls: true,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Crop Image',
          resetButtonHidden: true,
          rotateButtonsHidden: true,
          rotateClockwiseButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
          rectX: 10000,
          rectY: 10000,
          rectHeight: 10000,
          rectWidth: 10000,
          minimumAspectRatio: 10000,
        )
      ],
    );

    if (croppedFile != null) {
      if (mounted) {
        setState(() {
          isGalleryImage = true;
          _selectedImage = croppedFile.path;
          imageName = croppedFile.path.split('/').last;
          imageFile = File(croppedFile.path);
          log('imageFile $imageFile');
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isGalleryImage = false;
        });
      }
    }
    // Get.back();
  }

  @override
  Widget build(BuildContext context) {
    void chooseImagePickerModalBottomSheet() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext bottomSheetContext) {
          return SafeArea(
            child: Wrap(
              children: [
                Container(
                  color: const Color(0XFFBE002D),
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Please Select Option",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.image, color: Color(0XFF777777)),
                  title: Text(
                    "Pick From Gallery",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 18),
                  ),
                  onTap: () async {
                    try {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);
                      if (result!.isSinglePick) {
                        Get.back();
                        setState(() {
                          _selectedImage = result.files[0].path.toString();
                        });
                        cropImage();
                      }
                    } catch (ex) {
                      if (Platform.isIOS) {
                        if (await Permission.storage.isPermanentlyDenied) {
                          AppSettings.openAppSettings();
                        }
                      } else {
                        if (!await Permission.storage.shouldShowRequestRationale && await Permission.storage.status.isDenied) {
                          AppSettings.openAppSettings();
                        }
                      }
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt,
                    color: Color(0XFF777777),
                  ),
                  title: Text(
                    "Capture Photo",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0XFF777777), fontSize: 18),
                  ),
                  onTap: () async {
                    try {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? result = await imagePicker.pickImage(
                        source: ImageSource.camera,
                      );
                      if (result != null) {
                        Get.back();
                        setState(() {
                          _selectedImage = result.path;
                        });
                        cropImage();
                      }
                    } catch (ex) {
                      if (Platform.isIOS) {
                        if (await Permission.camera.status.isPermanentlyDenied) {
                          AppSettings.openAppSettings();
                        }
                      } else {
                        if (!await Permission.camera.shouldShowRequestRationale && await Permission.camera.status.isDenied) {
                          AppSettings.openAppSettings();
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Obx(
            () => Stack(
              children: [
                if (controller.isLoadingProfile.value == true)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: loadingContainer(),
                  ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: Padding(
                      padding: UISettings.pagePadding.copyWith(top: 10, left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 35),
                          Text(
                            'My Profile'.toUpperCase(),
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF687997), fontSize: 14),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Finalizing the configuration',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 26),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Choose an avatar or select a photo from your gallery',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                          ),
                          Row(
                            children: [
                              FluLine(
                                width: 25.w,
                                color: context.colorScheme.secondary,
                                height: 1,
                                margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
                              ),
                              CircleAvatar(
                                radius: 1.w,
                                backgroundColor: context.colorScheme.secondary,
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          // FluTextField(
                          //   hint: 'Choose from gallery', // "Numéro du destinataire",
                          //   inputController: galleryEditingCobntroller,
                          //   hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: const Color(0xFFF4F5FA), fontSize: 14),
                          //   textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: const Color(0xFFF4F5FA), fontSize: 14),
                          //   height: 50,
                          //   cornerRadius: 15,
                          //   suffixIcon: FluIcons.galleryAdd,
                          //   iconColor: Colors.white,
                          //   iconSize: 24,
                          //   fillColor: const Color(0xFF27303F),
                          //   keyboardType: TextInputType.none,
                          //   cursorColor: Colors.transparent,
                          //   onTap: () async {
                          //     try {
                          //       FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);
                          //       if (result!.isSinglePick) {
                          //         Get.back();
                          //         setState(() {
                          //           _selectedImage = result.files[0].path;
                          //         });
                          //         cropImage();
                          //       }
                          //     } catch (ex) {
                          //       if (Platform.isIOS) {
                          //         if (await Permission.storage.isPermanentlyDenied) {
                          //           AppSettings.openAppSettings();
                          //         }
                          //       } else {
                          //         if (!await Permission.storage.shouldShowRequestRationale && await Permission.storage.status.isDenied) {
                          //           AppSettings.openAppSettings();
                          //         }
                          //       }
                          //     }

                          //     // chooseImagePickerModalBottomSheet();
                          //   },
                          // ),
                          InkWell(
                            onTap: () async {
                              selectedImageIndex = -1;
                              try {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);
                                if (result!.isSinglePick) {
                                  setState(() {
                                    _selectedImage = result.files[0].path.toString();
                                  });
                                  cropImage();
                                }
                              } catch (ex) {
                                if (Platform.isIOS) {
                                  if (await Permission.storage.isPermanentlyDenied) {
                                    AppSettings.openAppSettings();
                                  }
                                } else {
                                  if (!await Permission.storage.shouldShowRequestRationale && await Permission.storage.status.isDenied) {
                                    AppSettings.openAppSettings();
                                  }
                                }
                              }

                              // chooseImagePickerModalBottomSheet();
                            },
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFF27303F),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    isGalleryImage == false ? 'Choose from gallery' : imageName!,
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: const Color(0xFFF4F5FA), fontSize: 14),
                                  ),
                                  const FluIcon(
                                    FluIcons.galleryAdd,
                                    color: Colors.white,
                                    size: 24,
                                  )
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          // Display image selection grid
                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, // You can adjust the number of columns
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: imageList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedImageIndex == index) {
                                      selectedImageIndex = -1;
                                    } else {
                                      selectedImageIndex = index;
                                      selectedImage = imageList[index];
                                      isGalleryImage = false;
                                      _selectedImage = '';
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: selectedImageIndex == index
                                          ? Colors.blue // Indicator color when selected
                                          : Colors.transparent,
                                      width: 4.0,
                                    ),
                                  ),
                                  child: Image.asset(
                                    imageList[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .09,
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: UISettings.pagePadding.copyWith(top: 8, left: 24, right: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FluButton.text(
                              'Later',
                              iconStrokeWidth: 1.8,
                              onPressed: () {
                                Get.find<StorageServices>().saveOTP(otp: AppImages.userIcon);
                                controller.profileContinueButtonClick();
                              },
                              height: 5.8.h,
                              width: MediaQuery.of(context).size.width * .40,
                              cornerRadius: UISettings.minButtonCornerRadius,
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                              border: BorderSide(color: context.colorScheme.primary),
                              textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp, color: context.colorScheme.primary),
                            ),
                            FluButton.text(
                              'Confirm',
                              iconStrokeWidth: 1.8,

                              onPressed: selectedImage.isEmpty && _selectedImage.isEmpty
                                  ? null
                                  : () {
                                      if (selectedImage.isEmpty && _selectedImage.isNotEmpty) {
                                        controller.selectedImageFile.value = _selectedImage;
                                        log('_selectedImage $_selectedImage');
                                        Get.find<StorageServices>().saveProfileImageFromGallery(imageFile: _selectedImage);
                                        controller.profileContinueButtonClick();
                                      } else {
                                        log('selectedImage $selectedImage');
                                        controller.selectedAvatar.value = selectedImage;
                                        Get.find<StorageServices>().saveProfileImageFromAvatar(image: selectedImage);
                                        controller.profileContinueButtonClick();
                                      }
                                    },
                              // onPressed: () {
                              //   log('selectedImage $selectedImage');
                              //   log('_selectedImage $_selectedImage');
                              // },
                              height: 5.8.h,
                              width: MediaQuery.of(context).size.width * .40,
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
                              textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
