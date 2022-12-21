import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class NoticeDialogue {
  static showNoticeDialogue(context) {
    SmartDialog.show(builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:
            Text('easy custom dialog', style: TextStyle(color: Colors.white)),
      );
    });
  }

  static dismissNoticeDialogue(context) {
    Navigator.of(context).pop();
  }

}
