import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/firebase/FbReqHandler.dart';
import 'package:little_miracles_orphange/utils/adoptionrequest/AdoptionRequest.dart';
import 'package:little_miracles_orphange/utils/requesteduserdetail/RequestedUserDetail.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class DialogueRejectingReq {
  static DialogueRejectingReq _instance = new DialogueRejectingReq.internal();

  DialogueRejectingReq.internal();

  factory DialogueRejectingReq() => _instance;

  static void showCustomDialog(
    BuildContext context, {
    @required String title = "",
    String acceptBtnText = "Reject",
  }) {
    showDialog(
        context: context,
        builder: (_) {
          var rejectionRejectController = TextEditingController();
          final _FormKey = GlobalKey<FormState>();

          return AlertDialog(
            title: Text("cancel request"),
            content: /* Here add your custom widget  */ Padding(
                padding: EdgeInsets.fromLTRB(10, 40, 0, 10),
                child: SizedBox(
                  height: 500,
                  child: Column(
                    children: [
                      Form(
                        key: _FormKey,
                        child: TextFormField(
                          controller: rejectionRejectController,
                          
                          decoration: InputDecoration(
                            hintText: "rejection reason",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            actions: <Widget>[
              ElevatedButton(
                child: Text(acceptBtnText),
                onPressed: () async {
                  if (_FormKey.currentState!.validate()) {
                    print("in the dilogue form reject reason ${rejectionRejectController.text}");
                    CircularIndicator.startCircularIndicator(context);
                    var rejectionFireBaseResponse =
                        await FbReqHandler.fbRejectRequest(
                            requestedUser:
                                AdoptionRequest.adoptionRequest["user_email"],
                            rejectionReason: rejectionRejectController.text);
                    if (rejectionFireBaseResponse["status"] == false) {
                      CircularIndicator.stopCircularIndicator(context);
                      Toast.toastView(msg: "oopes something went wrong");
                    } else {
                      CircularIndicator.stopCircularIndicator(context);
                      Toast.toastView(msg: "request is rejected successfully");
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                  }
                },
              ),
            ],
          );
        });
  }
}
