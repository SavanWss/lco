import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
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
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      Center(
                        child: Text(
                          "Email",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Text(RequestedUserDetail.userDetails["email"]),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      Center(
                        child: Text(
                          "Profession",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Text((RequestedUserDetail.userDetails["profession"] ==
                              null)
                          ? "profession not confirmed"
                          : "${RequestedUserDetail.userDetails["profession"]}"),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      Center(
                        child: Text(
                          "Marritial Status",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Text((RequestedUserDetail.userDetails["married_status"] ==
                              null)
                          ? "maritial status not confirmed"
                          : "${RequestedUserDetail.userDetails["married_status"]}"),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      Center(
                        child: Text(
                          "Name of User",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Text((RequestedUserDetail.userDetails["name"] == null)
                          ? "name status not confirmed"
                          : "${RequestedUserDetail.userDetails["name"]}"),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      Center(
                        child: Text(
                          "Gender",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Text((RequestedUserDetail.userDetails["gender"] == null)
                          ? "gender status not confirmed"
                          : "${RequestedUserDetail.userDetails["gender"]}"),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      Center(
                        child: Text(
                          "Address",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Text((RequestedUserDetail.userDetails["address"] == null)
                          ? "address status not confirmed"
                          : "${RequestedUserDetail.userDetails["address"]}"),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      Center(
                        child: Text(
                          "Mobile",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Text((RequestedUserDetail.userDetails["mobile"] == null)
                          ? "mobile status not confirmed"
                          : "${RequestedUserDetail.userDetails["mobile"]}")
                    ],
                  ),
                )),
            actions: <Widget>[
              ElevatedButton(
                child: Text(acceptBtnText),
                onPressed: () {
                  Navigator.pushNamed(
                      context, ScreenRoutes.adminAdAceeptReqScreen);
                },
              ),
              ElevatedButton(
                  child: Text(rejectBtnText),
                  onPressed: () =>
                      DialogueRejectingReq.showCustomDialog(context))
            ],
          );
        });
  }
}
