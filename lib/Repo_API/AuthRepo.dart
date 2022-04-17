import 'dart:convert';


import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:colireli_delivery/Models/Colis.dart';
import 'package:colireli_delivery/Models/Driver_fees.dart';
import 'package:colireli_delivery/Models/Keys.dart';
import 'package:colireli_delivery/Models/Mission.dart';
import 'package:colireli_delivery/Models/Payments.dart';
import 'package:colireli_delivery/Models/Reasons.dart';
import 'package:colireli_delivery/UI/OutToDelivery.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colireli_delivery/Models/Coli.dart';
import 'package:colireli_delivery/Models/DeliveryUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class AuthRepo {

  User user = new User();
  String? iD_Mission;



  Future<String> login(String email,String password )async{

    var res = await http.post(Uri.parse(mainRepo+'/api/v1/auth/login'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body: jsonEncode({"email" : email , "password": password})

    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );
    print(res.body);
    print(res.statusCode);
    final data = json.decode(res.body);
    print(data);
    if(res.statusCode != 200){
      return "internal Server Error";
    }
    if ( data != null){
      print("trueeeeee");

      var pref = await SharedPreferences.getInstance();
      String dataa = data['api_token'].toString();
      String? name = data['user']['name'].toString();
       iD_Mission = data['current_mission']['id'].toString();

      print(dataa);
      await pref.setString("token", dataa);
      await pref.setString("name", name);
     await pref.setBool("isLoggedIn", true);
     await pref.setString('idmission', iD_Mission!.toString());
     print('idMissionn : $iD_Mission');
       print(name);

      return "success" ;
    }else {
      return "error auth";
    }
  }

  Future postIdds(List idss)async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    var res = await http.post(Uri.parse(mainRepo+'/api/createMission'),
        headers: {
          'Accept': 'application/json;charset=UTF-8',
          'Authorization': ' Bearer '+token,
        },
        body: {"checked_ids" : idss.toString(),}

    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );
     print(res.statusCode);

    print('mybody'+ res.body);
    var msg = jsonDecode(res.body)['msg'];
    var status = jsonDecode(res.body)['status'];

    if(res.statusCode == 200 && status == true){

       Get.snackbar("Success", "Validation Success!",duration: Duration(seconds: 2),
          backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
       iD_Mission = jsonDecode(res.body)['data']['id'].toString();
       var pref = await SharedPreferences.getInstance();
       await pref.setString("idmission", iD_Mission!.toString());
       Get.off(()=>OutToDelivery(), transition: Transition.rightToLeftWithFade);
       print(iD_Mission);



    }else{
      Get.snackbar("Error",jsonDecode(res.body)['msg'],duration: Duration(seconds: 4),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
    }

  }




  Future<bool> postOutOfDelivery(String idShipments,String idMission)async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    var res = await http.post(Uri.parse(mainRepo+'/api/outToDeliver'),
        headers: {
          'Accept': 'application/json;charset=UTF-8',
          'Authorization': ' Bearer '+token,
        },
        body: {"mission" : idMission,
               "shipments" :  idShipments,
        }

    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );

    print(res.statusCode);
    print(idShipments);
    print(idMission);

    print('mybody'+ res.body);
    var success = jsonDecode(res.body)['success'];

    if(res.statusCode == 200 && success == true   ){


      Get.snackbar("Success", "Out of Delivery List Success!",duration: Duration(seconds: 2),
          backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
      getOutOfDeliveryShipment();

      return true;


    }else{

      return false ;
    }

  }

  getColi(String code) async{
    var pref = await  SharedPreferences.getInstance();
   late String token = pref.getString('token')!;
    print('tokennn is: $token');

    var res = await http.get(Uri.parse(mainRepo+'/api/getShipment?code='+code),
      headers: {
      'Authorization': ' Bearer '+token,

      },
    );

    print(res.body);
    var success = jsonDecode(res.body)['success'];

    var json = jsonDecode(res.body)['data'];
    if(res.statusCode == 200 && success == true ){
      print(json);
      var coli = Data.fromJson(json);
      print(coli.area!.name!.toString());



      return coli;
    }else{
      var msg = jsonDecode(res.body)['message'];
      Get.snackbar("Error", msg,duration: Duration(seconds: 2),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
    }


  }

  Future<User> getUser()async{

    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    print('TokenUSer: '+token);

    var res = await http.get(Uri.parse(mainRepo+'/api/v1/auth/getUser'),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    );
    var success = jsonDecode(res.body)['success'];
    print(res.body);

   if(res.statusCode ==200 && success == true){

     print('status : ${res.statusCode}');
    var json = jsonDecode(res.body)['user'];
    print (json.toString());
        user = User.fromJson(json);
        return user;
    }else{
     var msg = jsonDecode(res.body)['message'];
     throw Exception(msg);

   }


  }

  getColiToValidate(String code)async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    var res = await http.get(Uri.parse(mainRepo+'/api/getShipment?code='+code),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    );
    var json = jsonDecode(res.body)['data'];
    var success = jsonDecode(res.body)['status'];
    var msg = jsonDecode(res.body)['msg'];
    if(res.statusCode ==200&& success == true ){

      print('status : ${res.statusCode}');

      print (json.toString());
       var coli = Coli.fromJson(json);
      return coli;
    }else{
      Get.snackbar("Error", msg,duration: Duration(seconds: 2),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));


    }
  }

  getDeliveryMission()async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    String idMission = pref.getString('idmission')!;
    var res = await http.get(Uri.parse(mainRepo+'/api/getMissionShipments?mission_id='+idMission.toString()),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    );

    var msg = jsonDecode(res.body)['msg'];
    print(res.body);
    var status = jsonDecode(res.body)['success'];
    if(res.statusCode ==200 && status == true){

      print('status : ${res.statusCode}');
      var json = jsonDecode(res.body)['data']as List;
      print (json.toString());
      var colis = json.map((coli) => Mission.fromJson(coli)).toList();
      print(colis);
      return colis;
    }else{

      Get.snackbar("Error", msg,duration: Duration(seconds: 2),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
    }


  }



  getOutOfDeliveryShipment()async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    String idmission = pref.getString('idmission')!;
    var res = await http.get(Uri.parse(mainRepo+'/api/getShipmentsByStatus?mission=$idmission&status=20'),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );
    var success = jsonDecode(res.body)['success'];
    print(res.body);

    if(res.statusCode ==200 && success == true){

      print('status : ${res.statusCode}');
      var json = jsonDecode(res.body)['data'] as List;
      print (json.toString());
      var colis = json.map((coli) => Data.fromJson(coli)).toList();
      print(colis);

      return colis;
    }else{
     // Get.snackbar("Error", msg.toString(),duration: Duration(seconds: 2),
       //   backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));

    }


  }

  Future<bool> delivered(String idShipments,String idMission)async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    var res = await http.post(Uri.parse(mainRepo+'/api/admin/shipments/delivered'),
        headers: {
          'Accept': 'application/json;charset=UTF-8',
          'Authorization': ' Bearer '+token,
        },
        body: {"mission" : idMission,
          "shipment" :  idShipments,
        }

    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );

    print(res.statusCode);
    print(idShipments);
    print(idMission);

    print('mybody'+ res.body);
    var success = jsonDecode(res.body)['status'];
    print(success.toString());
    var msg = jsonDecode(res.body)['message'];

    if(res.statusCode == 200 && success == true   ){


      Get.snackbar("Success",msg,duration: Duration(seconds: 2),
          backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));


      return true;


    }else{
      Get.snackbar("error",msg,duration: Duration(seconds: 2),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
      return false ;
    }

  }
  getDeliveredShipments()async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    String idmission = pref.getString('idmission')!;
    print("idmission:$idmission");

    var res = await http.get(Uri.parse(mainRepo+'/api/getShipmentsByStatus?mission=$idmission&status=9'),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );
    var success = jsonDecode(res.body)['success'];
    var msg = jsonDecode(res.body)['message'];
    if(res.statusCode ==200 && success == true){

      print('status : ${res.statusCode}');
      var json = jsonDecode(res.body)['data']as List;
      print (json.toString());
      var colis = json.map((coli) => Data.fromJson(coli)).toList();
      print(colis);
      return colis;
    }else{
     // Get.snackbar("Error", msg.toString(),duration: Duration(seconds: 2),
       //   backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));

    }


  }


  getPaymentReport()async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    String idmission = pref.getString('idmission')!;
    print("idmission$idmission");

    var res = await http.get(Uri.parse(mainRepo+'/api/calculate_mission_fee/$idmission'),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );
    var message = jsonDecode(res.body)['message'];
    var status = jsonDecode(res.body)['status'];
    print('statusPaymentRApport : ${res.statusCode}');
    if(res.statusCode ==200 && status == true){

      print(res.body);
      var json = jsonDecode(res.body)['rapport'];
      print (json.toString());
      if(json != null){
        var rapports = Rapport.fromJson(json);
        print(rapports);
        Get.snackbar("information", message.toString(),duration: Duration(seconds: 2),
            backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));

        return rapports;
      }
      print(message);
      Get.snackbar("Information", message.toString(),duration: Duration(seconds: 2),
          backgroundColor: ColiReliOrange,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));



    }else{

      print(message);
      Get.snackbar("Information", message.toString(),duration: Duration(seconds: 2),
          backgroundColor: ColiReliOrange,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));

    }


  }
  getDetailsRaport()async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    String idmission = pref.getString('idmission')!;
    print("idmission$idmission");

    var res = await http.get(Uri.parse(mainRepo+'/api/calculate_mission_fee/$idmission'),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );
    var message = jsonDecode(res.body)['message'];
    var status = jsonDecode(res.body)['status'];
    print('statusDetailsRapport : ${res.statusCode}');
    if(res.statusCode ==200 && status == true){

      print(res.body);
      var json = jsonDecode(res.body)['details']as List;
      print (json.toString());
      var rapports = json.map((rapport) => Details.fromJson(rapport)).toList();
      print(rapports);
      return rapports;
    }else{

      print(message);

    }


  }
  getReasons(String name , var lang)async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    String idmission = pref.getString('idmission')!;
    var res = await http.get(Uri.parse(mainRepo+'/api/getReasons/'+name+'/'+lang),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );

    var status = jsonDecode(res.body)['success'];
    print('status12 : ${res.statusCode}');
    if(res.statusCode ==200 && status == true){

      print(res.body);
      var json = jsonDecode(res.body)['reasons']as List;

      print (json.toString());
      var rapports = json.map((rapport) => Reasons.fromJson(rapport)).toList();

      return rapports;
    }else{


      Get.snackbar("Error", "Error Server",duration: Duration(seconds: 2),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));

    }


  }
  getKeys( var lang)async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    String idmission = pref.getString('idmission')!;
    var res = await http.get(Uri.parse(mainRepo+'/api/getReasonsKeys/'+lang),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );

    var status = jsonDecode(res.body)['success'];
    print('status12 : ${res.statusCode}');
    if(res.statusCode ==200 && status == true){

      print(res.body);
      var json = jsonDecode(res.body)['reasons']as List;

      print (json.toString());
      var rapports = json.map((rapport) => Type.fromJson(rapport)).toList();
      print(rapports[1].origin);

      return rapports;
    }else{


      Get.snackbar("Error", "Error Server",duration: Duration(seconds: 2),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));

    }


  }

  getFailedAttempt()async{
    var pref = await  SharedPreferences.getInstance();
    late String token =  pref.getString('token')!;
    String idmission =  pref.getString('idmission')!;
    var res = await http.get(Uri.parse(mainRepo+'/api/getShipmentsByStatus?mission=$idmission&status=17'),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );
    var success = jsonDecode(res.body)['success'];
    var msg = jsonDecode(res.body)['message'];
    if(res.statusCode ==200 && success == true){

      print('status : ${res.statusCode}');
      var json = jsonDecode(res.body)['data']as List;
      print (json.toString());
      var colis = json.map((coli) => Data.fromJson(coli)).toList();
      print(colis);
      return colis;
    }else{
    //  Get.snackbar("Error", msg.toString(),duration: Duration(seconds: 2),
      //    backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));

    }


  }
  getAlertShipment()async{
    var pref = await  SharedPreferences.getInstance();
    late String token =  pref.getString('token')!;
    String idmission =  pref.getString('idmission')!;
    var res = await http.get(Uri.parse(mainRepo+'/api/getShipmentsByStatus?mission=$idmission&status=16'),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );
    var success = jsonDecode(res.body)['success'];
    var msg = jsonDecode(res.body)['message'];
    if(res.statusCode ==200 && success == true){

      print('status : ${res.statusCode}');
      var json = jsonDecode(res.body)['data']as List;
      print (json.toString());
      var colis = json.map((coli) => Data.fromJson(coli)).toList();
      print(colis);
      return colis;
    }else{
      //  Get.snackbar("Error", msg.toString(),duration: Duration(seconds: 2),
      //    backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));

    }


  }
  Future returnShipment(String idShipments,String idMission,String reasonId,String? description)async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    var res = await http.post(Uri.parse(mainRepo+'/api/admin/shipments/return'),
        headers: {
          'Accept': 'application/json;charset=UTF-8',
          'Authorization': ' Bearer '+token,
        },
        body: {"mission_id" : idMission,
          "shipment_id" :  idShipments,
          "reason_id" : reasonId,
          "is_alert": "1",
          'reason_description':description!,
        }

    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );

    print(res.statusCode);
    print(idShipments);
    print(idMission);
    print(reasonId);

    print('mybody'+ res.body);
    var success = jsonDecode(res.body)['success'];

    if(res.statusCode == 200 && success == true ){
      pref.setString("alertidShipment", idShipments);
      pref.setString("alertidMission", idMission);
      pref.setString("reasonid", reasonId);
      String? ID = pref.getString('alertidShipment');
      print('iddddds'+ID!);


      Get.snackbar("Success", "the Shipment canceled  with Success!",duration: Duration(seconds: 2),
          backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));





    }else{

      Get.snackbar("Error", " Server problem ,try again please !",duration: Duration(seconds: 2),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
    }

  }

  getDeliverAssignedShipment()async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    String idmission = pref.getString('idmission')!;
    print("idmission$idmission");

    var res = await http.get(Uri.parse(mainRepo+'/api/getShipmentsByStatus?mission=$idmission&status=8'),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );
    var success = jsonDecode(res.body)['success'];
    var msg = jsonDecode(res.body)['message'];
    if(res.statusCode ==200 && success == true){

      print('status : ${res.statusCode}');
      var json = jsonDecode(res.body)['data']as List;
      print (json.toString());
      var colis = json.map((coli) => Data.fromJson(coli)).toList();
      print(colis);
      return colis;
    }else{


    }


  }
  Future<bool> postRestoreShipments(String idShipments,String idMission)async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    var res = await http.post(Uri.parse(mainRepo+'/api/admin/shipments/restoreshipment'),
        headers: {
          'Accept': 'application/json;charset=UTF-8',
          'Authorization': ' Bearer '+token,
        },
        body: {"mission_id" : idMission,
          "shipment_id" :  idShipments,
        }

    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );

    print(res.statusCode);
    print(idShipments);
    print(idMission);

    print('mybody'+ res.body);
    var success = jsonDecode(res.body)['status'];

    if(res.statusCode == 200 && success == true   ){


      Get.snackbar("Success", "Shipments restored!",duration: Duration(seconds: 2),
          backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
      getOutOfDeliveryShipment();

      return true;


    }else{

      Get.snackbar("Error",jsonDecode(res.body)['msg'],duration: Duration(seconds: 2),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
      return false;
    }

  }

  Future<bool> EditMission(String codeShipment)async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;

       late String idmission =  pref.getString("idmission")!;
    var res = await http.post(Uri.parse(mainRepo+'/api/admin/addShipmentToMission'),
        headers: {
          'Accept': 'application/json;charset=UTF-8',
          'Authorization': ' Bearer '+token,
        },
        body: {"mission" : idmission,
          "shipment" :  codeShipment,
        }

    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );

    print(res.statusCode);
    print(codeShipment);
    print(idmission);

    print('mybody'+ res.body);
    var success = jsonDecode(res.body)['status'];
    print(success.toString());
    var msg = jsonDecode(res.body)['message'];

    if(res.statusCode == 200 && success == true   ){


      Get.snackbar("Success",msg,duration: Duration(seconds: 2),
          backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));


      return true;


    }else{
      Get.snackbar("error",msg,duration: Duration(seconds: 2),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
      return false ;
    }

  }
  getDeliveryFeePrices()async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    String idMission = pref.getString('idmission')!;
    var res = await http.get(Uri.parse(mainRepo+'/api/getDriverRates'),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    );

    var msg = jsonDecode(res.body)['msg'];
    print(res.body);
    var status = jsonDecode(res.body)['success'];
    if(res.statusCode ==200 && status == true){

      print('status : ${res.statusCode}');
      var json = jsonDecode(res.body)['driver_fees']as List;
      print (json.toString());
      var colis = json.map((coli) => DriverFees.fromJson(coli)).toList();
      print(colis);
      return colis;
    }else{

      Get.snackbar("Error", msg,duration: Duration(seconds: 2),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
    }


  }
  getDeliveryDEfaultFeePrices()async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    String idMission = pref.getString('idmission')!;
    var res = await http.get(Uri.parse(mainRepo+'/api/getDriverRates'),
      headers: {
        'Accept': 'application/json;charset=UTF-8',
        'Authorization': ' Bearer '+token,

      },
    );

    var msg = jsonDecode(res.body)['msg'];
    print(res.body);
    var status = jsonDecode(res.body)['success'];
    if(res.statusCode ==200 && status == true){

      print('status : ${res.statusCode}');
      var json = jsonDecode(res.body)['default_driver_fee'];
      print (json.toString());
      var colis = DefaultDriverFee.fromJson(json);
      print(colis);
      return colis;
    }else{

      Get.snackbar("Error", msg,duration: Duration(seconds: 2),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
    }


  }
  Future isFailedAttempt()async{
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    String reasonId =  pref.getString('reasonid')!;
    print(reasonId+"resasonnnnn");
    String missionID = pref.getString('alertidMission')!;
    String shipmentID = pref.getString('alertidShipment')!;
    if (reasonId != null && missionID != null && shipmentID != null){


    var res = await http.post(Uri.parse(mainRepo+'/api/admin/shipments/return'),
        headers: {
          'Accept': 'application/json;charset=UTF-8',
          'Authorization': ' Bearer '+token,
        },
        body: {"mission_id" : missionID,
          "shipment_id" :  shipmentID,
          "reason_id" : reasonId,
          "is_alert": "0",
          "reason_description":""
        }

    ).timeout(Duration(seconds: 30),onTimeout: (){
      return new http.Response(jsonDecode("Time Out"), 500);
    }
    );

    print(res.statusCode);
    print(shipmentID);
    print(missionID);
    print(reasonId);

    print('mybody'+ res.body);
    var success = jsonDecode(res.body)['success'];

    if(res.statusCode == 200 && success == true ){
       pref.remove('resasonnnnn');
       pref.remove('alertidMission');
       pref.remove('alertidShipment');
       print("alles remove");

      Get.snackbar("Success", " failed attempt  Shipment   is done !",duration: Duration(seconds: 2),
          backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));


    }else{

      Get.snackbar("Error", " unknown shipment ,try again please !",duration: Duration(seconds: 2),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
    }
    }else{
      print('rani lgit kolech nullll');
      return;

    }

  }



}