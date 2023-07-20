import 'dart:io' show Platform;

import 'package:firebase_authentication_app/models/custom_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog(BuildContext context, CustomError error) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(error.code),
          content: Text('${error.plugin}\n${error.message}'),
          actions: [
            CupertinoDialogAction(
              child: const Text('ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(error.code),
          content: Text('${error.plugin}\n${error.message}'),
          actions: [
            ElevatedButton(
              child: const Text('ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }
}
