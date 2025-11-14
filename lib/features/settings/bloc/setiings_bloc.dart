import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'setiings_event.dart';
part 'setiings_state.dart';

class SetiingsBloc extends Bloc<SetiingsEvent, SetiingsState> {
  SetiingsBloc() : super(SetiingsInitial()) {
    on<SetiingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
