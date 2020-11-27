import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

String api_adress = "http://192.168.0.222:5000";

String api = "http://172.104.152.134/";

String token = 'nKNWdq7z2LVYXIiBQhDcDekWdS5HnNGIoKQO2MyD%3D';



class Api{
  register(data) async {
    String fullUrl = api + "api/register";
    var response = await post(fullUrl,
    headers:  await _setHeaders(), 
    body: jsonEncode(data));
    return jsonDecode(response.body);
  }
  login(data) async{
    String fullUrl = api + "api/login";
    var response = await post(fullUrl,
    headers:  await _setHeaders(), 
    body: jsonEncode(data));
    return jsonDecode(response.body);
  }
  listFlats(id) async{
    String fullUrl = api + "api/apartments/$id";
    var response = await get(fullUrl,
    headers:  await _setHeaders());
    Map body = jsonDecode(response.body);
    return {'statusCode':response.statusCode, 'body':body};
  }

  _setHeaders() async {
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return headers;
  }
}