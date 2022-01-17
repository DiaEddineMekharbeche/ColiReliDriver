


import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class InformationDetails  extends StatefulWidget {
  @override
  _InformationDetailsState createState() => _InformationDetailsState();
}

class _InformationDetailsState extends State<InformationDetails> {
  final controller = Get.put(ColiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4,
        titleSpacing: 0,
        actions: [

        ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'My Informations'.tr,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: getBody(),
    );
  }
  Widget getBody(){
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child:Material(
        color: Colors.white.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0,bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20,left: 12,right: 12),
                child: Column(
                  children: [
                    new Container(
                        width: size.width/3.5,
                        height: size.height/7,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              image: new ExactAssetImage(
                                  'assets/profile_pic.png'),
                              fit: BoxFit.fill,
                            ))),
                    Text(controller.user.value.name?? '' ,style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold,

                    ),),
                    Text( controller.user.value.type?? '',style: TextStyle(
                        fontSize: 14,fontWeight: FontWeight.normal,
                        color: Colors.black.withOpacity(0.5)

                    ),),
                    Padding(
                      padding: const EdgeInsets.only(right: 8,left: 8,top: 20,bottom: 8),
                      child: Material(
                        color: Colors.white,
                        elevation: 3,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12,left: 5,right: 5,bottom: 12),
                          child: Container(
                            child: Column(

                              children: [

                                Row(

                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(left: 2,right: 8,top: 8,bottom: 8),

                                      child: Container(

                                        child: Icon(Icons.email,color: Colors.black,size: 26,),
                                      ),
                                    ),
                                    Row(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Email: '.tr,style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 16
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: Text(controller.user.value.email!,style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize:14,
                                            color: Colors.black.withOpacity(0.5),


                                          ),),
                                        ),
                                      ],
                                    ),
                                    Spacer(),


                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 12,bottom: 12,left: 0,right: 0),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.05),
                                    width: size.width,
                                    height: size.height/300,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2,right: 8,top: 8,bottom: 8),
                                      child: Container(
                                        child: Icon(Icons.person,color: Colors.black,size: 26,),
                                      ),
                                    ),
                                    Row(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Name: '.tr,style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 16
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: Text(controller.user.value.name!,style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize:14,
                                            color: Colors.black.withOpacity(0.5),


                                          ),),
                                        ),
                                      ],
                                    ),
                                    Spacer(),


                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12,bottom: 12,left: 0,right: 0),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.05),
                                    width: size.width,
                                    height: size.height/300,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2,right: 8,top: 8,bottom: 8),
                                      child: Container(

                                          child: Icon(Icons.phone)
                                      ),
                                    ),
                                    Row(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Phone Number: '.tr,style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 16
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: Text(controller.user.value.phone!,style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize:14,
                                            color: Colors.black.withOpacity(0.5),


                                          ),),
                                        ),
                                      ],
                                    ),
                                    Spacer(),


                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12,bottom: 12,left: 0,right: 0),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.05),
                                    width: size.width,
                                    height: size.height/300,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2,right: 8,top: 8,bottom: 8),
                                      child: Container(

                                          child: Icon(Icons.location_city)
                                      ),
                                    ),
                                    Row(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('City: '.tr,style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 14
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: Text("Not Declared".tr,style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize:12,
                                            color: Colors.black.withOpacity(0.5),


                                          ),),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                   

                                  ],
                                ),

                                /*   RaisedButton(
                                    child: Text('Change Theme'),
                                      onPressed: (){
                                        Get.bottomSheet(
                                          Container(
                                            child: Wrap(
                                              children: [
                                                ListTile(
                                                  leading: Icon(Icons.wb_sunny_outlined),
                                                  title: Text('Light Theme'),
                                                  onTap: ()=>{
                                                     Get.changeTheme(ThemeData.light())
                                                  },
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.wb_sunny),
                                                  title: Text('Dark Theme'),
                                                  onTap: () => {
                                                     Get.changeTheme(ThemeData.dark())
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                          backgroundColor: Colors.white
                                        );
                                      }
                                  )*/


                              ],
                            ),

                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
