import 'package:flutter/material.dart';
import '../widgets/custom_modal.dart';

void showCustomModal({
  required BuildContext context,
  required String title,
  required Widget content,
  double? height,
  double? width,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder: (context) {
      return CustomModal(
        title: title,
        content: content,
        height: height,
        width: width,
      );
    },
  );
}
