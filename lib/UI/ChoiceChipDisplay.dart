


import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:colireli_delivery/Models/Reasons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
class ChoiceChipDisplay extends StatefulWidget {


  @override
  _ChoiceChipDisplayState createState() => _ChoiceChipDisplayState();
}

class _ChoiceChipDisplayState extends State<ChoiceChipDisplay> {
  ColiController controller = Get.find();
  String? valueChoose ;

 late String idReason="";
  late String missionID="";
  late String shipmentID ="";


  List<String> chipList = [
    "receiver",
    "order",
    "sender\r\n",
  ];





  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    // TODO: implement build
    return

      Material(
        color: Colors.white,
        elevation: 14.0,
        borderRadius: BorderRadius.circular(24.0),
        shadowColor: Color(0x802196F3),
        child: Container(
          width: size.width,
          height: size.height/2,
          child: Column(
            children: <Widget>[
              Container(
                height: size.height/15,
                width: MediaQuery.of(context).size.width,
                //color: new Color(0xffffc107),
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(12.0),
                  color: Color(0xffffc107),
                ),
                child: Center(
                  child: Text(
                    'Reasons'.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            /*  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    'Choose the Reason please',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child:Padding(
                    padding: const EdgeInsets.all(14),
                    child: Container(
                      padding: EdgeInsets.only(left: 16,right: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 1),
                        borderRadius: BorderRadius.circular(15)
                      ),

                      child: DropdownButton(
                        underline: SizedBox(),
                        hint: Text('Select the key of reason'.tr,style: TextStyle(
                          fontSize: 16,fontWeight: FontWeight.normal
                        ),),
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        value: valueChoose,
                        isExpanded: true,
                        style: TextStyle(
                          color:Colors.black,
                          fontSize: 16,fontWeight: FontWeight.bold
                        ),
                        onChanged: (newValue){
                          setState(() {
                            valueChoose = newValue.toString();
                          });
                        },
                        items: chipList.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),


                      ),
                    ),
                  )

                ),
              ),
              Container(
                  height: size.height/10,
                  child: Wrap(
                    spacing: 0.0,
                    runSpacing: 0.0,
                    children: <Widget>[
                      choiceChipWidget(controller.reasonsList),


                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top:25.0),
                child: Center(
                  child: Container(
                    child: RaisedButton(
                        color: Color(0xffffbf00),
                        child: new Text(
                          'Submit'.tr,
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          print('clicked');
                          getREsaonId().then((result){
                            idReason = result;
                            print("converteddd"+idReason);
                          });
                          getShimpentId().then((result){
                            shipmentID = result;
                            print("converteddd"+shipmentID);
                          });
                          getMissionId().then((result){
                            missionID = result;
                            print("converteddd"+missionID);
                          });


                       setState(() {
                         controller.returnShipmentController();
                         controller.getFailedAttempt();
                         controller.getOutofDeliveryShipments();
                         Get.offAll(()=>home());
                       });


                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0) )

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

    );
  }
  getREsaonId()async{
    var pref = await SharedPreferences.getInstance();
   String reasonId =  pref.getString('id')!;
    print('resaonID:$reasonId');
    return pref.getString('id')!;
  }
  getMissionId()async{
    var pref = await SharedPreferences.getInstance();
     String missionID =  pref.getString('idmission')!;
    print('idmission:$missionID');
    return missionID;
  }
  getShimpentId()async{
    var pref = await SharedPreferences.getInstance();
     String shipmentID =  pref.getString('shipmentid')!;
    print('idshipment:$shipmentID');
    return shipmentID;
  }
}

class choiceChipWidget extends StatefulWidget {
  ColiController controller = Get.find();
  final List<Reasons> reportList;



  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  ColiController controller = Get.find();
  Reasons selectedChoice = Reasons();
  String? valueChoose ;

  List<String> chipList = [
    "receiver",
    "order",
    "sender\r\n",
  ];


  _buildChoiceList() {

    var size = MediaQuery.of(context).size;
    var choices = <Widget>[];
    var receiverList=  controller.reasonsList.where((i) => i.key =='receiver'&& i.type == 'failed_attempt') .toList();
    print(receiverList.length);

    receiverList.forEach((item) {
      choices.add( SingleChildScrollView(
        child: Container(

          padding: const EdgeInsets.all(2.0),
          child: ChoiceChip(
            label: Text(item.name!),
            labelStyle: TextStyle(
                color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            backgroundColor: Color(0xffededed),

            selectedColor: Color(0xffffc107) ,
            selected: selectedChoice == item,
            onSelected: (selected) {
              setState(() {
                print(item);
                selectedChoice = item ;

                print(selectedChoice.name);
                print(selectedChoice.id.toString());
                getShared(selectedChoice.id!.toString());

              });
            },
          ),

        ),



      )
      );
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
   return GetX<ColiController>(
        init: ColiController(),
        builder: (controller) {
          if (controller.isLoading.value == true) {
            return Center(
              child: CircularProgressIndicator(),

            );
          }

            return




                Center(
                  child: Wrap(
                    children:  _buildChoiceList(),


                  ),
                );





        }
    );



  }
    getShared (String data)async{
     var pref = await SharedPreferences.getInstance();
     await pref.setString("id", data);
     print('shared store succee');
        return "success" ;
   }
}