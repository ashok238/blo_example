part of 'auth_bloc.dart';


sealed class AuthEvent {}

class AuthLoginRequested extends AuthEvent{
UserModel userModel;
AuthLoginRequested(this.userModel);

}

class AuthLogOutREequested extends AuthEvent {

}
