// ignore_for_file: prefer_const_constructors

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) return await file.readAsBytes();
  debugPrint('No image selected');
}

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.indigo,
      content: Text(
        content,
        style: TextStyle(
          color: AppColor.primary,
        ),
      ),
    ),
  );
}
