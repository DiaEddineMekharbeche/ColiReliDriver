




import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';

class RestoreShipments extends StatefulWidget {
  @override
  _RestoreShipmentsState createState() => _RestoreShipmentsState();
}

class _RestoreShipmentsState extends State<RestoreShipments> {
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
          'Restore Shipments '.tr,
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
                if (controller.listAlert.isEmpty) {
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
                    controller.postRestoreShipmentsController(_selectedItems.toString(),
                        controller.listAlert[0].missionId!.toString());
                    print(controller.listAlert[0].missionId);
                    _selectedItems.clear();
                    controller.getFailedAttempt();
                    controller.getOutofDeliveryShipments();
                  //  Get.offAll(()=>home(),duration: Duration(seconds: 1));
                    Get.back();
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
        itemCount: controller.listAlert.length,
        itemBuilder: (context, i) {
          return Padding(
            padding:
            const EdgeInsets.only(left: 4, right: 4, bottom: 6, top: 2),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(

                  padding:
                  EdgeInsets.only(left: 10, right: 8, top: 10, bottom: 10),
                  height: size.height / 7.3,
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
                            padding: const EdgeInsets.only(right: 6, top: 0),
                            child: Image.asset(
                              'assets/boite.png',
                              height: size.height / 18,
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
                                    child: Container(

                                      child: Text(
                                        controller.listAlert[i].code!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
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

                                      width: size.width / 4.0,
                                      child: Text(
                                        controller.listAlert[i]
                                            .state!.name!+","+controller.listAlert[i].area!.name!
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
                                    child: Row(
                                      children: [
                                        Container(

                                          child: Text(
                                            (controller.listAlert[i]
                                                .amountToBeCollected!).toString() +
                                                ',00 ',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(

                                          child: Text(
                                            "DA ".tr,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
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
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value:controller.listAlert[i].isSelected  ,
                            onChanged: (bool? value) {
                              setState(() {
                                print(value.toString());
                                controller.listAlert[i].isSelected = value!;
                                print(controller.listAlert[i].isSelected.toString());
                                if(controller.listAlert[i].isSelected == true){
                                  _selectedItems.add(controller.listAlert[i].id!.toString());
                                }
                                if(controller.listAlert[i].isSelected == false){
                                  _selectedItems.remove(controller.listAlert[i].id!.toString());
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
                "Failed Attempt Shipments".tr,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.grey),
              ),
              Text(
                " List is Empty !".tr,
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
