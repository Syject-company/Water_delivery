import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/support/message_form.dart';
import 'package:water/domain/service/support_service.dart';
import 'package:water/locator.dart';

part 'support_event.dart';
part 'support_state.dart';

extension BlocGetter on BuildContext {
  SupportBloc get support => this.read<SupportBloc>();
}

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  SupportBloc() : super(SupportState());

  final SupportService _supportService = locator<SupportService>();

  @override
  Stream<SupportState> mapEventToState(
    SupportEvent event,
  ) async* {
    if (event is SendMessage) {
      yield* _mapSendMessageToState(event);
    }
  }

  Stream<SupportState> _mapSendMessageToState(
    SendMessage event,
  ) async* {
    try {
      print('send message');

      yield state.copyWith(status: MessageStatus.sending);

      final form = MessageForm(
        name: event.name,
        email: event.email,
        phone: event.phone,
        message: event.message,
      );

      await _supportService.sendMessage(form);

      yield state.copyWith(status: MessageStatus.sent);
    } on HttpException catch (e) {
      yield state.copyWith(status: MessageStatus.failed);
    }
  }
}
