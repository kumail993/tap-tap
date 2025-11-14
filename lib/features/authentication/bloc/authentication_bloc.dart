import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_task/features/authentication/repository/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState()) {
    on<AuthenticationEvent>((event, emit) {});

    on<LoginEvent>(_loginUser);
  }

  Future<void> _loginUser(
    LoginEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      AuthRepository().loginUser(email: event.email, password: event.password);
      emit(state.copyWith(isLoading: false, isUserLoggedIn: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isUserLoggedIn: false));
    }
  }
}
