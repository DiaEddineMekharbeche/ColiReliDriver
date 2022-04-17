
import 'dart:async';
import 'dart:convert';

import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Models/Coli.dart';
import 'package:colireli_delivery/Models/Colis.dart';
import 'package:colireli_delivery/Models/DeliveryUser.dart';
import 'package:colireli_delivery/Models/Driver_fees.dart';
import 'package:colireli_delivery/Models/Keys.dart';
import 'package:colireli_delivery/Models/Keys.dart';
import 'package:colireli_delivery/Models/Keys.dart';
import 'package:colireli_delivery/Models/Mission.dart';
import 'package:colireli_delivery/Models/Payments.dart';
import 'package:colireli_delivery/Models/Reasons.dart';

import 'package:colireli_delivery/Repo_API/AuthRepo.dart';
import 'package:colireli_delivery/UI/AssignedShipment.dart';
import 'package:colireli_delivery/UI/Dashboard.dart';
import 'package:colireli_delivery/UI/LoginUi.dart';


import 'package:colireli_delivery/UI/OutToDelivery.dart';
import 'package:colireli_delivery/UI/home.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LocalStorage.dart';


class ColiController extends GetxController {
  var allColis = <Data>[].obs;
  var listSortieren = <Data>[].obs;
  var listColi = <Data>[].obs;
  var lisDeliveredColi = <Data>[].obs;
  var lisDeliveredFees = <DriverFees>[].obs;
  var listKeys = <Type>[].obs;
  var listString =<String> [].obs;
  var lisDeliveredDEfaultFees = <DefaultDriverFee>[].obs;
  var ListAssignedShipment = <Data>[].obs;
  var listFailedAttempt = <Data>[].obs;
  var listAlert = <Data>[].obs;
  var listReports = <Rapport>[].obs;
  var listempty = <Rapport>[].obs;
  var listColinew = <Data>[];
  var ListMission = <Mission>[].obs;
  var listids = <int>[].obs;
  var user = User().obs;
  var appLocale ;

  var reasonsList = <Reasons>[].obs;
  var reason = Reasons().obs;
  var count = 0.obs;
  bool success = false;
  var shipments;
  var deliveredColi;
  var deliveryFees;
  var keeys;
  var deliveryDefaultFees;
  var assignedColi;
  var failedAttempt;
  var alertvalue;
  var paymentReport;
  var reports = Rapport().obs;
  var details;
  var detailsRaport = <Details>[].obs;
  late bool succesReturn;

  var isGetUser = false.obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var isScan = true.obs;
  bool isScanned = false;
  var colis;
  var defaultFess;
  var defaultModelFess = DefaultDriverFee().obs;
  var mission;
  String? scanResult;


  var repo = AuthRepo();

  @override
  void onInit() async {
    getUserController();
    getOutofDeliveryShipments();
    getDeliveredShipmentsController();


    ever(isError, (value) {
      if (isError(true)) {
        Get.snackbar("Error", "Check Your Connection please!",
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.only(bottom: 20, left: 20, right: 20));
      }
    });
    super.onInit();
    LocalStorage localStorage = LocalStorage();

    appLocale = await localStorage.languageSelected == null
        ? Get.deviceLocale
        : await localStorage.languageSelected;
    update();
    Get.updateLocale(Locale(appLocale));
  }

  Future<void> scanBarcode() async {
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      scanResult = 'Failed to get platform version.';
    }


    if (scanResult != '-1') {
      Get.snackbar('Result', 'Scan success:' + scanResult!,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.only(bottom: 20, right: 10, left: 10)

      );


          getColiController(scanResult!);



    }

