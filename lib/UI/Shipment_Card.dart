



import 'dart:ui';

import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';

import 'package:colireli_delivery/Models/Coli.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ChoiceChipDisplay.dart';
import 'home.dart';




class ShipementCard extends  StatefulWidget {


ColiController controller = Get.find();

  @override
  _ShipementCardState createState() => _ShipementCardState();
}

class _ShipementCardState extends State<ShipementCard> {


  final controller = Get.put(ColiController());
  int? index = Get.arguments[0];
  String? phone;
  String newValue = "receiver";

  String? scanResult ;

  getSharedidshipment ()async{
    var pref = await SharedPreferences.getInstance();
    await pref.setString("shipmentid", controller.listColi[index!].id!.toString());
    print('shared store succeen shipment');
    return "success" ;
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 4,
        titleSpacing: 0,
        iconTheme: IconThemeData(
          color:Colors.black
        ),
        backgroundColor: Colors.white,
        title: Text('Order Detail'.tr,style: TextStyle(
          fontWeight: FontWeight.bold,color: Colors.black
        ),),
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton.extended(elevation: 8,


        onPressed: () {
         // UrlLauncher.launch('tel:$phone');
          //print(phone!);
           _makePhoneCall('tel:$phone');




        },
        label:  Text('Call Client'.tr,style: TextStyle(
          fontSize: 15,fontWeight: FontWeight.bold
        ),),
        icon: Icon (Icons.phone,size: 25),
        backgroundColor: Colors.redAccent,








      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

  }
  Widget getBody(){
    getSharedidshipment();
    var size= MediaQuery.of(context).size;
    print(index);
    phone = controller.listColi[index!].reciverPhone != null ?controller.listColi[index!].reciverPhone:controller.lisDeliveredColi[index!].reciverPhone;



    return SingleChildScrollView(

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: size.height/4,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 10,
                        blurRadius: 3),
                  ]),
              child: Column(


                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColiReliOrange,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Order".tr,style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,

                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.height/500,
                    width: size.width,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey.withOpacity(0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order Id:'.tr,style: TextStyle(
                              fontSize: 12,color: Colors.black
                          ),),
                          Text(controller.listColi[index!].code!,style: TextStyle(
                              fontSize: 12,color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey.withOpacity(0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Shipping Cost:'.tr,style: TextStyle(
                              fontSize: 12,color: Colors.black
                          ),),
                          Text(controller.listColi[index!].shippingCost!.toString()+",00 DA",style: TextStyle(
                              fontSize: 12,color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey.withOpacity(0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Package Cost:'.tr,style: TextStyle(
                              fontSize: 12,color: Colors.black
                          ),),
                          Text(controller.listColi[index!].amountToBeCollected!.toString()+',00 DA',style: TextStyle(
                              fontSize: 12,color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: ColiReliOrange.withOpacity(0.03),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text('Amount to be collected:'.tr,style: TextStyle(
                                fontSize: 12,color: Colors.red
                            ),),
                            Text(add(controller.listColi[index!].amountToBeCollected!.toString(), controller.listColi[index!].shippingCost!.toString()).toString()+',00 DA',style: TextStyle(
                                fontSize: 12,color: Colors.red,
                                fontWeight: FontWeight.bold
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //*****************************************************first box*****************
          Padding(
            padding: const EdgeInsets.only(top:0,left: 20,right: 20),
            child: Container(
              height: size.height/5.5,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 10,
                        blurRadius: 3),
                  ]),
              child: Column(


                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColiReliOrange,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Location".tr,style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,

                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.height/500,
                    width: size.width,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TimelineTile(
                          alignment: TimelineAlign.start,
                          isFirst: true,
                          beforeLineStyle: LineStyle(
                              color: ColiReliOrange,
                              thickness: 2),
                          indicatorStyle: IndicatorStyle(
                              height: 20,
                              width: 20,
                              padding: EdgeInsets.only(
                                  top: 3, bottom: 3),
                              color: ColiReliOrange,
                              iconStyle: IconStyle(
                                  iconData: Icons.check_box,
                                  color: Colors.white)),
                          endChild: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, top: 5, bottom: 5),
                            child: Container(
                              height: 25,
                              width: 30,
                              constraints: BoxConstraints(
                                minHeight: 5,
                              ),
                              color:
                              Colors.grey.withOpacity(0.08),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'From: '.tr +
                                        controller.listColi[index!] .fromAddress!.address!
                                            .toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight:
                                        FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.start,
                          isLast: true,
                          beforeLineStyle: LineStyle(
                              color: ColiReliOrange,
                              thickness: 2),
                          indicatorStyle: IndicatorStyle(
                              height: 20,
                              width: 20,
                              color: ColiReliOrange,
                              padding: EdgeInsets.only(
                                  top: 3, bottom: 0),
                              iconStyle: IconStyle(
                                  iconData: Icons.location_pin,
                                  color: Colors.white)),
                          endChild: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 0, left: 8),
                            child: Container(
                              height: 25,
                              width: 30,
                              constraints: BoxConstraints(
                                minHeight: 10,
                              ),
                              color:
                              Colors.grey.withOpacity(0.08),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'To: '.tr +
                                        controller.listColi[index!].reciverAddress!
                                            .toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight:
                                        FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          //******************************************second box********************
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: size.height/6.5,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 10,
                        blurRadius: 3),
                  ]),
              child: Column(


                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColiReliOrange,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Customer".tr,style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,

                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.height/500,
                    width: size.width,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey.withOpacity(0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name:'.tr,style: TextStyle(
                              fontSize: 12,color: Colors.black
                          ),),
                          Text(controller.listColi[index!].reciverName!,style: TextStyle(
                              fontSize: 12,color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey.withOpacity(0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Mobile Number:'.tr,style: TextStyle(
                              fontSize: 12,color: Colors.black
                          ),),
                          Text(controller.listColi[index!].reciverPhone!,style: TextStyle(
                              fontSize: 12,color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
          //*******************************************third**************************


          Padding(
            padding: const EdgeInsets.only(left:20,right: 20,top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(style: ButtonStyle(elevation: MaterialStateProperty.all(0),
                  overlayColor:MaterialStateProperty.all(Colors.red) ,

                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: ColiReliOrange)


                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                  onPressed:(){
                    controller.getReasonsController();

                    Get.bottomSheet(

                        Container(
                          height: size.height/1,
                          width: size.width,


                          child:Wrap(
                            children: [

                              ChoiceChipDisplay()


                            ],
                          )  ,
                        ),
                        backgroundColor:Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        )
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Canceled'.tr,style: TextStyle(
                        color: ColiReliOrange,fontWeight: FontWeight.bold,fontSize: 18
                    ),),
                  ),

                ),
                ElevatedButton(style: ButtonStyle(elevation: MaterialStateProperty.all(4),
                  overlayColor:MaterialStateProperty.all(Colors.green) ,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),

                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ) ,
                  onPressed:(){
                   scanBarcode();



                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('  Deliver  '.tr,style: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18,
                    ),),
                  ),

                ),

              ],
            ),
          )
        ],
      ),


    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  int add (String amount , String shipingCost){

    var amountInt = (controller.listColi[index!].amountToBeCollected!);
    var shipingCostInt = (controller.listColi[index!].shippingCost!);
    var add = (amountInt+shipingCostInt);

    return add;
  }

