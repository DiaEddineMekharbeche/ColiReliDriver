




import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';


import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';

import 'package:colireli_delivery/UI/Dashboard.dart';
import 'package:colireli_delivery/UI/Profile.dart';
import 'package:colireli_delivery/UI/ScanBarCode.dart';
import 'package:colireli_delivery/UI/Stats.dart';
import 'package:colireli_delivery/UI/Wallet.dart';
import 'package:flutter/material.dart';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class home extends StatefulWidget {

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home>{
final controller = Get.put(ColiController());
  int index = 0 ;
  String? scanResult;


  @override
  void initState() {
//    _nameRetriever();
    controller.getOutofDeliveryShipments();
    controller.getDeliveredShipmentsController();
    controller.getFailedAttempt();
    controller.getAssignedShipmentController();
   // controller.getPaymentReportController();
    controller.getUserController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getbodyUP(),
      bottomNavigationBar: getFooter(),
      /*floatingActionButton: FloatingActionButton(
        onPressed: (){

        /*  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
          );*/
        },
        child: Icon (Icons.qr_code_scanner_rounded,size: 25),
        backgroundColor: ColiReliOrange,





      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
    );
  }
  Widget getbodyUP(){
    return IndexedStack(
        index:index,
        children:[
          Dashboard(),
          Stats(),
          Wallet(),
          Profile(),
          //ScanBarCode()
        ]
    );

  }
  Widget getFooter(){
    return BottomNavyBar(
      animationDuration: Duration(milliseconds: 300),

      showElevation: true,
      selectedIndex: index,
      onItemSelected: (index) => setState(() => this.index = index),
      items:<BottomNavyBarItem> [
        BottomNavyBarItem(
            icon: Icon(Icons.home_filled),
            title: Text('Home'.tr),
          textAlign: TextAlign.center,
          activeColor: ColiReliOrange,
          inactiveColor: Colors.black.withOpacity(0.5),
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.history),
          title: Text('History'.tr),
          textAlign: TextAlign.center,
          activeColor: ColiReliOrange,
          inactiveColor: Colors.black.withOpacity(0.5),
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.account_balance_wallet_rounded),
          title: Text('Wallet'.tr),
          textAlign: TextAlign.center,
          activeColor: ColiReliOrange,
          inactiveColor: Colors.black.withOpacity(0.5),
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'.tr),
          textAlign: TextAlign.center,
          activeColor: ColiReliOrange,
          inactiveColor: Colors.black.withOpacity(0.5),
        ),
      ],


    );

  /*  List<IconData> iconItems = [
      Icons.home_filled,
      Icons.reorder,
      Icons.account_balance_wallet_rounded,
      Icons.person
    ];
    return AnimatedBottomNavigationBar(icons:iconItems,
        activeColor: ColiReliOrange,
        splashColor: ColiReliOrange,
        inactiveColor: Colors.black.withOpacity(0.5),
        activeIndex: pageIndex!,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        iconSize: 25,
        elevation: 4,
        rightCornerRadius: 10,
        leftCornerRadius: 10,
        onTap:(index){
          setTabs(index);

        });

*/
  }
  setTabs(index){
    setState(() {
      index = index;
    });
  }




}

