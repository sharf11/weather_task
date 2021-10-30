import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_task/data/models/weather_forecast5_model.dart';

import '../../general.dart';
import 'custom_alert_dialog.dart';

Widget ModalBottomSheet(context,List<ListElement> selectedDayAndHourList){

    showModalBottomSheet(context: context, builder: (context) {
      for(int i=0 ; i<selectedDayAndHourList.length;i++){
        print(selectedDayAndHourList[i].weather[0].description);
      }
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

              return new Container(
                color: Color(General.getColorHexFromStr('737373')),

                child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0))),
                    child:ListView.builder(
                      itemCount: selectedDayAndHourList.length,
                        itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Container(
                            height: height*.07,
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                Text("Clock: "+(DateFormat('kk:mm').format(selectedDayAndHourList[index].dtTxt)),style: TextStyle(fontSize: 16),),
                                Text("description:"+selectedDayAndHourList[index].weather[0].description,style: TextStyle(fontSize: 16),),
                              ],),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Temperature Min: ${(selectedDayAndHourList[index].main.tempMin-273.15).toInt()} C",style: TextStyle(fontSize: 16),),
                                  Text("Temperature Max: ${(selectedDayAndHourList[index].main.tempMax-273.15).toInt()} C",style: TextStyle(fontSize: 16),),
                                ],),
                            ],),
                          ),
                        );
                        }
                    )
                ),
              );

      }
  );

}

