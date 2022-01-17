






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




class DeliveredShipmentDetails extends  StatefulWidget {


  ColiController controller = Get.find();

  @override
  _DeliveredShipmentDetailsState createState() => _DeliveredShipmentDetailsState();
}

class _DeliveredShipmentDetailsState extends State<DeliveredShipmentDetails> {


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
        title: Text('Delivered Shipment Details',style: TextStyle(
            fontWeight: FontWeight.bold,color: Colors.black
        ),),
      ),
      body: getBody(),

    );

  }
  Widget getBody(){
    getSharedidshipment();
    var size= MediaQuery.of(context).size;
    print(index);
    phone = controller.lisDeliveredColi[index!].reciverPhone != null ?controller.lisDeliveredColi[index!].reciverPhone:controller.lisDeliveredColi[index!].reciverPhone;



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
                            child: Text("Order",style: TextStyle(
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
                          Text(controller.lisDeliveredColi[index!].code!,style: TextStyle(
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
                          Text(controller.lisDeliveredColi[index!].shippingCost!.toString()+",00 DA",style: TextStyle(
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
                          Text('Package Cost:',style: TextStyle(
                              fontSize: 12,color: Colors.black
                          ),),
                          Text(controller.lisDeliveredColi[index!].amountToBeCollected!.toString()+',00 DA',style: TextStyle(
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
                            Text(add(controller.lisDeliveredColi[index!].amountToBeCollected!.toString(), controller.lisDeliveredColi[index!].shippingCost!.toString()).toString()+',00 DA',style: TextStyle(
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
                                        controller.lisDeliveredColi[index!] .fromAddress!.address!
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
                                    'To: ' .tr+
                                        controller.lisDeliveredColi[index!].reciverAddress!
                                            .toUpperCase(),

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
                          Text(controller.lisDeliveredColi[index!].reciverName!,style: TextStyle(
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
                          Text("Hidden".tr,style: TextStyle(
                              fontSize: 12,color: Colors.grey,
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



              ],
            ),
          )
        ],
      ),


    );
  }


  int add (String amount , String shipingCost){

    var amountInt = (controller.listColi[index!].amountToBeCollected!);
    var shipingCostInt = (controller.listColi[index!].shippingCost!);
    var add = (amountInt+shipingCostInt);

    return add;
  }





}










