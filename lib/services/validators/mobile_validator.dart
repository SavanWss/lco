// ignore_for_file: non_constant_identifier_names

class MobileValidator {
  static mobleValidator({required mobile_number}) {

    List<String> numb = ["0","1","2","3","4","5","6","7","8","9"];

    //  char validation
    for (int i = 0; i < mobile_number.length; i++) {
      var char = mobile_number[i];
      print(numb.contains(char));
      if (!numb.contains(char)) {
        return false;
      }
    }

    return true;
  }
}
