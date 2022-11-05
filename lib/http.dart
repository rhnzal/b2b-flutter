import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum HTTPResponseStatus { success, failed, timeout, error, noInternet }

class HTTPResponse<T> {
  HTTPResponse({
    required this.status,
    this.data,
    this.statusCode,
    this.additionalData,
    this.message,
  });

  final HTTPResponseStatus status;
  final T? data;
  final int? statusCode;
  final dynamic additionalData;
  final String? message;

  get isSuccess => status == HTTPResponseStatus.success;
}

late SharedPreferences prefs;

Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
  }

Future<HTTPResponse> post({@required url, @required body, Duration timeout = const Duration(seconds: 20)}) async{
  await initpreference();
  try{
    var token = prefs.getString('token');
    var response = await http.post(Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader : 'application/json',
        HttpHeaders.authorizationHeader : 'Bearer $token'
        },
      body: json.encode(body)
    ).timeout(timeout);
    var data = json.decode(response.body);
    if(response.statusCode == 200){
      return HTTPResponse(
        status: HTTPResponseStatus.success,
        data: data['data'],
        additionalData: data['isSuccess'],
        message: data['message']
        );
    }else {
      return HTTPResponse(
        status: HTTPResponseStatus.failed,
        message: json.decode(response.body)['message'] ?? 'Something Went Wrong'
      );
    }
    } on TimeoutException {
      return HTTPResponse(
        status: HTTPResponseStatus.timeout,
        message: 'Timeout'
        );
    } on Exception {
      return HTTPResponse(
        status: HTTPResponseStatus.error,
        message: 'Something Went Wrong'
        );
    }
}

Future<HTTPResponse> get({@required url, Duration timeout = const Duration(seconds: 20)}) async{
  await initpreference(); 
  try{
    var token = prefs.getString('token');
    var response = await http.get(Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader : 'application/json',
        HttpHeaders.authorizationHeader : 'Bearer $token'
      },
    ).timeout(timeout);
    // print(json.decode(response.body));
    var data = json.decode(response.body)["data"];
    if (response.statusCode == 200 ){
      return HTTPResponse (
        status: HTTPResponseStatus.success,
        data : data
      );
    }else {
      return HTTPResponse(
        status: HTTPResponseStatus.error,
        message: json.decode(response.body)['message'] ?? 'Something Went Wrong' 
        );
        
    }
    } on TimeoutException {
      return HTTPResponse(
        status: HTTPResponseStatus.timeout,
        message: 'Timeout'
        );
    } on Exception {
      return HTTPResponse(
        status: HTTPResponseStatus.error,
        message: 'Something Went Wrong'
        );
    }
}

Future<HTTPResponse> put({@required url, @required body, Duration timeout = const Duration(seconds: 20)}) async{
  await initpreference();
  try{
    var token =  prefs.getString('token');
    var response = await http.put(Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader : 'application/json',
        HttpHeaders.authorizationHeader : 'Bearer $token'
      },
      body: json.encode(body)
    ).timeout(timeout);
    var res = json.decode(response.body)['data'];
    if(response.statusCode == 200){
      return HTTPResponse(
        status: HTTPResponseStatus.success,
        data: res
        );
    }else{
      return HTTPResponse(
        status: HTTPResponseStatus.error,
        additionalData: 'Something Went Wrong'
        );
    }
  }catch (e){
    return HTTPResponse(
      status: HTTPResponseStatus.timeout,
      message: 'Timeout'
      );
  }
}

Future<HTTPResponse> delete({@required url, Duration timeout = const Duration(seconds: 20)}) async{
  await initpreference();
  try{
    var token = prefs.getString('token');
    var response = await http.delete(Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }
    ).timeout(timeout);
    if(response.statusCode == 200){
      return HTTPResponse(
        status: HTTPResponseStatus.success,
        message: 'Success'
      );
    }else{
      return HTTPResponse(
        status: HTTPResponseStatus.failed,
        message: 'Something Went Wrong'
      );
    }
  }on TimeoutException {
    return HTTPResponse(
      status: HTTPResponseStatus.timeout,
      message: 'Timeout'
    );
  }on Exception {
    return HTTPResponse(
      status: HTTPResponseStatus.error,
      message: 'Something Went Wrong'
    );
  }
}