


import 'dart:async';

import 'package:colireli_delivery/Constants/Constants.dart';
import 'package:colireli_delivery/Controller/ColiCntroller.dart';
import 'package:colireli_delivery/Controller/LocalStorage.dart';
import 'package:colireli_delivery/Models/Reasons.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
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
  @override
  void initState() {

    //FlutterBackgroundService.initialize(gettimer());

    controller.getKeysController();

    super.initState();
  }
  ColiController controller = Get.find();
  String? valueChoose ;
  final TextEditingController? _Textcontroller = TextEditingController();
 late String idReason="";
  late String missionID="";
  late String shipmentID ="";
  var chipList2;

  List<String> fakelist = [
    "sender",
    "receiver",
    "order",
    "shipment",
    "shipment ",
    "driver",
    "other_due",
    "other_refund",
  ];






  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var chipList = controller.reasonsList.where((i) => i.key == "receiver" ).toList();

    // TODO: implement build
    return

      Material(
        color: Colors.white,
        elevation: 14.0,
        borderRadius: BorderRadius.circular(24.0),
        shadowColor: Color(0x802196F3),
        child: Container(
          width: size.width,
          height: size.height/1,
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
                            controller.getReasonsController(valueChoose!);
                            print(valueChoose);

                          });
                        },
                        items: controller.listKeys.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem.translation,
                            child: Text(valueItem.translation.toString()),
                          );
                        }).toList(),


                      ),
                    ),
                  )

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 22,left: 22),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),

                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              spreadRadius: 10,
                              blurRadius: 4),
                        ]),

                    height: size.height/3,
                    child: SingleChildScrollView(

                      child:
                        choiceChipWidget(controller.reasonsList),



                    )),
              ),

              Padding(
                padding: const EdgeInsets.only(top:25.0,left: 20,right: 20,bottom: 20),
                child: Center(
                  child: Container(

                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.all(Radius.circular(10)),

                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              spreadRadius: 10,
                              blurRadius: 4),
                        ]),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: _Textcontroller,
                            minLines: 2,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                hintText: 'Add another reason here...'.tr,
                                hintStyle: TextStyle(
                                    color: Colors.grey
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                )
                            ),
                          ),
                        ),
                       /* Center(
                          child: RaisedButton(

                              onPressed: (

                                  ){
                                setState(() {
                                  _Textcontroller!.notifyListeners();
                                });
                              },child: Text("Send Message",style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold,
                          ),),
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0) )
                          ),
                        ),*/

                      ],
                    ),
                  ),
                ),
              ),
              RaisedButton(
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
                      if(_Textcontroller != null){
                        controller.returnShipmentController(_Textcontroller?.text );
                      }else{
                        controller.returnShipmentController("");
                      }

                      controller.getFailedAttempt();
                      controller.getOutofDeliveryShipments();




                      Get.offAll(()=>home());
                    });


                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0) )

              ),
            ],
          ),
        ),

    );
  }
  gettimer()async{

    final service = FlutterBackgroundService();
    print('start timerrrrrrrrrrrrrrr');
    var pref = await  SharedPreferences.getInstance();
    late String token = pref.getString('token')!;
    String reasonId =  pref.getString('reasonid')!;
    print(reasonId+"resasonnnnn");
    String missionID = pref.getString('alertidMission')!;
    String shipmentID = pref.getString('alertidShipment')!;
    Timer? timer;
    service.onDataReceived.listen((event){
      if (event!["action"] == "startTimer"){
        timer = Timer.periodic(Duration(seconds: 5), (t){
          controller.isFailedAttemptShipmentController();
        });
      }


    });





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




  _buildChoiceList() {

    var size = MediaQuery.of(context).size;
    var choices = <Widget>[];
    var receiverList=  controller.reasonsList.toList();

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