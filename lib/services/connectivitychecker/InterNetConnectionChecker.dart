import 'package:internet_connection_checker/internet_connection_checker.dart';

class InterNetConnectivityChecker {
  static interNetConnectivityChecker() async {
    bool interNetConnectionFlag = await InternetConnectionChecker().hasConnection;
    return interNetConnectionFlag;
  }
}