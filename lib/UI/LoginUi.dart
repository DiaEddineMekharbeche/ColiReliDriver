





import 'package:colireli_delivery/Bloc/Auth_bloc.dart';
import 'package:colireli_delivery/Bloc/Auth_events.dart';
import 'package:colireli_delivery/Bloc/Auth_state.dart';
import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'home.dart';



class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late bool _passwordVisible ;
   AuthBloc authbloc = AuthBloc() ;



  @override
  void initState() {
    // BlocProvider.of<AuthBloc>(context);
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      //************************************************************************/
      body: getbody(),
    );
  }
  Widget getbody(){
    var size = MediaQuery.of(context).size;


   return SingleChildScrollView(




     child:Padding(
       padding: const EdgeInsets.only(top: 0),
       child: Container(
         height: size.height,
         decoration: BoxDecoration(gradient: LinearGradient(
           begin: Alignment.topLeft,
           end: Alignment.bottomCenter,
           colors: [
             colireli,
             colireli,
           ],
         ),

           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0),bottomRight: Radius.circular(0)),
         ),

         child: Column(

          children: [
            Material(


              child:Padding(
                padding: const EdgeInsets.only(top:0),
                child: Container(

                  height: size.height/3,
                  width: size.width,
                  decoration: BoxDecoration(gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      colireli,
                      colireli,
                    ],
                  ),

                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0),bottomRight: Radius.circular(0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child:   Image.asset('assets/logoDriver.png',height: 120,width: 120,),
                      ),

                    ],
                  ),
                ),
              )
            ),


               Padding(
                padding: const EdgeInsets.only(left: 0,bottom: 18,top: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text('Login'.tr,style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 36,color: Colors.white
                      ),),
                    ),
                  ],
                ),
              ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Material(
              elevation: 5,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: size.height/3,
                  decoration: BoxDecoration(


                    borderRadius: BorderRadius.all( Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(textDirection: TextDirection.ltr,
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                              ),
                              hintText: 'Email'.tr,
                              contentPadding: EdgeInsets.fromLTRB(20, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0) )
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(textDirection: TextDirection.ltr,
                          controller:  password,

                         
                          obscureText: _passwordVisible,

                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Theme.of(context).primaryColorDark,
                                ), onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },

                                // Based on passwordVisible state choose the icon

                              ),

                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                              ),
                              hintText: 'Password'.tr,
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15,left: 8,right: 8,bottom: 8),
                        child: SizedBox(
                          width: size.width/1,
                          height: size.height/15,
                          child: RaisedButton(elevation: 4,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(20),
                            ),
                            onPressed: (){
                              authbloc.add(LoginButtonPressed(email : email.text,password: password.text));
                              print(email.text);
                              //Navigator.pushNamed(context, '/Home');
                            },
                            padding: EdgeInsets.all(12),
                            color: colireli,

                            child: Text('LOGIN'.tr,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 19),),

                          ),
                        ),
                      ),
                      BlocProvider<AuthBloc>(
                        create: (BuildContext context) => authbloc ,
                        child: BlocBuilder<AuthBloc,Authstate>(
                          bloc: authbloc,
                          builder: (context,state){
                            if (state is LoginLoadingState){
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if(state is LoginErrorState){
                              return Center(
                                child: Text(state.message),
                              );
                            }
                            if(state is UserLoginSuccessState){
                              SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context)=> home()), (route) => false);
                              });

                            }
                            return Container();
                          },
                        ),
                        /*child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 24.0,right: 24.0),
                        children:<Widget> [
                          logo,
                          SizedBox(height: 20.0),
                          msg,
                          SizedBox(height: 48.0),
                          username,
                          SizedBox(height: 20.0),
                          pass,
                          SizedBox(height: 24.0),
                          loginButton,

                        ],

                      ),
                    ),*/
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )


          ],
    ),
       ),
     ),
   );
  }
}
