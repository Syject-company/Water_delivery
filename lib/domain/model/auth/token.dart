import 'package:equatable/equatable.dart';

class TokenFields {
  static const String token = 'accessToken';
}

class Token extends Equatable {
  Token({
    required this.token,
  });

  final String token;

  Token.fromJson(Map<String, dynamic> json)
      : this(
          token: json[TokenFields.token] as String,
        );

  Map<String, dynamic> toJson() => {
        TokenFields.token: token,
      };

  @override
  List<Object?> get props => [token];
}
