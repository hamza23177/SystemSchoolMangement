// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tr_app/main.dart';

class Req {
  static String baseUrl = "http://192.168.195.127:8000/api/";
  var token = prefs!.getString('token');

  postlogindata(data, url) async {
    var fullUrl = baseUrl + url;
    var response = await http.post(Uri.parse(fullUrl), body: data, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    var respobody = jsonDecode(response.body);

    return response;
  }

  postdata(data, url) async {
    var fullUrl = baseUrl + url;
    var response = await http.post(Uri.parse(fullUrl),
        body: data, headers: setHeaders(token));
    var respobody = jsonDecode(response.body);

    return response;
  }

  getdata(url) async {
    var fullUrl = baseUrl + url;
    var response =
        await http.get(Uri.parse(fullUrl), headers: setHeaders(token));

    return response;
  }

  uploadfile(String url, file, id, name) async {
    var fullurl = baseUrl + url;
    var request = http.MultipartRequest('POST', Uri.parse(fullurl));
    request.headers.addAll(setHeaders(token));
    request.files.add(await http.MultipartFile.fromPath('file', file));
    request.fields['file_name'] = name;
    request.fields['class_room_id'] = id;
    var response = await request.send();
    var resp = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      return true;
    } else {
      print(resp.body.toString());
      return false;
    }
  }

  uploadimageprofile(String url, file) async {
    var fullurl = baseUrl + url;
    var request = http.MultipartRequest('POST', Uri.parse(fullurl));
    request.headers.addAll(setHeaders(token));
    request.files.add(await http.MultipartFile.fromPath('image', file));
    var response = await request.send();
    var resp = await http.Response.fromStream(response);
    print(resp.body.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      print(resp.body.toString());
      return false;
    }
  }

  uploadtimetable(String url, file, id) async {
    var fullurl = baseUrl + url;
    var request = http.MultipartRequest('POST', Uri.parse(fullurl));
    request.headers.addAll(setHeaders(token));
    request.files.add(await http.MultipartFile.fromPath('image', file));
    request.fields['class_room_id'] = id;
    var response = await request.send();
    var resp = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      return true;
    } else {
      print(resp.body.toString());
      return false;
    }
  }

  setHeaders(token) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
