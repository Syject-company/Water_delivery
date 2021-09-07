part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePassword extends ChangePasswordEvent {
  const ChangePassword({
    required this.password,
    required this.newPassword,
  });

  final String password;
  final String newPassword;

  @override
  List<Object> get props => [
        password,
        newPassword,
      ];
}
