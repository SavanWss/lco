import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/dialogues/DialogueRejectingReq.dart';
import 'package:little_miracles_orphange/utils/requesteduserdetail/RequestedUserDetail.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(
    BuildContext context, {
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
              child: SizedBox(
                height: 500,
                child: Column(
              children: [
                Text(
                RequestedUserDetail.userDetails["email"]),
                SizedBox(height: 10,),
                Text(
                  (RequestedUserDetail.userDetails["profession"] == null)? "profession not confirmed": "${RequestedUserDetail.userDetails["profession"]}"
                ),
                 SizedBox(height: 10,),
                Text(
                 (RequestedUserDetail.userDetails["married_status"] == null)? "maritial status not confirmed": "${RequestedUserDetail.userDetails["married_status"]}")
              ],
            ),
              )
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
                      onPressed: () =>DialogueRejectingReq.showCustomDialog(context))

            ],
          );
        });
  }
}
