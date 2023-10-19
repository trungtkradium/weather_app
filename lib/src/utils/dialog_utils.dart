import 'package:flutter/material.dart';
import 'package:get/get.dart';

final loadingDialog = WillPopScope(
  onWillPop: () async => false,
  child: const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    child: Center(
      child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: CircularProgressIndicator(),
      ),
    ),
  ),
);

class DialogUtils {
  static void showErrorDialog(String content) => Get.defaultDialog(
        titleStyle: Get.textTheme.titleMedium?.copyWith(color: Colors.red),
        contentPadding: const EdgeInsets.all(16.0),
        middleText: content,
        middleTextStyle: Get.textTheme.bodyLarge,
        confirm: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Ok'),
          ),
        ),
      );
}
