abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String login;
  final String password;

  LoginEvent({required this.login, required this.password});
}

class AuthErrorEvent extends AuthEvent {
  final String reasonPhrase;

  AuthErrorEvent(this.reasonPhrase);

  
  List<Object> get props => [reasonPhrase];
}
