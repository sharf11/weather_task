
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_task/business_logic/cubit/current_location_cubit.dart';
import 'package:weather_task/data/models/weather_forecast5_model.dart';
import 'package:weather_task/presentation/widgets/custom_alert_dialog.dart';
import 'package:weather_task/presentation/widgets/modal_bottom_sheet.dart';

import '../../general.dart';


class CurrentLocationScreen extends StatefulWidget {
  static String id = 'CurrentLocationScreen';



  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  Weatherforecast5Model weatherforecast5model;

  String longitude;
  String latitude;
  int thisHour ;
  int thisDay ;


  List<ListElement> firstDayAndHourList=[];
  List<ListElement> secondDayAndHourList=[];
  List<ListElement> thirdDayAndHourList=[];
  List<ListElement> fourthDayAndHourList=[];
  List<ListElement> fifthDayAndHourList=[];
  List<ListElement> sixthDayAndHourList=[];

  List<List<ListElement>> allDayAndHourList=[];
  @override
  void initState() {
    super.initState();
     thisHour =int.parse( DateFormat('kk').format(DateTime.now()));
     thisDay =int.parse( DateFormat('d').format(DateTime.now()));
    getCurrentLocation();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: General.kPendingColor,
        title: Text("Your Location Weather"),),
      body: buildBlocWidget(),
    );
  }

Widget buildBlocWidget(){
    return BlocBuilder<CurrentLocationCubit,CurrentLocationState>(builder:(context,state){
      if(state is CurrentLoactionWeatherLoaded){
        weatherforecast5model = (state).weather;
        for(int i=0;i<weatherforecast5model.list.length;i++) {
          if(weatherforecast5model.list[i].dtTxt.day==thisDay){
            firstDayAndHourList.add(weatherforecast5model.list[i]);
          }else if(weatherforecast5model.list[i].dtTxt.day==thisDay+1){
            secondDayAndHourList.add(weatherforecast5model.list[i]);
          }else if(weatherforecast5model.list[i].dtTxt.day==thisDay+2){
            thirdDayAndHourList.add(weatherforecast5model.list[i]);
          }else if(weatherforecast5model.list[i].dtTxt.day==thisDay+3){
            fourthDayAndHourList.add(weatherforecast5model.list[i]);
          }else if(weatherforecast5model.list[i].dtTxt.day==thisDay+4){
            fifthDayAndHourList.add(weatherforecast5model.list[i]);
          }else{
            sixthDayAndHourList.add(weatherforecast5model.list[i]);
          }
        }

        if(firstDayAndHourList.length>0)
          allDayAndHourList.add(firstDayAndHourList);
        if(secondDayAndHourList.length>0)
          allDayAndHourList.add(secondDayAndHourList);
        if(thirdDayAndHourList.length>0)
          allDayAndHourList.add(thirdDayAndHourList);
        if(fourthDayAndHourList.length>0)
          allDayAndHourList.add(fourthDayAndHourList);
        if(fifthDayAndHourList.length>0)
          allDayAndHourList.add(fifthDayAndHourList);
        if(sixthDayAndHourList.length>0)
          allDayAndHourList.add(sixthDayAndHourList);


        return myListViewWidget();
      }else if(state is CurrentLoactionWeatherLoading){
        return Center(child: CircularProgressIndicator(),);
      }else{
        return Center(child: CircularProgressIndicator(),);
      }
    });
}

Widget myListViewWidget(){
    return ListView.builder(
      itemCount: allDayAndHourList.length,
        itemBuilder: (BuildContext context, int index) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          // showAlertDialog("Alarm","Tap on day to show details",context);
          return GestureDetector(
            child: Container(
              height: height*.12,
              child: Card(
                  child: Padding(
                    padding: EdgeInsets.only(right: width * .03, left: width * .03),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Date: ${DateFormat('  EEE d MMM').format(allDayAndHourList[index][allDayAndHourList[index].length-1].dtTxt)}",style: TextStyle(fontSize: 16),),
                            Text("Description: ${allDayAndHourList[index][allDayAndHourList[index].length-1].weather[0].description}",style: TextStyle(fontSize: 16),),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Temperature Min: ${(allDayAndHourList[index][allDayAndHourList[index].length-1].main.tempMin-273.15).toInt()} C",style: TextStyle(fontSize: 16),),
                            Text("Temperature Max: ${(allDayAndHourList[index][allDayAndHourList[index].length-1].main.tempMax-273.15).toInt()} C",style: TextStyle(fontSize: 16),),

                            General.sizeBoxVerical(height * .05),
                          ],
                        ),
                        Center(child:
                        Text("Wind Speed: ${allDayAndHourList[index][allDayAndHourList[index].length-1].wind.speed}",style: TextStyle(fontSize: 16),),
                        ),
                      ],
                    ),
                  )),
            ),
            onTap: (){
              ModalBottomSheet(context,allDayAndHourList[index]);
            },
          );

        }
    );
}

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    latitude = "$lat";
    longitude = "$long";
    weatherforecast5model = BlocProvider.of<CurrentLocationCubit>(context).getMyLocationWeatherBy(latitude, longitude);
    showAlertDialog("Alarm","Tap on day to show details",context);
  }
}
