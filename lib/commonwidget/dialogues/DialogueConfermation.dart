import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/utils/adoptionrequest/AdoptionRequest.dart';

class DialogueConfermation {
  static DialogueConfermation _instance = new DialogueConfermation.internal();

  DialogueConfermation.internal();

  factory DialogueConfermation() => _instance;

  static Future<void> showCustomDialog(
    BuildContext context, {
    String acceptBtnText = "Accept",
    String rejectBtnText = "Reject",
    required Function unNamed
  }) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Adoption request"),
            content: /* Here add your custom widget  */ Text(
                AdoptionRequest.adoptionRequest["user_email"]),
            actions: <Widget>[
 
                  ElevatedButton(
                    child: Text(acceptBtnText),
                    onPressed: (() => unNamed())
                  ),

            ],
          );
        });
  }
}
