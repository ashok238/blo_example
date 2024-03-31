import 'package:bloc/bloc.dart';
import 'package:bloc_example/model.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) {
      final email=event.userModel.email;
      final pass=event.userModel.pass;

      if(pass.length <6)
      emit(AuthFail('Password length should chnage'));
      else
emit(AuthSuccess(email));
    });
    on<AuthLogOutREequested>((event, emit) {
      emit(AuthInitial());
    },);
  }
}
