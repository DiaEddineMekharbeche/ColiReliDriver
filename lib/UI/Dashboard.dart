import 'dart:async';

import 'package:badges/badges.dart';
import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:colireli_delivery/Models/Mission.dart';
import 'package:colireli_delivery/UI/AddShipments.dart';
import 'package:colireli_delivery/UI/AssignedShipment.dart';
import 'package:colireli_delivery/UI/ChoiceChipDisplay.dart';


import 'package:colireli_delivery/UI/ColiScanned.dart';
import 'package:colireli_delivery/UI/Delivered_Shipment_details.dart';
import 'package:colireli_delivery/UI/Failed_Attempt_Details.dart';
import 'package:colireli_delivery/UI/RestoreShipments.dart';
import 'package:colireli_delivery/UI/ScanBarCode.dart';
import 'package:colireli_delivery/UI/Shipment_Card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:timeline_tile/timeline_tile.dart';

import 'package:get/get.dart';

import 'home.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  final controller = Get.put(ColiController());
  int index =0  ;
  List<String> _selectedItems = [];
  String? scanResult ;

  var scanResultss;
  bool isScanned = true;
  /*_nameRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? '';
  }*/

  bool isDelivery = false;
  bool isDelivered = false;
  Timer? timer;


  @override
  void initState() {

    controller.getKeysController();

  controller.getOutofDeliveryShipments();
    controller.getFailedAttempt();
   controller.getDeliveredShipmentsController();




    super.initState();
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.05),
        floatingActionButton: SpeedDial(elevation: 4,buttonSize: 60,
          animatedIcon:  AnimatedIcons.add_event,
          backgroundColor: ColiReliOrange,
          overlayColor: Colors.black,

          overlayOpacity: 0.3,
          children: [
            SpeedDialChild(
              child: Icon (Icons.add,size: 25,color: Colors.white,),
              backgroundColor: Colors.green,
              label: 'Create Mission'.tr,
              labelBackgroundColor: Colors.white,
              onTap: (){
                Get.to(()=>ColiScanned() );
              }
            ),
            SpeedDialChild(
              child:const Icon (Icons.edit_outlined,size: 25,color: Colors.white,),
              backgroundColor: Colors.blue,
              labelBackgroundColor: Colors.white,
              label: 'Add Shipment'.tr,
              onTap: (){
                scanBarcode();
              }
            ),

          ],
          heroTag: 'btn1',




        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        body: getBody() ,


    );
  }



  Future<dynamic> _onRefreshList() async {
    return controller.getOutofDeliveryShipments();
  }



  Widget getBody() {
    var size = MediaQuery.of(context).size;



    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Container(
            //height: size.height,

            decoration: BoxDecoration(

                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      spreadRadius: 10,
                      blurRadius: 3),
                ]),
            child: Padding(
              padding: EdgeInsets.only(
                  top: size.height / 20,
                  bottom: 0,
                  right: size.width / 80,
                  left: size.width / 80),
              child: Column(
                children: [
                  //*************************************FIRST ROW TITLE**************




                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [


                                Badge(elevation: 4,borderSide: BorderSide(width: 1,color: Colors.green),

                                  position: BadgePosition.bottomEnd(bottom: 3,end:5),
                                  animationDuration: Duration(milliseconds: 300),
                                  animationType: BadgeAnimationType.slide,
                                  shape: BadgeShape.circle,
                                  badgeColor:  Colors.green ,
                                  padding: EdgeInsets.all(6),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: new Container(

                                        width: size.width/8,
                                        height: size.height/16,
                                        decoration: const BoxDecoration(

                                            shape: BoxShape.circle,
                                            image:  DecorationImage(
                                              image:  ExactAssetImage(
                                                  'assets/profile_pic.png'),
                                              fit: BoxFit.fill,
                                            ))),


                                  ),
                                ),
                                Container(

                                  width: size.width/2,

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     Obx(()=> Padding(
                                       padding: const EdgeInsets.only(left:4.0),
                                       child: Text(
                                         controller.user.value.name?? ''
                                          ,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: size.width/15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        ),
                                     ),),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [
                              IconButton(icon: Icon(Icons.restore_outlined,color: Colors.black,size: 26,),
                                  onPressed: (){
                                    Get.to(() =>RestoreShipments());
                                    controller.getAlertShipment();
                                  }),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:   1),
                                      child:Obx(()=> controller.ListAssignedShipment.length>=1?
                                      Badge(
                                        position: BadgePosition.topEnd(top: 4,end:4),
                                        animationDuration: Duration(milliseconds: 300),
                                        animationType: BadgeAnimationType.slide,
                                        shape: BadgeShape.circle,
                                        badgeColor:  Colors.red ,
                                        padding: EdgeInsets.all(6),
                                        badgeContent:Obx(()=>Text(controller.ListAssignedShipment.length.toString(),style: TextStyle(
                                          fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white
                                        ),),),
                                        child:
                                        IconButton(icon:Icon( Icons.notifications_on,color: Colors.black,

                                        ),
                                          onPressed: () {
                                            Get.to(()=>AssignedShipment());
                                            controller.getAssignedShipmentController();
                                          } ,

                                          iconSize: 34,
                                        ),

                                        ):IconButton(icon:Icon( Icons.notifications_on,color: Colors.black,size: 26,

                                      ),
                                          onPressed: () {
                                            Get.to(()=>AssignedShipment());
                                              controller.getAssignedShipmentController();
                                            } ,
                                    ),
                                      ),
                                    ),
                                  ],
                                ),


                            ],
                          ),
                        ],




                 ),



                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12, top: 12, right: 12, bottom: 8),
                    child: Material(

                      //height: size.height/8.5,
                      elevation: 4,
                      borderRadius: BorderRadius.circular(10),

                      /*decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.08),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              spreadRadius: 10,
                              blurRadius: 3),
                        ],
                      ),*/
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,top: 5,bottom: 4),
                        child: Container(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(

                                onTap: () {
                                  setState(() {
                                    index = 0;
                                    controller.getOutofDeliveryShipments();
                                    print(index);
                                  });



                                },
                               child: Container(



                                 child: Column(

                                    children: [

                                      Center(child: Icon(Icons.delivery_dining,color: ColiReliOrange,)),
                                      Center(
                                        child: Text(
                                          "Out to Deliver".tr,


                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: size.width/28,



                                              color: Colors.grey),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Obx(() => Text(
                                            '${controller.listColi.length}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                                color: ColiReliOrange),
                                          ),
                                         )


                                        ),
                                      ),
                                      Container(
                                        height: size.height/280,
                                        width: size.width/4,
                                        color: index == 0 ? Colors.green : Colors.transparent,
                                      )

                                    ],
                                  ),
                               ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8,top: 5,bottom: 5),
                                child: Container(
                                  width: size.width/300,
                                  height: size.height/10,
                                  color: Colors.black.withOpacity(0.09),
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  setState(() {
                                    index = 1;
                                    controller.getDeliveredShipmentsController();
                                    print(index);
                                  });

                                },
                                child: Container(

                                  child: Column(
                                    children: [
                                      Center(child: Icon(Icons.done_all,color: Colors.green,)),
                                      Center(
                                        child: Text(
                                          "Delivered".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: size.width/25,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child:Obx(() => Text(
                                            '${controller.lisDeliveredColi.length}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                                color: Colors.green),
                                          ),
                                          )
                                        ),
                                      ),
                                      Container(
                                        height: size.height/280,
                                        width: size.width/5,
                                        color: index == 1 ? Colors.green : Colors.transparent,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 6,top: 5,bottom: 5),
                                child: Container(
                                  width: size.width/300,
                                  height: size.height/10,
                                  color: Colors.black.withOpacity(0.09),
                                ),
                              ),
    InkWell(
    onTap: () {
    setState(() {
      controller.getFailedAttempt();
    index = 2;
    print(index);
    });

    },
                             child: Column(
                                children: [
                                  Center(child: Icon(Icons.remove_done,color: Colors.red,)),
                                  Center(
                                    child: Text(
                                      "Failed Attempt".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: size.width/31,
                                          color: Colors.grey),
                                    ),
                                  ),

                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Obx(() =>Text(
                                        '${controller.listFailedAttempt.length}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.red),
                                      ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: size.height/280,
                                    width: size.width/4,
                                    color: index == 2 ? Colors.green : Colors.transparent,
                                  )
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
          ),
        ),

             checkBody(index) ,




      /*  GetX<ColiController>(
            init: ColiController(),
            builder: (controller) {
              if (controller.isLoading.value == true) {
                return Center(
                  child: CircularProgressIndicator(),

                );
              }
              if(controller.listColi.isEmpty ){
                return cardColiEmpty();
              }else{
                return   cardCloli();
              }



            }
        ),*/




      ],
    );
  }


  Widget cardCloli() {
    var size = MediaQuery.of(context).size;
    return
      Expanded(
      child: RefreshIndicator(

          child: Obx(() => ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount:controller.listColi.length,
            itemBuilder: (context, i) {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(()=>ShipementCard() , arguments: [
                        i
                      ]);
                    },
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        height: size.height / 4.0,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                 Visibility(maintainSize: true,
                                     maintainAnimation: true,
                                     maintainState: true,
                                     visible: controller.listColi[i].statusId == 16 ? true : false,
                                     child: bannerBadge()
                                 ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    SizedBox(
                                      width: 0,
                                    ),


                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 8, top: 0),
                                      child: Image.asset(
                                        'assets/boite.png',
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
                                                color:
                                                Colors.black.withOpacity(0.5),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 5),
                                              child: Text(controller.listColi[i].code! ,
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
                                        Container(

                                          child: Row(
                                            children: [
                                              Text(
                                                "Receiver address:".tr,
                                                style: TextStyle(
                                                  color:
                                                  Colors.black.withOpacity(0.5),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(left: 5),
                                                child: Container(

                                                  width: size.width / 4.0,

                                                  child: Text(
                                                    controller.listColi[i].state!.name! +","+
                                                        controller.listColi[i].area!.name!
                                                            .toUpperCase(),

                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: size.width/30,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Container(

                                          child: Row(
                                            children: [
                                              Text(
                                                "Amount to be collected:".tr,
                                                style: TextStyle(
                                                  color:
                                                  Colors.black.withOpacity(0.5),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(left: 5),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      ((controller.listColi[i].amountToBeCollected!)+(controller.listColi[i].shippingCost!)).toString() +',00 ',


                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      "DA ".tr,
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),

                                  ],
                                ),

                              ],
                            ),


                            //*****************fin ROw*************************************+

                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                ],
                              ),
                            ),

                            Container(
                              height: 2,
                              color: Colors.black.withOpacity(0.04),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              children: [
                                TimelineTile(
                                  alignment: TimelineAlign.start,
                                  isFirst: true,
                                  beforeLineStyle: LineStyle(
                                      color: ColiReliOrange, thickness: 2),
                                  indicatorStyle: IndicatorStyle(
                                      height: 20,
                                      width: 20,
                                      padding:
                                          EdgeInsets.only(top: 3, bottom: 3),
                                      color: Colors.deepOrange,
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
                                      color: Colors.grey.withOpacity(0.05),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: size.width / 1.2,
                                            child: Text(
                                              'From: '.tr +
                                                  controller.listColi[i].fromAddress!.address!
                                                      .toUpperCase(),

                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
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
                                      color: ColiReliOrange, thickness: 2),
                                  indicatorStyle: IndicatorStyle(
                                      height: 20,
                                      width: 20,
                                      color: Colors.green,
                                      padding:
                                          EdgeInsets.only(top: 3, bottom: 0),
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
                                      color: Colors.grey.withOpacity(0.05),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: size.width / 1.2,
                                            child: Text(
                                              'To: '.tr +
                                                  controller.listColi[i].state!.name!.toUpperCase()+" , "+
                                                controller.listColi[i].area!.name!.toUpperCase()+ " , "+
                                                controller.listColi[i].reciverAddress!
                                                      .toUpperCase(),

                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
                );

            },
          ),
          ),
          onRefresh: _onRefreshList),
    );
  }
  Widget cardColiWithBadge(){
    var size = MediaQuery.of(context).size;
    return
      Expanded(
        child: RefreshIndicator(

            child: Obx(() => ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount:controller.listColi.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(()=>ShipementCard() , arguments: [
                          i
                        ]);
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          height: size.height / 4.0,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: size.height/20,
                                  ) ,



                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      SizedBox(
                                        width: 0,
                                      ),


                                      Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8, top: 0),
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
                                                  color:
                                                  Colors.black.withOpacity(0.5),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(left: 5),
                                                child: Text(controller.listColi[i].code! ,
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
                                          Container(

                                            child: Row(
                                              children: [
                                                Text(
                                                  "Receiver address:".tr,
                                                  style: TextStyle(
                                                    color:
                                                    Colors.black.withOpacity(0.5),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(left: 5),
                                                  child: Container(

                                                    width: size.width / 4.0,

                                                    child: Text(
                                                      controller.listColi[i].state!.name! +","+
                                                          controller.listColi[i].area!.name!
                                                              .toUpperCase(),

                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: size.width/30,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(

                                            child: Row(
                                              children: [
                                                Text(
                                                  "Amount to be collected:".tr,
                                                  style: TextStyle(
                                                    color:
                                                    Colors.black.withOpacity(0.5),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(left: 5),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        ((controller.listColi[i].amountToBeCollected!)+(controller.listColi[i].shippingCost!)).toString() +',00 ',


                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        "DA ".tr,
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),

                                    ],
                                  ),
                                ],
                              ),


                              //*****************fin ROw*************************************+

                              Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                  ],
                                ),
                              ),

                              Container(
                                height: 2,
                                color: Colors.black.withOpacity(0.04),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  TimelineTile(
                                    alignment: TimelineAlign.start,
                                    isFirst: true,
                                    beforeLineStyle: LineStyle(
                                        color: ColiReliOrange, thickness: 2),
                                    indicatorStyle: IndicatorStyle(
                                        height: 20,
                                        width: 20,
                                        padding:
                                        EdgeInsets.only(top: 3, bottom: 3),
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
                                        color: Colors.grey.withOpacity(0.05),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width / 1.2,
                                              child: Text(
                                                'From: '.tr +
                                                    controller.listColi[i].fromAddress!.address!
                                                        .toUpperCase(),

                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
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
                                        color: ColiReliOrange, thickness: 2),
                                    indicatorStyle: IndicatorStyle(
                                        height: 20,
                                        width: 20,
                                        color: ColiReliOrange,
                                        padding:
                                        EdgeInsets.only(top: 3, bottom: 0),
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
                                        color: Colors.grey.withOpacity(0.05),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width / 1.2,
                                              child: Text(
                                                'To: '.tr +
                                                    controller.listColi[i].state!.name!.toUpperCase()+" , "+
                                                    controller.listColi[i].area!.name!.toUpperCase()+ " , "+
                                                    controller.listColi[i].reciverAddress!
                                                        .toUpperCase(),

                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                );

              },
            ),
            ),
            onRefresh: _onRefreshList),
      );
  }

  Widget cardColiEmpty() {
    var size = MediaQuery.of(context).size;

       return RefreshIndicator(

        child: Center(
          child: Container(
            child: Column(
              children: [
                Image.asset('assets/boitevide.png',
                    height: size.height / 4, width: size.width / 5),
                Text(
                  "Please Create a Mission".tr,
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
           onRefresh: _onRefreshList);

  }

   openDialog() => Get.defaultDialog(
     title: controller.allColis[1].code!,
     titleStyle: TextStyle(fontSize: 25),
     middleText: controller.allColis[1].area!.name!,
     middleTextStyle: TextStyle(fontSize: 20),
     backgroundColor: Colors.white,
     radius: 80,
     textCancel: 'Cancel'.tr,
     cancelTextColor: Colors.deepOrange,
     textConfirm: 'Submit'.tr,
     confirmTextColor: Colors.green,
     onCancel: (){},
     onConfirm: (){},
  );

  Widget deliveredColi() {
    var size = MediaQuery.of(context).size;
    return
      Expanded(

        child: RefreshIndicator(

            child: Obx(() => ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount:controller.lisDeliveredColi.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(()=>DeliveredShipmentDetails() , arguments: [
                          i
                        ]);
                        print(i.toString());
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          height: size.height /  4.0,
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
                                    padding:
                                    const EdgeInsets.only(right: 8, top: 0),
                                    child: Image.asset(
                                      'assets/boite.png',
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
                                              color:
                                              Colors.black.withOpacity(0.5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 5),
                                            child: Text(controller.lisDeliveredColi[i].code!,
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
                                              color:
                                              Colors.black.withOpacity(0.5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 5),
                                            child: Container(
                                              width: size.width / 4.0,
                                              child: Text(
                                                controller.lisDeliveredColi[i].state!.name!.toUpperCase()+" , "+
                                                controller.lisDeliveredColi[i].area!.name!.toUpperCase() +" , "+
                                                  controller.lisDeliveredColi[i].reciverAddress!
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
                                              color:
                                              Colors.black.withOpacity(0.5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 5),
                                            child: Row(
                                              children: [
                                                Text(
                                                  ((controller.lisDeliveredColi[i].amountToBeCollected!)+(controller.lisDeliveredColi[i].shippingCost!)).toString()  +',00 ',


                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  "DA ".tr,
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
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

                              Container(
                                height: 2,
                                color: Colors.black.withOpacity(0.04),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  TimelineTile(
                                    alignment: TimelineAlign.start,
                                    isFirst: true,
                                    beforeLineStyle: LineStyle(
                                        color: ColiReliOrange, thickness: 2),
                                    indicatorStyle: IndicatorStyle(
                                        height: 20,
                                        width: 20,
                                        padding:
                                        EdgeInsets.only(top: 3, bottom: 3),
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
                                        color: Colors.grey.withOpacity(0.05),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width / 1.2,
                                              child: Text(
                                                'From: '.tr +
                                                    controller.lisDeliveredColi[i].fromAddress!.address!
                                                        .toUpperCase(),

                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
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
                                        color: ColiReliOrange, thickness: 2),
                                    indicatorStyle: IndicatorStyle(
                                        height: 20,
                                        width: 20,
                                        color: ColiReliOrange,
                                        padding:
                                        EdgeInsets.only(top: 3, bottom: 0),
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
                                        color: Colors.grey.withOpacity(0.05),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width / 1.2,
                                              child: Text(
                                                'To: '.tr +
                                                    controller.lisDeliveredColi[i].state!.name!+","+
                                                  controller.lisDeliveredColi[i].area!.name!
                                                        .toUpperCase(),

                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                );

              },
            ),
            ),
            onRefresh: _onRefreshList),
      );
  }

  Widget checkBody (int index ){
    return  GetX<ColiController>(
        init: ColiController(),
        builder: (controller) {
          if (controller.isLoading.value == true) {
            return Center(
              child: CircularProgressIndicator(),

            );
          }
          if(index == 0 ){
            if(controller.listColi.isNotEmpty){

              return cardCloli();
            }else{
              return cardColiEmpty();
            }

          }if(index == 1){
            if(controller.lisDeliveredColi.isNotEmpty){

              return deliveredColi();
            }else{
              return cardColiEmpty();
            }

          }if(index == 2){
            if(controller.listFailedAttempt.isNotEmpty){

              return failedAttempt();
            }else{
              return cardColiEmpty();
            }

          }
         else{
           return cardColiEmpty() ;
          }


        }
    );

  }

  Widget failedAttempt() {
    var size = MediaQuery.of(context).size;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return ColiReliOrange;
    }
    return
      Expanded(


        child: RefreshIndicator(


           child: Obx(() => ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount:controller.listFailedAttempt.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(()=>FailedAttempsDetails() , arguments: [
                          i
                        ]);
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          height: size.height /  4.0,
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
                                    padding:
                                    const EdgeInsets.only(right: 8, top: 0),
                                    child: Image.asset(
                                      'assets/boite.png',
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
                                              color:
                                              Colors.black.withOpacity(0.5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 5),
                                            child: Text(controller.listFailedAttempt[i].code!,
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
                                              color:
                                              Colors.black.withOpacity(0.5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 5),
                                            child: Container(
                                              width: size.width / 4.0,
                                              child: Text(
                                                controller.listFailedAttempt[i].state!.name!+","+
                                                  controller.listFailedAttempt[i].area!.name!
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
                                              color:
                                              Colors.black.withOpacity(0.5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 5),
                                            child: Row(
                                              children: [
                                                Text(
                                                  ((controller.listFailedAttempt[i].amountToBeCollected!)+(controller.listFailedAttempt[i].shippingCost!)).toString()  +',00 ',


                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  "DA ".tr,
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
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

                              Container(
                                height: 2,
                                color: Colors.black.withOpacity(0.04),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  TimelineTile(
                                    alignment: TimelineAlign.start,
                                    isFirst: true,
                                    beforeLineStyle: LineStyle(
                                        color: ColiReliOrange, thickness: 2),
                                    indicatorStyle: IndicatorStyle(
                                        height: 20,
                                        width: 20,
                                        padding:
                                        EdgeInsets.only(top: 3, bottom: 3),
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
                                        color: Colors.grey.withOpacity(0.05),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width / 1.2,
                                              child: Text(
                                                'From: '.tr +
                                                    controller.listFailedAttempt[i].fromAddress!.address!
                                                        .toUpperCase(),

                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
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
                                        color: ColiReliOrange, thickness: 2),
                                    indicatorStyle: IndicatorStyle(
                                        height: 20,
                                        width: 20,
                                        color: ColiReliOrange,
                                        padding:
                                        EdgeInsets.only(top: 3, bottom: 0),
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
                                        color: Colors.grey.withOpacity(0.05),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width / 1.2,
                                              child: Text(
                                                'To: '.tr +
                                                    controller.listFailedAttempt[i].state!.name!.toUpperCase()+" , "+
                                                  controller.listFailedAttempt[i].area!.name! +" , "+
                                                  controller.listFailedAttempt[i].reciverAddress!.toUpperCase()
                                                        .toUpperCase(),

                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                );

              },
            ),
            ),
            onRefresh: _onRefreshList),

      );

  }

  Widget bannerBadge(){
    var size = MediaQuery.of(context).size;
    return    ClipRRect(

      child: Banner(textStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
        location: BannerLocation.topEnd,
        message: "Alert".tr,
        color: Colors.red,
        child: Container(
          height: size.height/12,
        ),

      ),
    );
  }
  Future<void> scanBarcode() async{

    try{

      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', "Cancel".tr, true, ScanMode.BARCODE);

    }on PlatformException{
      scanResult= 'Failed to get platform version.';
    }

    print(scanResult);
    if(scanResult != "-1"){
      openDialogEdit(scanResult!);
    }else{
      print(scanResult);
    }




  }


  openDialogEdit(String code) => Get.defaultDialog(buttonColor: Colors.transparent,
    title: 'Confirmation',
    titleStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),
    middleText: 'Are you sure to add this shipment to your mission ?'.tr+code,
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

        controller.EditMission(code);
        Get.back();

        // controller.getFailedAttempt();


      });


    },

  );


}
