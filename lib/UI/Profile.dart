


import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:colireli_delivery/UI/InformationDeatils.dart';
import 'package:colireli_delivery/UI/LoginUi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Shipment_Card.dart';
import 'UserInfo.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ColiController controller = Get.find();
  String _selectLanguage='fr' ;
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: getbody(),floatingActionButton: FittedBox(
        child:  FloatingActionButton.extended(elevation: 4,focusElevation: 20,
          heroTag: 'btn2',


          onPressed: () {

            logoutUser();




          },
          label:  Text('Log out'.tr,style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red
          ),),
          icon: Icon (Icons.exit_to_app_rounded,size: 25,color: Colors.red,),
          backgroundColor: Colors.white,








        ),
      ),





      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );

  }


  Widget getbody(){
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
                    Material(

                      elevation: 3,
                      borderRadius: BorderRadius.all(Radius.circular(5)),

                      child: Container(
                        width: size.width,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12,bottom: 12),
                            child: Text("Profile".tr, style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 30
                            ),),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5,left: 12,right: 12),
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2,right: 8,top: 8,bottom: 8),
                          child: Container(

                              child: Icon(Icons.language_outlined)
                          ),
                        ),
                        DropdownButton(
                          items: [
                            DropdownMenuItem(
                              child: Text('Francais'),
                              value: 'fr',
                            ),
                            DropdownMenuItem(
                              child: Text('English'),
                              value: 'en',
                            ),
                            DropdownMenuItem(
                              child: Text('العربية'),
                              value: 'ar',
                            ),
                          ],
                          value :controller.appLocale,
                          onChanged: (value){
                            controller.changeLanguage(value.toString());
                            Get.updateLocale(Locale(value.toString()));

                          },
                        ),

                      ],
                    ),
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

                               InkWell(
                                 onTap: () {
                                   Get.to(()=>InformationDetails() , transition: Transition.leftToRight,

                                   );
                                 },




                               child: Row(

                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(left: 2,right: 8,top: 8,bottom: 8),

                                      child: Container(

                                        child: Icon(Icons.person,color: Colors.black,size: 26,),
                                      ),
                                    ),
                                    Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('My Informations'.tr,style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 14
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: Text('Name,Email'.tr,style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize:12,
                                            color: Colors.black.withOpacity(0.5),


                                          ),),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.keyboard_arrow_right,size: 24,),

                                  ],
                                ),
                               ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 12,bottom: 12,left: 0,right: 0),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.05),
                                    width: size.width,
                                    height: size.height/300,
                                  ),
                                ),
                          InkWell(
                            onTap: () {
                             // Get.to(()=>UserInfo() , transition: Transition.leftToRight,

                            //  );
                            },
                             child:   Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2,right: 8,top: 8,bottom: 8),
                                      child: Container(

                                        child: Image.asset(
                                          'assets/callcenter.png',
                                          height: size.height / 30,
                                          width: size.width / 15,
                                        ),
                                      ),
                                    ),
                                    Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Call Center'.tr,style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 14
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: Text('Helpdesk,Reports'.tr,style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize:12,
                                            color: Colors.black.withOpacity(0.5),


                                          ),),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.keyboard_arrow_right,size: 24,),

                                  ],
                                ),
                          ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12,bottom: 12,left: 0,right: 0),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.05),
                                    width: size.width,
                                    height: size.height/300,
                                  ),
                                ),
                          InkWell(
                            onTap: () {
                            //  Get.to(()=>UserInfo() , transition: Transition.leftToRight,

                              //);
                            },
                               child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2,right: 8,top: 8,bottom: 8),
                                      child: Container(

                                          child: Icon(Icons.wysiwyg_sharp)
                                      ),
                                    ),
                                    Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Billing Details'.tr,style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 14
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: Text('Benefits,Money'.tr,style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize:12,
                                            color: Colors.black.withOpacity(0.5),


                                          ),),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.keyboard_arrow_right,size: 24,),

                                  ],
                                ),
                              ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12,bottom: 12,left: 0,right: 0),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.05),
                                    width: size.width,
                                    height: size.height/300,
                                  ),
                                ),
                          InkWell(
                            onTap: () {
                             // Get.to(()=>UserInfo() , transition: Transition.leftToRight,

                              //);
                            },
                               child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2,right: 8,top: 8,bottom: 8),
                                      child: Container(

                                          child: Icon(Icons.info_rounded)
                                      ),
                                    ),
                                    Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Legal informations'.tr,style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 14
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: Text('Terms & Conditions,Privacy policy'.tr,style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize:size.width/35,
                                            color: Colors.black.withOpacity(0.5),


                                          ),),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.keyboard_arrow_right,size: 24,),

                                  ],
                                ),
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

            ],
          ),
        ),
      ),
    );
  }

  void logoutUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.clear();
   controller.listFailedAttempt.clear();
   controller.lisDeliveredColi.clear();
   controller.listColi.clear();
   controller.reasonsList.clear();
   controller.detailsRaport.clear();

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginUi()), (route) => false);

  }
}
