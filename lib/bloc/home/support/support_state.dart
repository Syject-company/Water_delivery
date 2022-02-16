part of 'support_bloc.dart';

enum MessageStatus { none, sending, sent, failed }

class SupportState extends Equatable {
  const SupportState({
    this.status = MessageStatus.none,
  });

  final MessageStatus status;

  SupportState copyWith({
    MessageStatus? status,
  }) =>
      SupportState(
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [status];
}
