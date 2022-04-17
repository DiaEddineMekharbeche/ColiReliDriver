import 'package:colireli_delivery/Constants/Constants.dart';

import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:colireli_delivery/Models/Mission.dart';
import 'package:colireli_delivery/UI/Dashboard.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';

class OutToDelivery extends StatefulWidget {
  @override
  _OutToDeliveryState createState() => _OutToDeliveryState();
}

class _OutToDeliveryState extends State<OutToDelivery> {
  final controller = Get.put(ColiController());
  bool _checked = false;
  String? selectedValue;
  List<String> _selectedItems = [];
  List<bool> _selected = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selected = List<bool>.filled(controller.ListMission.length, false);


  }

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
          'Out to Deliver'.tr,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
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
                if (controller.ListMission.isEmpty) {
                  return cardColiEmpty();
                } else {
                  return cardCloli();
                }
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Done".toUpperCase().tr,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                  setState(() {
                    controller.postOutOfDElivery(_selectedItems.toString(),
                        controller.ListMission[0].missionId!.toString());
                    print(controller.ListMission[0].missionId);
                    _selectedItems.clear();
                   // controller.getOutofDeliveryShipments();
                    controller.getAssignedShipmentController();
                   // Get.offAll(()=>home(),duration: Duration(seconds: 1));
                  });

                }),
          )
        ],
      ),
    );
  }

  Widget cardCloli() {
    var size = MediaQuery.of(context).size;
    bool isSelected;
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

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.ListMission.length,
        itemBuilder: (context, i) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 2),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                  padding:
                      EdgeInsets.only(left: 5, right: 2, top: 10, bottom: 10),
                  height: size.height / 8,
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
                            child:  Image.asset(
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
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      controller.ListMission[i].shipment!.code!,
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
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Container(

                                      width: size.width / 5.0,
                                      child: Text(
                                        controller.ListMission[i].shipment!
                                            .reciverAddress!
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
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      controller.ListMission[i].shipment!
                                              .amountToBeCollected!.toString()+
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
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value:controller.ListMission[i].isSelected ,
                            onChanged: (bool? value) {
                              setState(() {
                                print(value.toString());
                                controller.ListMission[i].isSelected = value!;
                                print(controller.ListMission[i].isSelected.toString());
                                if(controller.ListMission[i].isSelected == true){
                                  _selectedItems.add(controller.ListMission[i].shipmentId!.toString());
                                }
                                if(controller.ListMission[i].isSelected == false){
                                  _selectedItems.remove(controller.ListMission[i].shipmentId!.toString());
                                }
                                print(_selectedItems.toString());

                              });
                            },
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
              Image.asset('assets/boitevide.png',
                  height: size.height / 4, width: size.width / 5),
              Text(
                "List is Empty".tr,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.grey),
              ),
              Text(
                "Create a mission to start!".tr,
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

  void itemChange(bool val, int index) {
    setState(() {
      _selected[index] = val;
    });
  }
}
