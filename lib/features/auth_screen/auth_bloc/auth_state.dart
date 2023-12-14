class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoggedInState extends AuthState {}


class AuthErrorState extends AuthState {
  final String reasonPhrase; // Add this

  AuthErrorState(this.reasonPhrase); // Add this

  List<Object> get props => [reasonPhrase];
}
