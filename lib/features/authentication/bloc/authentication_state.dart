part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final bool isLoading;
  final bool isUserLoggedIn;
  const AuthenticationState({
    this.isLoading = false,
    this.isUserLoggedIn = false,
  });

  AuthenticationState copyWith({bool? isLoading, bool? isUserLoggedIn}) {
    return AuthenticationState(
      isLoading: isLoading ?? this.isLoading,
      isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
    );
  }

  @override
  List<Object> get props => [isLoading, isUserLoggedIn];
}
