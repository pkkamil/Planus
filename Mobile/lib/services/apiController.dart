import 'dart:convert';
import 'package:http/http.dart';



String api = "http://172.104.152.134/";
String secondApi = "http://planus.me:5000";

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
  createFlat(data) async{
    String fullUrl = api + "api/apartment/create";
    var response = await post(fullUrl,
    body: jsonEncode(data),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  getCounters(id_apartment) async{
    String fullUrl = api + "api/apartment/last-counter/$id_apartment";
    var response = await get(fullUrl,
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  insertCounters(data) async{
    String fullUrl = api + "api/apartment/enter-counters";
    var response = await post(fullUrl,
    body: jsonEncode(data),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  initialCounters(data) async{
    String fullUrl = api + "api/apartment/enter-initial-counters";
    var response = await post(fullUrl,
    body: jsonEncode(data),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  joinFlat(data) async{
    String fullUrl = api + "api/apartment/rent";
    var response = await post(fullUrl,
    body: jsonEncode(data),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  changeName(data) async{
    String fullUrl = api + "api/change-name";
    var response = await post(fullUrl,
    body: jsonEncode(data),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  changePassword(data) async{
    String fullUrl = api + "api/change-password";
    var response = await post(fullUrl,
    body: jsonEncode(data),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  changeEmail(data) async{
    String fullUrl = api + "api/change-email";
    var response = await post(fullUrl,
    body: jsonEncode(data),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  deleteFlat(data) async{
    String fullUrl = api + "api/apartment/delete";
    var response = await post(fullUrl,
    body: jsonEncode(data),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  deleteAccount(id) async{
    String fullUrl = api + "api/account/delete";
    var response = await post(fullUrl,
    body: jsonEncode({'user_id':id}),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  editFlat(data) async{
    String fullUrl = api + "api/apartment/edit";
    var response = await post(fullUrl,
    body: jsonEncode(data),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  getBill(id) async{
    String fullUrl = api + "api/apartment/bill/$id";
    var response = await get(fullUrl,
    headers:  await _setHeaders());
    return {'statusCode':response.statusCode, 'body':jsonDecode(response.body)};
  }
  getStats(id) async{
    String fullUrl = api + "api/apartment/statistics/$id";
    var response = await get(fullUrl,
    headers:  await _setHeaders());
    return {'statusCode':response.statusCode, 'body':jsonDecode(response.body)};
  }
  getResidents(id) async{
    String fullUrl = api + "api/apartment/roommates/$id";
    var response = await get(fullUrl,
    headers:  await _setHeaders());
    return {'statusCode':response.statusCode, 'body':jsonDecode(response.body)};
  }
  addToBill(data) async{
    String fullUrl = api + "api/bill/add";
    var response = await post(fullUrl,
    body: jsonEncode(data),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  addMember(data) async{
    String fullUrl = api + "api/apartment/member/create";
    var response = await post(fullUrl,
    body: jsonEncode(data),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }
  kickMember(data) async{
    String fullUrl = api + "api/apartment/member/delete";
    var response = await post(fullUrl,
    body: jsonEncode(data),
    headers:  await _setHeaders());
    return jsonDecode(response.body);
  }

  _setHeaders() async {
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return headers;
  }
}