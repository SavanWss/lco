import 'package:http/http.dart' as http;

class getAllData {
  static getData() async {
    print("object");
    var url = Uri.https("fakestoreapi.com","products");
    var data = await http.get(url);
    var fag = await http.post(url);
    
    print(data.body);
  }
}
