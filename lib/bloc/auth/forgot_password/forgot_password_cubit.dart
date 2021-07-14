import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_state.dart';

extension BlocGetter on BuildContext {
  ForgotPasswordCubit get forgotPasswordCubit => this.read<ForgotPasswordCubit>();
}

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordEmailInput());

  void resetPassword() {
    emit(ForgotPasswordNewPasswordInput());
  }
}
