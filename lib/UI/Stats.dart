import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:colireli_delivery/Models/day_month.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Shipment_Card.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final controller = Get.put(ColiController());
  String? _name = '';
  int activeDAy = 0;
  _nameRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? '';
  }
  Future<void> _onRefreshList() async {
    return controller.getColiController('COLI0000019');
  }

  @override
  void initState() {
    _nameRetriever();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.05),
        body: getBody());
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Container(
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
                  bottom: 8,
                  right: size.width / 80,
                  left: size.width / 80),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: new Container(
                                  width: size.width/6,
                                  height: size.height/12,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: new ExactAssetImage(
                                            'assets/profile_pic.png'),
                                        fit: BoxFit.fill,
                                      ))),
                            ),
                            Container(
                              width: size.width/2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.user.value.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: size.width/15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [


                        ],
                      ),
                    ],
                  ),
                  //*********************************first Tile*************************************
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, right: 12, left: 12, bottom: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.08),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(days.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                activeDAy = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 5, right: 4, left: 4, top: 5),
                              child: Container(
                                width: size.width / 5,
                                child: Column(
                                  children: [
                                    Container(
                                      width: size.width,
                                      height: size.height / 25,
                                      decoration: BoxDecoration(
                                          color: activeDAy == index
                                              ? Colors.white
                                              : Colors.transparent,
                                          shape: BoxShape.rectangle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.05),
                                                spreadRadius: 10,
                                                blurRadius: 5),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: activeDAy == index
                                                  ? Colors.white
                                                  : Colors.transparent)),
                                      //whyyyyyyyyyyyyyyyyyyyyyyyyyyy another child
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Text(
                                            days[index]['label'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: activeDAy == index
                                                  ? ColiReliOrange
                                                  : Colors.grey,
                                              fontWeight: FontWeight.bold,
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
                        }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12, top: 8, right: 12, bottom: 1),
                    child: Material(
                      //height: size.height/8.5,
                      elevation: 2,
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
                        padding: const EdgeInsets.only(left: 14,right: 10,top: 5,bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Center(child: Icon(Icons.delivery_dining,color: ColiReliOrange,)),
                                Center(
                                  child: Text(
                                    "All Shipments".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: size.width/26,
                                        color: Colors.grey),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child:  Obx(() => Text(
    '${controller.listColi.length}',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    color: ColiReliOrange),
    ),
                                  ),
                                ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0,top: 5,bottom: 5),
                              child: Container(
                                width: size.width/300,
                                height: size.height/10,
                                color: Colors.black.withOpacity(0.09),
                              ),
                            ),
                            Column(
                              children: [
                                Center(child: Icon(Icons.done_all,color: Colors.green,)),
                                Center(
                                  child: Text(
                                    "Delivered".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize:size.width/23,
                                        color: Colors.grey),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Obx(() => Text(
                                      '${controller.lisDeliveredColi.length}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: ColiReliOrange),
                                    ),
                                    )
                                  ),
                                ),

                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0,top: 5,bottom: 5),
                              child: Container(
                                width: size.width/300,
                                height: size.height/10,
                                color: Colors.black.withOpacity(0.09),
                              ),
                            ),
                            Column(
                              children: [
                                Center(child: Icon(Icons.remove_done,color: Colors.red,)),
                                Center(
                                  child: Text(
                                    "Not Delivered".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: size.width/23,
                                        color: Colors.grey),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child:  Obx(() =>Text(
                                      '${controller.listFailedAttempt.length}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.red),
                                    ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        //**********************************************************end stats**************************
        cardCloli(),
      ],
    );
  }

  Widget cardCloli() {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: RefreshIndicator(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.lisDeliveredColi.length,
            itemBuilder: (context, i) {
              return Padding(
                padding:
                const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 2),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: GestureDetector(
                    onTap: () {
                      Get.snackbar(""
                          "Information", "This Shipment is already delivered",duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(bottom: 20,left: 20,right: 20));
                    },
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
                                          "Oder Id:",
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
                                          child: Text(
                                            controller.lisDeliveredColi[i].code!,
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
                                          "Receiver address:",
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
                                            width: size.width / 2.5,
                                            child: Text(
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
                                          "Total Payment:",
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
                                          child: Text(
                                            controller.lisDeliveredColi[i]
                                                .amountToBeCollected!.toString() +
                                                ' DA',
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
          onRefresh: _onRefreshList),
    );
  }
}
