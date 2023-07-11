import 'package:app/data/data_source.dart';
import 'package:app/politician_option.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final DataSource dataSource;
  ServiceBloc({required this.dataSource}) : super(ServiceInitial()) {
    on<SendTextEvent>((event, emit) {
      emit(ServiceLoading());
      final result = dataSource.getPoliticianOption(event.text);
      result.fold(
        (l) => emit(const ServiceError(
            errorMessage: 'Ops, algo deu Errado Tente Novamente!')),
        (r) => emit(ServiceLoaded(option: r)),
      );
    });
  }
}
