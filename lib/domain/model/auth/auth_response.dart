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

  AuthResponse.fromJson(Map<String, dynamic> json)
      : this(
          id: json[AuthResponseFields.id] as String,
          token: json[AuthResponseFields.token] as String,
        );

  Map<String, dynamic> toJson() => {
        AuthResponseFields.id: id,
        AuthResponseFields.token: token,
      };

  @override
  List<Object?> get props => [id, token];
}
