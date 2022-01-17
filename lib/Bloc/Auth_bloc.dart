

import 'package:colireli_delivery/Repo_API/AuthRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Auth_events.dart';
import 'Auth_state.dart';

class AuthBloc extends Bloc<AuthEvents,Authstate>{
  AuthRepo repo = AuthRepo();


  AuthBloc() : super(LoginInitState());

  @override
  Stream<Authstate> mapEventToState(AuthEvents event) async* {
    yield LoginLoadingState();
    if(event is LoginButtonPressed){
      try{
        var result = await repo.login(event.email, event.password);
        print (result);
        if(result != null){
          yield UserLoginSuccessState();
        }else{
          yield LoginErrorState(result);
        }
      }catch(e){
        print(e.toString());
        yield LoginErrorState("The Password or Email is incorrect");
      }

    }
  }


}





