import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:water/domain/model/auth/auth_response.dart';
import 'package:water/domain/model/auth/sign_in_form.dart';
import 'package:water/domain/model/auth/sign_up_form.dart';
import 'package:water/util/http.dart';

class AuthService {
  static const String _endpoint =
      'https://gulfaweb.azurewebsites.net/Account';

  Future<AuthResponse> signInWithFacebook(String token) async {
    final response = await Http.post('$_endpoint/Login/Facebook', body: {
      "accessToken": token,
    });
    return _handleResponse(response);
  }

  Future<AuthResponse> signInWithGoogle(String token) async {
    final response = await Http.post('$_endpoint/Login/Google', body: {
      "accessToken": token,
    });
    return _handleResponse(response);
  }

  Future<AuthResponse> signInWithApple(String token) async {
    final response = await Http.post('$_endpoint/Login/Apple', body: {
      "id_token": token,
    });
    return _handleResponse(response);
  }

  Future<AuthResponse> signIn(SignInForm payload) async {
    final response = await Http.post('$_endpoint/login', body: payload);
    return _handleResponse(response);
  }

  Future<AuthResponse> signUp(SignUpForm payload) async {
    final response = await Http.post('$_endpoint/registration', body: payload);
    return _handleResponse(response);
  }

  Future<AuthResponse> _handleResponse(Response response) async {
    if (response.statusCode != HttpStatus.ok)
      throw HttpException(response.body);

    return AuthResponse.fromJson(jsonDecode(response.body));
  }
}
