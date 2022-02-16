part of 'support_bloc.dart';

abstract class SupportEvent extends Equatable {
  const SupportEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends SupportEvent {
  const SendMessage({
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
  });

  final String name;
  final String email;
  final String phone;
  final String message;

  @override
  List<Object> get props => [
        name,
        email,
        phone,
        message,
      ];
}
