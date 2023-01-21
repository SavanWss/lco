import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:little_miracles_orphange/utils/adoptionrequest/AdoptionRequest.dart';
import 'package:little_miracles_orphange/utils/requesteduserdetail/RequestedUserDetail.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(
    BuildContext context, {
    @required String title = "",
    String acceptBtnText = "Accept",
    String rejectBtnText = "Reject",
  }) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Adoption request"),
            content: /* Here add your custom widget  */ Padding(
              padding: EdgeInsets.fromLTRB(10, 40, 0, 10),
              child: Column(
              children: [
                Text(
                RequestedUserDetail.userDetails["email"]),
                SizedBox(height: 10,),
                Text(
                RequestedUserDetail.userDetails["profession"]),
                 SizedBox(height: 10,),
                Text(
                AdoptionRequest.adoptionRequest["married_status"]),
              ],
            ),
            ),
            actions: <Widget>[
 
                  ElevatedButton(
                    child: Text(acceptBtnText),
                    onPressed: () {
                      Navigator.pushNamed(context, ScreenRoutes.adminAdAceeptReqScreen);
                    },
                  ),
                  ElevatedButton(
                      child: Text(rejectBtnText),
                      onPressed: () => Navigator.pop(context))

            ],
          );
        });
  }
}
