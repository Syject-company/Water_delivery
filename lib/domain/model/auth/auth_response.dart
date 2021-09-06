import 'package:equatable/equatable.dart';

class AuthResponseFields {
  static const String id = 'id';
  static const String token = 'token';
}

class AuthResponse extends Equatable {
  AuthResponse({
    required this.id,
    required this.token,
  });

  final String id;
  final String token;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      id: json[AuthResponseFields.id],
      token: json[AuthResponseFields.token],
    );
  }

  @override
  List<Object?> get props => [id, token];
}
