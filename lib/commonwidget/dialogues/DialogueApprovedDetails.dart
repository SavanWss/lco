import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:little_miracles_orphange/utils/adoptionrequest/AdoptionRequest.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class DialogueApprovedDetails {
  static DialogueApprovedDetails _instance = new DialogueApprovedDetails.internal();

  DialogueApprovedDetails.internal();

  factory DialogueApprovedDetails() => _instance;

  static void showCustomDialog(
    BuildContext context, {
    @required String title = "",
    String acceptBtnText = "Ok",
  }) {
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
                    onPressed: () => Navigator.pop(context),
                  ),
            ],
          );
        });
  }
}
