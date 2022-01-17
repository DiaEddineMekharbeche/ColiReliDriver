

import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:get/get.dart';


import 'home.dart';

class ScanBarCode extends  StatefulWidget {
  @override
  _ScanBarCodeState createState() => _ScanBarCodeState();
}

class _ScanBarCodeState extends State<ScanBarCode> {
  final controller = Get.put(ColiController(), tag: "ctrl");
  String? scanResult;

  @override
  void initState() {
   scanBarcode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Material(
      child: showDialogFunc(context, controller) ,
    );
  }
  Future<void> scanBarcode() async{
    String? scanResult ;
    try{
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', "Cancel", true, ScanMode.BARCODE);
    }on PlatformException{
      scanResult= 'Failed to get platform version.';
    }
    if(!mounted) return ;
    setState(() => this.scanResult= scanResult);

  }

  showDialogFunc(context,ColiController controller){
    var size = MediaQuery.of(context).size;
    return showDialog(barrierDismissible: true,useRootNavigator: true,
        context: context,
        builder: (context){
          return Center(
            child:
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Material(
                    color: Colors.white,
                    elevation: 3,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              height: size.height / 4.7,
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
                                                  controller.allColis[0].code!,
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
                                                    controller
                                                        .allColis[0].reciverAddress!
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
                                                  (controller.allColis[0]
                                                      .amountToBeCollected!).toString() +
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
                                                    'From: ' +
                                                        controller.allColis[0]
                                                            .fromAddress!.address!
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
                                                    'To: ' +
                                                        controller.allColis[0]
                                                            .reciverAddress!
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
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
