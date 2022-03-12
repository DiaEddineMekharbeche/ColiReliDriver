import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:colireli_delivery/Repo_API/AuthRepo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'Shipment_Card.dart';

class ColiScanned extends StatefulWidget {
  @override
  _ColiScannedState createState() => _ColiScannedState();
}

class _ColiScannedState extends State<ColiScanned> {
  final controller = Get.put(ColiController());
  var repo = AuthRepo();
  late List<int> listids = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn5',
        onPressed: () {
          controller.scanBarcode();
        },
        child: Icon(Icons.qr_code_scanner_rounded, size: 25),
        backgroundColor: ColiReliOrange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        elevation: 4,
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.solidTrashAlt,
              color: Colors.black,
              size: 26,
            ),
            color: Colors.black,
            iconSize: 30,
            onPressed: () {
              if (controller.allColis.isNotEmpty) {
                openDialogDelete();
              } else {
                Get.snackbar("Information".tr, "the List is already Empty!".tr,
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.only(bottom: 20, left: 20, right: 20));
              }
            },
          )
        ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Create Mission'.tr,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          GetX<ColiController>(
              init: ColiController(),
              builder: (controller) {
                if (controller.isLoading.value == true) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.allColis.isEmpty) {
                  return cardColiEmpty();
                } else {
                  return cardCloli();
                }

                /* if (controller.allColis.isNotEmpty) {
                return cardCloli();
            } else {

              return cardColiEmpty();
            }*/
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Validate".tr.toUpperCase(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.green)))),
                onPressed: () {
                  if (controller.allColis.isNotEmpty) {
                    openDialog();
                  } else {
                    Get.snackbar("Error".tr, "List is Empty Please Scan!".tr,
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin:
                            EdgeInsets.only(bottom: 20, left: 20, right: 20));
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget cardCloli() {
    var size = MediaQuery.of(context).size;

    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.allColis.length,
        itemBuilder: (context, i) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 2),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    height: size.height / 9,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8, top: 0),
                              child: Image.asset(
                                'assets/boxBlueFill.png',
                                height: size.height / 15,
                                width: size.width / 10,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order Id:".tr,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        controller.allColis[i].code!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                    // Icon(Icons.keyboard_arrow_right_sharp,size: 20,color: ColiReliOrange,),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Receiver address:".tr,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Container(
                                        width: size.width / 4.0,
                                        child: Text(
                                          controller.allColis[i].state!.name!+","+controller.allColis[i].area!.name!
                                              .toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Amount to be collected:".tr,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        (controller.allColis[i]
                                            .amountToBeCollected!)
                                                .toString() +
                                            ',00 DA',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(
                              Icons.keyboard_arrow_right_sharp,
                              size: 35,
                              color: ColiReliOrange,
                            ),
                          ],
                        ),
                        //*****************fin ROw*************************************+

                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget cardColiEmpty() {
    var size = MediaQuery.of(context).size;

    return Expanded(
      child: Center(
        child: Container(
          child: Column(
            children: [
              Image.asset('assets/empty.png',
                  height: size.height / 4, width: size.width / 5),
              Text(
                "Please Scan the Courier".tr,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.grey),
              ),
              Text(
                "to start!".tr,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openDialog() => Get.defaultDialog(
        buttonColor: Colors.transparent,
        title: 'Confirmation',
        titleStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        middleText: 'Are you sure to Validate this List ?'.tr,
        middleTextStyle: TextStyle(fontSize: 14),
        backgroundColor: Colors.white,
        radius: 20,
        textCancel: 'Cancel'.tr,
        cancelTextColor: Colors.deepOrange,
        barrierDismissible: true,
        textConfirm: 'Confirm'.tr,
        confirmTextColor: Colors.green,
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          print(controller.allColis.length);
          controller.getValidationController();
          Get.back();
        },
      );
  openDialogDelete() => Get.defaultDialog(
        buttonColor: Colors.transparent,
        title: 'Delete'.tr,
        titleStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        middleText: 'Are you sure to Delete this List ?'.tr,
        middleTextStyle: TextStyle(fontSize: 14),
        backgroundColor: Colors.white,
        radius: 20,
        textCancel: 'No'.tr,
        cancelTextColor: Colors.deepOrange,
        barrierDismissible: true,
        textConfirm: 'Yes'.tr,
        confirmTextColor: Colors.green,
        onCancel: () {},
        onConfirm: () {
          print(controller.allColis.length);
          controller.allColis.clear();
          Get.back();

          Get.snackbar("Success".tr, "All Shipments are Canceled".tr,
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.only(bottom: 20, left: 20, right: 20));
        },
      );
}
