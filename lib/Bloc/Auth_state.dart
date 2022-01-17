

import 'package:equatable/equatable.dart';

class Authstate extends Equatable {



  @override
  List<Object> get props => [];


}
class LoginInitState extends Authstate{

}
class LoginLoadingState extends Authstate{}
class UserLoginSuccessState extends Authstate {}

class LoginErrorState extends Authstate {
  final String message ;
  LoginErrorState (this.message);
}