    print(scanResult);
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => getColiController(barcode)


    );
  }

  int getarraylist() {
    return allColis.length;
  }

  getColiController(String code) async {
    try {
      isLoading(true);

      colis = await repo.getColi(code);


      if (colis != null ) {
           listSortieren.add(colis);



             allColis.add(colis);
             count = allColis.length.obs;








        print('array length :' + allColis.length.toString());
      } else {

      }
    } catch (e) {
      isError(true);
      print('array length :' + allColis.length.toString());
      print(e.toString());
    } finally {

      isLoading(false);
    }
  }

  getMissionController() async {
    try {
      isLoading(true);
      mission = await repo.getDeliveryMission();
      if (mission != null) {
        //ListMission.addAll(mission);
        ListMission.value = mission;
        // allColis.add(colis);


        print('array length :' + ListMission.length.toString());
      } else {
        print('nulllllllll list');
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }

  getUserController() async {
    try {
      isGetUser(true);
      print('midkhaltttttttttttttt');

      var users = await repo.getUser();
      if (users != null) {
        user.value = users;
      }

      print(user.value.name);
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isGetUser(false);
    }
  }

  getValidationController() async {
    var myList = <int>[];

    if (allColis.isEmpty) {
      return Get.snackbar(
          "Error", "List is Empty Please Scan!", duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20));
    } else {
      try {
        for (int i = 0; i < allColis.length; i++) {
          print(allColis[i].id);
          var ids = allColis[i].id!;

             myList.add(ids);




          print('ani khalestttt');
        }
        final unisaueListe = myList.toSet().toList();
        print('ani rawyehnposti');
        print(unisaueListe);
        isLoading(true);
        await repo.postIdds(unisaueListe);
      } catch (e) {
        throw Exception(e.toString());
      } finally {
        isLoading(false);
        allColis.clear();

        getMissionController();
      }
    }
  }

  postOutOfDElivery(String _listIdShipment, String idMission) async {
    if (_listIdShipment.isEmpty) {
      return Get.snackbar("Error", "List is Empty Please Select items!",
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20));
    } else {
      try {
        isLoading(true);
        print('lisitems $_listIdShipment');
        success = await repo.postOutOfDelivery(_listIdShipment, idMission);

        print('ani postit');
      } catch (e) {
        throw Exception('Failed to Post data');
      } finally {
        isLoading(false);
        if (success == true) {
           getOutofDeliveryShipments();
          Get.offAll(()=>home(),duration: Duration(seconds: 1));
        } else {
          Get.snackbar("Error", "Invalid Shipment Mission",
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.only(bottom: 20, left: 20, right: 20));
        }
      }
    }
  }

  getOutofDeliveryShipments() async {
    try {
      isLoading(true);

      shipments = await repo.getOutOfDeliveryShipment();

      if (shipments != null) {
        //ListMission.addAll(mission);
        listColi.value = shipments;
        // print(listColi.value.toString());
        // allColis.add(colis);


        print('array length :' + listColi.length.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }

  DeliveredController(String _listIdShipment, String idMission) async {
    try {
      isLoading(true);
      print('lisitems $_listIdShipment');
      success = await repo.delivered(_listIdShipment, idMission);
      if (success == true) {
        getDeliveredShipmentsController();
        getOutofDeliveryShipments();
      }

      print('ani postit');
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }

  getDeliveredShipmentsController() async {
    try {
      isLoading(true);

      deliveredColi = await repo.getDeliveredShipments();

      if (deliveredColi != null) {
        //ListMission.addAll(mission);
        lisDeliveredColi.value = deliveredColi;
        // print(listColi.value.toString());
        // allColis.add(colis);


        print('array length :' + lisDeliveredColi.length.toString());
      } else {
        print("list Delivered empty");
      }
    } catch (e) {


    } finally {
      isLoading(false);
    }
  }

  getPaymentReportController() async {
    try {
      isLoading(true);

      var paymentReport = await repo.getPaymentReport();

      if (paymentReport != null) {
        //ListMission.addAll(mission);
        reports.value = paymentReport;
        // print(listColi.value.toString());
        // allColis.add(colis);

      }

    } catch (e) {
      throw Exception("Error catch"+e.toString());
    } finally {
      isLoading(false);
    }
  }

  getReasonsController(String name) async {
    try {
      isLoading(true);

      int index = listKeys.indexWhere((f) => f.translation == name);
      print(index);
      String? nameorigin = listKeys[index].origin;
       var lang =  Get.locale!.languageCode;
      var prefix = lang[0].trim();

      print('language:'+lang.toString());
      print('language:'+prefix);
      var reasons = await repo.getReasons(nameorigin!,lang);

      if (reasons != null) {
        //ListMission.addAll(mission);
        reasonsList.value = reasons;
        // print(listColi.value.toString());
        // allColis.add(colis);


      } else {
        Get.snackbar(""
            "Information", "Error Server please try again  ",
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.only(bottom: 20, left: 20, right: 20));
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
  getKeysController() async {
    try {
      isLoading(true);
      var lang =  Get.locale!.languageCode ;

      var prefix = lang[0].trim();

      print('language:'+lang.toString());
      print('language:'+prefix);
      var reasons = await repo.getKeys(lang);

      if (reasons != null) {
        //ListMission.addAll(mission);
        listKeys.value = reasons;
        print(listKeys[1].translation);


        // print(listColi.value.toString());
        // allColis.add(colis);


      } else {
        Get.snackbar(""
            "Information", "Error Server please try again  ",
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.only(bottom: 20, left: 20, right: 20));
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }

  getFailedAttempt() async {
    try {
      isLoading(true);

      failedAttempt = await repo.getFailedAttempt();

      if (failedAttempt != null) {
        //ListMission.addAll(mission);
        listFailedAttempt.value = failedAttempt;
        // print(listColi.value.toString());
        // allColis.add(colis);


        print('array length :' + listFailedAttempt.length.toString());
      } else {
        print("list failed Attempt is empty");
      }
    } catch (e) {


    } finally {
      isLoading(false);
    }
  }

  getAlertShipment() async {
    try {
      isLoading(true);

      alertvalue = await repo.getAlertShipment();

      if (alertvalue != null) {
        //ListMission.addAll(mission);
        listAlert.value = alertvalue;
        // print(listColi.value.toString());
        // allColis.add(colis);


        print('array length :' + listAlert.length.toString());
      } else {
        print("list failed Attempt is empty");
      }
    } catch (e) {


    } finally {
      isLoading(false);
    }
  }

  returnShipmentController(String? desc) async {
    try {
      isLoading(true);
      var pref = await SharedPreferences.getInstance();
      String reasonId = pref.getString('id')!;
      String missionID = pref.getString('idmission')!;
      String shipmentID = pref.getString('shipmentid')!;
       await repo.returnShipment(shipmentID, missionID, reasonId,desc!);
      getOutofDeliveryShipments();
      getFailedAttempt();

      print('ani postit return shipment');
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }

  getAssignedShipmentController() async {
    try {
      isLoading(true);

      assignedColi = await repo.getDeliverAssignedShipment();

      if (assignedColi != null) {
        //ListMission.addAll(mission);
        ListAssignedShipment.value = assignedColi;
        // print(listColi.value.toString());
        // allColis.add(colis);


        print('array length :' + ListAssignedShipment.length.toString());
      } else {
      print("list assigned shipments is empty");
      }
    } catch (e) {


    } finally {
      isLoading(false);
    }
  }

  getDetailsRaportController() async {
    try {
      isLoading(true);

      details = await repo.getDetailsRaport();

      if (details != null) {
        //ListMission.addAll(mission);
        detailsRaport.value = details;
        // print(listColi.value.toString());
        // allColis.add(colis);

        print('array length :' + detailsRaport.length.toString());
      } else {
        print("failed , mission is done ");
      }
    } catch (e) {

    } finally {
      isLoading(false);
    }
  }

  postRestoreShipmentsController(String _listIdShipment,
      String idMission) async {
    if (_listIdShipment.isEmpty) {
      return Get.snackbar("Error", "List is Empty Please Select items!",
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20));
    } else {
      try {
        isLoading(true);
        print('lisitems $_listIdShipment');
        success = await repo.postRestoreShipments(_listIdShipment, idMission);
        getOutofDeliveryShipments();
        getFailedAttempt();
        print('ani postit');
      } catch (e) {
        throw Exception(e.toString());
      } finally {
        isLoading(false);
      }
    }
  }
  void changeLanguage(String type) async {
    LocalStorage localStorage = LocalStorage();

    if (appLocale == type) {
      return;
    }
    if (type == 'ar') {
      appLocale = 'ar';
      localStorage.saveLanguageToDisk('ar');
    } else if(type == 'fr'){
      appLocale = 'fr';
      localStorage.saveLanguageToDisk('fr');
    }
    update();
  }
  EditMission(String _codeShipment) async {
    try {
      isLoading(true);
      print('code shipment $_codeShipment');
      success = await repo.EditMission(_codeShipment);
      if (success == true) {
        getAssignedShipmentController();
        Get.to(()=>AssignedShipment());

      }

      print('ani postit');
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
  getDeliveryFeesPricesController() async {
    try {
      isLoading(true);

      deliveryFees = await repo.getDeliveryFeePrices();

      if (deliveryFees != null) {
        //ListMission.addAll(mission);
        lisDeliveredFees.value = deliveryFees;
        // print(listColi.value.toString());
        // allColis.add(colis);


        print('array length :' + lisDeliveredFees.length.toString());
      } else {
        print("list Fees empty");
      }
    } catch (e) {


    } finally {
      isLoading(false);
    }
  }
  getDeliveryDefaultFeesPricesController() async {
    try {
      isLoading(true);

      deliveryDefaultFees = await repo.getDeliveryFeePrices();

      if (deliveryDefaultFees != null) {
        defaultModelFess.value = deliveryDefaultFees;
      }



    } catch (e) {


    } finally {
      isLoading(false);
    }
  }

  isFailedAttemptShipmentController() async {
    try {
      isLoading(true);
      var pref = await SharedPreferences.getInstance();









          repo.isFailedAttempt();


      print('ani postit return shipment');
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }



}