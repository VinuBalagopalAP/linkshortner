import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHandling {
  String baseurl = 'https://pokeapi.co';
  Future get(String url) async {
    url = formatter(url);
    print(url);
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    print(response);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formatter(url);
    print(url);
    print(body);
    var uri = Uri.parse(url);
    var response = await http.post(
      uri,
      body: json.encode(body),
      headers: {"Content-type": "application/json"},
    );
    print(
      json.encode(body),
    );
    return response;
  }

  String formatter(String url) => baseurl + url;
}
