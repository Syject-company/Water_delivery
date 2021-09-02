import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/profile/profile.dart';
import 'package:water/domain/model/support/message_form.dart';
import 'package:water/util/http.dart';

class SupportService {
  static const String _endpoint = 'https://gulfaweb.azurewebsites.net/Support';

  Future<void> sendMessage(MessageForm form) async {
    final response = await Http.post(
      _endpoint,
      body: form,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }
  }
}
