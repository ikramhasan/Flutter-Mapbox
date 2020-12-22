import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  final String baseURL;

  const ApiProvider({this.baseURL = ''});

  Future<dynamic> makeGetRequest(
    String endpoint, {
    Map<String, dynamic> queryParams,
    Map<String, dynamic> headers,
  }) async {
    final http.Response response = await http.get(
      Uri.https(baseURL, endpoint, queryParams),
      headers: headers,
    );

    if (response.statusCode != 200) {
      return null;
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
