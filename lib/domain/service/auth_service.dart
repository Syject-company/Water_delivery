import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:water/domain/model/auth/auth_response.dart';
import 'package:water/domain/model/auth/forgot_password_form.dart';
import 'package:water/domain/model/auth/new_password_form.dart';
import 'package:water/domain/model/auth/sign_in_form.dart';
import 'package:water/domain/model/auth/sign_up_form.dart';
import 'package:water/domain/model/auth/token.dart';
import 'package:water/util/http.dart';

class AuthService {
  static const String _endpoint = 'https://gulfaweb.azurewebsites.net/Account';

  Future<AuthResponse> signInWithFacebook(Token token) async {
    final response = await Http.post(
      '$_endpoint/Login/Facebook',
      body: token,
    );
    return AuthResponse.fromJson(_handleResponse(response));
  }

  Future<AuthResponse> signInWithGoogle(Token token) async {
    final response = await Http.post(
      '$_endpoint/Login/Google',
      body: token,
    );
    return AuthResponse.fromJson(_handleResponse(response));
  }

  Future<AuthResponse> signInWithApple(Token token) async {
    final response = await Http.post(
      '$_endpoint/Login/Apple',
      body: token,
    );
    return AuthResponse.fromJson(_handleResponse(response));
  }

  Future<AuthResponse> signIn(SignInForm form) async {
    final response = await Http.post(
      '$_endpoint/login',
      body: form,
    );
    return AuthResponse.fromJson(_handleResponse(response));
  }

  Future<AuthResponse> signUp(SignUpForm form) async {
    final response = await Http.post(
      '$_endpoint/registration',
      body: form,
    );
    return AuthResponse.fromJson(_handleResponse(response));
  }

  Future<void> resetPassword(ForgotPasswordForm form) async {
    final response = await Http.post(
      '$_endpoint/ForgotPassword/Initial',
      body: form,
    );
    _handleResponse(response);
  }

  Future<AuthResponse> confirmNewPassword(NewPasswordForm form) async {
    final response = await Http.post(
      '$_endpoint/ForgotPassword/Confirm',
      body: form,
    );
    return AuthResponse.fromJson(_handleResponse(response));
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode != HttpStatus.ok)
      throw HttpException(response.body);

    return response.body.isNotEmpty ? jsonDecode(response.body) : {};
  }
}
