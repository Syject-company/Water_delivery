import 'package:equatable/equatable.dart';

class TokenFields {
  static const String token = 'accessToken';
}

class Token extends Equatable {
  Token({
    required this.token,
  });

  final String token;

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json[TokenFields.token],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TokenFields.token: token,
    };
  }

  @override
  List<Object?> get props => [token];
}
