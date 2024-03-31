part of 'auth_bloc.dart';


sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState{

  final String email;
  AuthSuccess(this.email);


}
final class AuthFail extends AuthState{
  final String Error;
  AuthFail(this.Error);

}
