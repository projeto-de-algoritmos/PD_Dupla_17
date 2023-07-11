part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object> get props => [];
}

class SendTextEvent extends ServiceEvent {
  final String text;

  const SendTextEvent({required this.text});

  @override
  List<Object> get props => [text];
}