  Future<void> scanBarcode() async{

    try{

      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', "Cancel".tr, true, ScanMode.BARCODE);
    }on PlatformException{
      scanResult= 'Failed to get platform version.';
    }

    print(scanResult);

    checkCode(scanResult!);



  }

  checkCode(String result){
    if(result == controller.listColi[index!].code!){
      openDialog();
    }else{
      Get.snackbar("Error", "invalid shipment please try again!".tr,duration: Duration(seconds: 4),
          backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
    }
  }
  openDialog() => Get.defaultDialog(buttonColor: Colors.transparent,
    title: 'Confirmation',
    titleStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),
    middleText: 'Are you sure that this shipment is Delivered ?'.tr,
    middleTextStyle: TextStyle(fontSize: 14),
    backgroundColor: Colors.white,
    radius: 20,
    textCancel: 'Cancel'.tr,
    cancelTextColor: Colors.deepOrange,
    barrierDismissible: true,
    textConfirm: 'Confirm'.tr,
    confirmTextColor: Colors.green,

    onCancel: (){
      Get.back();
    },
    onConfirm: () {
    setState(() {
      controller.DeliveredController(controller.listColi[index!].id!.toString(), controller.listColi[index!].missionId!.toString());
      controller.getDeliveredShipmentsController();
      controller.getOutofDeliveryShipments();
     // controller.getFailedAttempt();

      Get.offAll(()=>home());
    });


    },

  );

}










