import 'dart:convert';

import 'package:assignment_04/app.dart';
import 'package:assignment_04/ui/controllers/auth_controller.dart';
import 'package:assignment_04/ui/screens/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkResponse {

  final bool isSuccess;
  final String? errorMessage;
  final int statusCode;
  final Map<String, dynamic>? body;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.errorMessage,
    this.body
  });
}

class NetworkCaller {

  static const String _defaultErrorMessage = 'Something went wrong';
  static const String _unAuthorizeMessage = 'Un-authorized token';

  static Future<NetworkResponse> getRequest({required String url}) async {
    try{
      Uri uri = Uri.parse(url);

      final Map<String, String> headers = {
        'token': AuthController.accessToken ?? ''
      };

      Response response = await get(uri, headers: headers);

      if(response.statusCode == 200){
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(isSuccess: true, statusCode: response.statusCode, body: decodedJson);

      } else if(response.statusCode == 401){
        _onUnAuthorize();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: _unAuthorizeMessage
        );

      } else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodedJson['data'] ?? _defaultErrorMessage
        );
      }
    } catch(e) {
      return NetworkResponse(
          isSuccess: false,
          statusCode: -1,
          errorMessage: _defaultErrorMessage
      );
    }
  }

  static Future<NetworkResponse> postRequest({required String url, Map<String, String>? body, bool isFromLogin = false}) async {
    try{
      Uri uri = Uri.parse(url);

      final Map<String, String> headers = {
        'content-type': 'application/json',
        'token': AuthController.accessToken ?? ''
      };

      Response response = await post(
          uri,
          headers: headers,
          body: jsonEncode(body)
      );

      if(response.statusCode == 200){
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(isSuccess: true, statusCode: response.statusCode, body: decodedJson);

      } else if(response.statusCode == 401){
        if(isFromLogin == false){
          _onUnAuthorize();
        }
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: _unAuthorizeMessage
        );

      } else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodedJson['data'] ?? _defaultErrorMessage
        );
      }
    } catch(e) {
      return NetworkResponse(
          isSuccess: false,
          statusCode: -1,
          errorMessage: _defaultErrorMessage
      );
    }
  }

  static Future<void> _onUnAuthorize() async{
    await AuthController.clearData();
    Navigator.pushNamedAndRemoveUntil(TaskManagerApp.navigator.currentContext!, SignInScreen.name, (predicate)=> false);
  }

}