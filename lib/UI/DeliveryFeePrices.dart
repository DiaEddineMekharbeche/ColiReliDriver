




import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';

class DeliveryFeePrices extends StatefulWidget  {
  @override
  _DeliveryFeePricesState createState() => _DeliveryFeePricesState();
}

class _DeliveryFeePricesState extends State<DeliveryFeePrices> {
  final controller = Get.put(ColiController());
  bool _checked = false;
  String? selectedValue;
  List<String> _selectedItems = [];
  List<bool> _selected = [];
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
          'Delivery fee prices'.tr,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: getBody(),
    );
  }
  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10,right: 0,left: 0),
      child: Column(
        children: [
          Row(
            children: [
              Material(
                elevation: 2,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                    padding:
                    EdgeInsets.only(left: 25, right: 15, top: 10, bottom: 10),
                    height: size.height / 10,
                    width: size.width,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.01),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Area'.tr,style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black,
                        ),),
                        Text('Return Fees'.tr,style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black,
                        ),),
                        Text('Delivery Fees'.tr,style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black,
                        ),),


                        //*****************fin ROw*************************************+


                      ],
                    )),
              ),
            ],
          ),
          GetX<ColiController>(
              init: ColiController(),
              builder: (controller) {
                if (controller.isLoading.value == true) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.lisDeliveredFees.isEmpty) {
                  return cardDEfaultCloli();
                } else {
                  return cardCloli();
                }



              }),
          
        ],
      ),
    );
  }
  Widget cardCloli() {
    var size = MediaQuery.of(context).size;
    bool isSelected;


    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.lisDeliveredFees.length,
        itemBuilder: (context, i) {
          return Padding(
            padding:
            const EdgeInsets.only(left: 0, right: 0, bottom: 8, top: 2),
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                  padding:
                  EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                  height: size.height / 18,
                  width: size.width,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(controller.lisDeliveredFees[i].area!.name ?? 'Unknown Area',style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal,color: Colors.black,
                          ),),
                        ],
                      ),

                          Row(
                            children: [
                              Text(controller.lisDeliveredFees[i].returnFee!.toString()+" ",style: TextStyle(
                                  fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red.shade200
                              ), ),
                              Text("DA ".tr,style: TextStyle(
                                  fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red.shade200
                              ), ),
                            ],
                          ),

                          Row(
                            children: [
                              Text(controller.lisDeliveredFees[i].deliveryFee!.toString()+" ",style: TextStyle(
                                fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green
                              ), ),
                              Text("DA ".tr,style: TextStyle(
                                  fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green
                              ), ),
                            ],
                          ),



                      
                      //*****************fin ROw*************************************+

                     
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
  Widget cardDEfaultCloli() {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding:
      const EdgeInsets.only(left: 0, right: 0, bottom: 8, top: 2),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
            padding:
            EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
            height: size.height / 18,
            width: size.width,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('All'.tr,style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal,color: Colors.black,
                    ),),
                  ],
                ),

                Row(
                  children: [
                    Text(controller.defaultModelFess.value.deliveryFee.toString(),style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red.shade200
                    ), ),
                    Text("DA ".tr,style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red.shade200
                    ), ),
                  ],
                ),

                Row(
                  children: [
                    Text(controller.defaultModelFess.value.returnFee.toString(),style: TextStyle(
                        fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green
                    ), ),
                    Text("DA ".tr,style: TextStyle(
                        fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green
                    ), ),
                  ],
                ),




                //*****************fin ROw*************************************+


              ],
            )),
      ),
    );
  }
}
