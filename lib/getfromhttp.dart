import 'package:http/http.dart' as http;
import 'dart:convert';
const apikey="C9405033-694C-4124-A627-B9CE51C44E92";


class GetFromhttp {

  String selected_currency;

  GetFromhttp({this.selected_currency});

  Future<dynamic> Datafromweb(String type) async {
    try {
      http.Response response = await http.get(
          "https://rest.coinapi.io/v1/exchangerate/$type/$selected_currency?apikey=$apikey");
      if (response.statusCode == 200) {
        var DecodeData = await jsonDecode(response.body);
        return DecodeData['rate'].toInt();;
      }
    }
    catch (e) {
      return null;
    }
  }
}
