import 'package:http/http.dart' as http;
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';

class SendEmail {
  static sendEmail({required sub, required body}) async {
    try {
      var url = Uri.http("65.2.4.65:3000",
          "sendEmail/dharmidungrani9@gmail.com/${sub}/${body}");
      var response = await http.post(url);
      print('Response status: ${response}');
      print("mail sended");
    } catch (e) {
      print("mail not sended");
    }
  }

  static sendOtpEmail({required user_email, required sub, required body}) async {
    try {
      var url = Uri.http("65.2.4.65:3000",
          "sendEmail/${user_email}/${sub}/${body}");
      var response = await http.post(url);
      print('Response status: ${response}');
      print("mail sended");
    } catch (e) {
      print("mail not sended");
    }
  }
}
