import 'package:equatable/equatable.dart';

class MessageFormFields {
  static const String name = 'name';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String message = 'message';
}

class MessageForm extends Equatable {
  const MessageForm({
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
  });

  final String name;
  final String email;
  final String phone;
  final String message;

  Map<String, dynamic> toJson() => {
        MessageFormFields.name: name,
        MessageFormFields.email: email,
        MessageFormFields.phone: phone,
        MessageFormFields.message: message,
      };

  @override
  List<Object> get props => [
        name,
        email,
        phone,
        message,
      ];
}
