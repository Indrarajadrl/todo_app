import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DialogbarCustom {
  static dialogSuccess(String title, content) {
    Get.dialog(
      AlertDialog(
        contentPadding:
            EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 15),
        title: Text(title),
        titlePadding: EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 15),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Get.back(closeOverlays: true);
              FocusManager.instance.primaryFocus!.unfocus();
            },
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  static snackBar(context, title) {
    final snackBar = SnackBar(
      content: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      duration: Duration(milliseconds: 500),
      backgroundColor: (Colors.grey[300]),
      action: SnackBarAction(
        label: 'dismiss',
        textColor: Colors.blue,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
