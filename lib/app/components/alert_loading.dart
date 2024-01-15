// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingWidget extends StatelessWidget {
  String progressMessage;
  LoadingWidget({Key? key, required this.progressMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // Set the background color to transparent
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set the color of the dialog content
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16.0),
            Text(
              progressMessage,
              style: TextStyle(fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }
}
