
import 'dart:convert';

import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Models/Coli.dart';
import 'package:colireli_delivery/Models/DeliveryUser.dart';
import 'package:colireli_delivery/Models/Mission.dart';
import 'package:colireli_delivery/Models/Payments.dart';
import 'package:colireli_delivery/Models/Reasons.dart';

import 'package:colireli_delivery/Repo_API/AuthRepo.dart';
import 'package:colireli_delivery/UI/Dashboard.dart';
import 'package:colireli_delivery/UI/LoginUi.dart';


import 'package:colireli_delivery/UI/OutToDelivery.dart';
import 'package:colireli_delivery/UI/home.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ColiController extends GetxController {
  var allColis = <Coli>[].obs;
  var listSortieren = <Coli>[].obs;
  var listColi = <Coli>[].obs;
  var lisDeliveredColi = <Coli>[].obs;
  var ListAssignedShipment = <Coli>[].obs;
  var listFailedAttempt = <Coli>[].obs;
  var listReports = <Rapport>[].obs;
  var listColinew = <Coli>[];
  var ListMission = <Mission>[].obs;
  var listids = <int>[].obs;
  var user = User().obs;

  var reasonsList = <Reasons>[].obs;
  var reason = Reasons().obs;
  var count = 0.obs;
  bool success = false;
  var shipments;
  var deliveredColi;
  var assignedColi;
  var failedAttempt;
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
      } else {
        Get.snackbar("Starting", "Please Create a Mission to Start",
            duration: Duration(seconds: 2),
            backgroundColor: ColiReliOrange,
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

  getReasonsController() async {
    try {
      isLoading(true);

      var reasons = await repo.getReasons();

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

  returnShipmentController() async {
    try {
      isLoading(true);
      var pref = await SharedPreferences.getInstance();
      String reasonId = pref.getString('id')!;
      String missionID = pref.getString('idmission')!;
      String shipmentID = pref.getString('shipmentid')!;
       await repo.returnShipment(shipmentID, missionID, reasonId);
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
      isError(true);
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

}