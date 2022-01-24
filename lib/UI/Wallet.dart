



import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:colireli_delivery/Models/Coli.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Shipment_Card.dart';

class Wallet extends  StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final controller = Get.put(ColiController());
  String? _name = '';
  _nameRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? '';
  }
  @override
  void initState() {
    _nameRetriever();
   //controller.getPaymentReportController();
   //controller.getDetailsRaportController();

    super.initState();
  }
  Future<void> _onRefreshList() async {
    controller.getPaymentReportController();
    controller.getDetailsRaportController();

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
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      spreadRadius: 0,
                      blurRadius: 0),
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

                      Container(

                        decoration: BoxDecoration(
                          color: ColiReliOrange,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.white,
                                Colors.white
                              ],
                            )
                        ),

                        child: Padding(
                          padding: const EdgeInsets.only(right: 4,left: 4),
                          child: IconButton(onPressed: () {
                              controller.getPaymentReportController();
                              controller.getDetailsRaportController();
                          }, icon: Icon(Icons.download_outlined,size: 36,color: Colors.black,),



                          )
                        ),
                      ),

                    ],
                  ),
                ],
              ),
                ],
          ),
            ),

          ),
        Padding(
          padding: const EdgeInsets.only(top: 12,left: 8,right: 8),
          child: Container(

            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    ColiReliOrange,
                    ColiReliOrange.withOpacity(0.5),
                  ],
                )
            ),

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(


                height: size.height/5,
                width: size.width/1.2,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/wallet.png',height: 25,width: 25,color: Colors.white,),
                        Padding(
                          padding: const EdgeInsets.only(left:8),
                          child: Text("Balance".tr,style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white
                          ),),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text("Collected Amount".tr ,overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white.withOpacity(0.8),
                            ),),
                        ),
                       Obx(()=>  Text( controller.reports.value.total!=null ?'${controller.reports.value.total},00  DA'.toString() : '0,00  DA' ,style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white
                        ),)
                       ),

                      ],
                    ),
                    Row(
                      children: [
                          Obx(()=>   Text(controller.reports.value.deliveryFee !=null ?'+${controller.reports.value.deliveryFee},00  DA '.toString() : '0,00  DA   ',style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 15,color: Colors.greenAccent
                        ),),
                          ),
                        Text('Delivery Fee'.tr,style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 15,color: Colors.greenAccent
                        ),)

                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        GetX<ColiController>(
            init: ColiController(),
            builder: (controller) {
              if (controller.isLoading.value == true) {
                return Center(
                  child: CircularProgressIndicator(),

                );
              }

                return   cardCloli();



            }
        ),
      ],
    );

  }

   Widget cardCloli() {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: RefreshIndicator(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.detailsRaport.length ,
            itemBuilder: (context, i) {
              return Padding(
                padding:
                const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 2),
                child: Material(
                  color: Colors.white,
                  elevation: 3,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 2),
                        height: size.height / 9,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                          "Tracking Code:".tr,
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
                                            controller.detailsRaport[i].trackingCode!.toString(),
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
                                          "Status:".tr,
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
                                              controller.detailsRaport[i].status!
                                                  .toUpperCase(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: controller.detailsRaport[i].status! == "FAILED_ATTEMPT"? Colors.red : Colors.green,
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
                                          "Collected Amount:".tr,
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
                                            controller.detailsRaport[i].price!.toString()+",00  DA",
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
                                Container(
                                  height: size.height/15,
                                  width: size.width/80,
                                  color: controller.detailsRaport[i].status == "DELIVERED_STATUS" ? Colors.green : Colors.red,
                                )
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
