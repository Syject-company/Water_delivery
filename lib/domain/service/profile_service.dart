import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/profile/profile.dart';
import 'package:water/domain/model/profile/profile_form.dart';
import 'package:water/util/http.dart';

class ProfileService {
  static const String _endpoint = 'https://gulfaweb.azurewebsites.net/Profile';

  Future<Profile> getByToken(String token) async {
    final response = await Http.get(
      '$_endpoint',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    return Profile.fromJson(jsonDecode(response.body));
  }

  Future<void> save(String token, ProfileForm form) async {
    final response = await Http.put(
      '$_endpoint',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: form,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }
  }
}
