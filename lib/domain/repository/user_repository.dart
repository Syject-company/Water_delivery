import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/auth/auth_response.dart';
import 'package:water/domain/model/auth/sign_in_form.dart';
import 'package:water/domain/model/auth/sign_up_form.dart';
import 'package:water/util/http.dart';

class UserRepository {
  static const String _endpoint =
      'https://specialoffers.azurewebsites.net/api/User';

  Future<AuthResponse> signIn(SignInForm payload) async {
    final response = await Http.post('$_endpoint/login', body: payload);

    if (response.statusCode != HttpStatus.ok)
      throw HttpException(response.body);

    return AuthResponse.fromJson(jsonDecode(response.body));
  }

  Future<AuthResponse> signUp(SignUpForm payload) async {
    final response = await Http.post('$_endpoint/register', body: payload);

    if (response.statusCode != HttpStatus.ok)
      throw HttpException(response.body);

    return AuthResponse.fromJson(jsonDecode(response.body));
  }
}
