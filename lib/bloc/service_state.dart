part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final PoliticianOption option;

  const ServiceLoaded({required this.option});

  @override
  List<Object> get props => [option];
}

class ServiceError extends ServiceState {
  final String errorMessage;

  const ServiceError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
