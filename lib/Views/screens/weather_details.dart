
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_task/Views/widgets/custom_alert_dialog.dart';
import 'package:weather_task/business_logic/cubit/weathert_cubit.dart';
import 'package:weather_task/data/models/weather.dart';

import '../../general.dart';


  class WeatherDetailsScreen extends StatefulWidget {
    static String id = 'WeatherDetailsScreen';
    // final _formKey = GlobalKey<FormState>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    @override
    _WeatherDetailsScreenState createState() => _WeatherDetailsScreenState();
  }

  class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
    WeatherModel weatherModel;

    @override
    Widget build(BuildContext context) {
      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;
      final citiesController = TextEditingController();
      bool emptyItem = false;
      bool showListView = false;
      List<WeatherModel>allCityWeather = [];

      List<String> citiesListsplit=[];
      @override
      void dispose() {
        citiesController.dispose();
        super.dispose();
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: General.kPendingColor,
          title: Text("Your Weather Details"),),
        body: Center(

          child: Form(
                key: widget._formKey,
                child:Container(
                  width: width * .9,
                  child: ListView(children: [
                    SizedBox(height: 20),
                    Container(
                      child: TextFormField(
                        cursorColor: General.kMainColor,
                        decoration: InputDecoration(
                          hintText: "Enter 3-5 Cities Sepearated with ' , ' ",
                          hintStyle: TextStyle(fontSize: 10),
                          prefixIcon: Icon(
                            Icons.opacity_sharp,
                            color:General.kSecondaryColor,
                          ),
                          filled: true,
                          fillColor: General.kUnActiveColor,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                        ),

                        controller: citiesController,
                        validator: (value) {

                          if (value.isEmpty) {
                            return "Should enter cities correctly";
                          }
                          // return null;
                        },
                        onFieldSubmitted:(txt){
                          print("onFieldSubmitted txt is = $txt");
                        } ,

                      ),
                    ),

                    SizedBox(height: 20,),

                    SizedBox(height: 20,),
                    Container(
                      width: width*.7,
                      height: height*.05,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: ()   async {
                          if (widget._formKey.currentState.validate()) {
                             citiesListsplit = citiesController.text.split(",");
                            allCityWeather = [];
                            for(int i=0;i<citiesListsplit.length;i++){
                              print("citiesListsplit[i] is = "+citiesListsplit[i]);
                            }
                            for(int i=0;i<citiesListsplit.length;i++){
                              if(citiesListsplit[i].isEmpty)
                                emptyItem = true;
                            }//cairo,london,new york
                            if((citiesListsplit.length<3||citiesListsplit.length>7)&&citiesListsplit.isNotEmpty){
                              showAlertDialog("Attention","Num of City Should be from 3 to 7 Cities ",context);
                            }
                            else if(emptyItem == true &&citiesController.text.isNotEmpty) {
                              showAlertDialog("Attention", "there are 2 comma without city between them", context);
                            }else{
                              for(int i=0;i<citiesListsplit.length;i++){
                                allCityWeather.add(weatherModel);
                              }
                              print("all city len is =${allCityWeather.length}");
                              allCityWeather = BlocProvider.of<WeatherCubit>(context).getWeatherByCityName(citiesListsplit);
                            }
                             FocusScope.of(context).unfocus();
                          }

                        },
                        color: General.kClosedColor,
                        child: Text(
                          'Get the Weather Details',
                          style: TextStyle(color: Colors.white,
                              fontFamily: 'Almarai',
                              fontSize: 16
                            //fontFamily: 'Pacifico',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
              BlocBuilder<WeatherCubit,WeathertState>(builder:(context,state){
                  if(state is WeatherLoaded ){
                    allCityWeather = (state).weather;
                    return  SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allCityWeather.length,
                              itemBuilder: (BuildContext context, int index) {
                                var height = MediaQuery.of(context).size.height;
                                var width = MediaQuery.of(context).size.width;
                                return Container(
                                    child: Card(
                                      child: Column(
                                        children: [
                                          General.sizeBoxVerical(10.0),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text("City: " + "${allCityWeather[index].name}",style: TextStyle(fontSize: 16),),
                                              Text("Description: " + "${allCityWeather[index].weather[0].description}",style: TextStyle(fontSize: 16),),
                                            ],
                                          ),
                                          General.sizeBoxVerical(10.0),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text("Max Temp: " + "${(allCityWeather[index].main.tempMax-273.15).toInt()} C",style: TextStyle(fontSize: 16),),
                                              Text("Min Temp: " + "${(allCityWeather[index].main.tempMin-273.15).toInt()} C",style: TextStyle(fontSize: 16),),
                                            ],
                                          ),
                                          General.sizeBoxVerical(10.0),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Wind Speed: " +"${allCityWeather[index].wind.speed}",style: TextStyle(fontSize: 16),),
                                            ],
                                          ),
                                          General.sizeBoxVerical(10.0),
                                        ],
                                      ),
                                    )
                                );
                              }
                          ),
                        ],
                      ),
                    );
                  }
                  else{
                    return  Text("");
                  }
              })

                  ],),
                )
            ),

          /*BlocBuilder<WeatherBloc,WeatherState>(
            builder: (context,state){
              if(state is WeatherLoading){
                return CircularProgressIndicator();
              }else if(state is WeatherLoaded){
                return Container();
              }
              else if(state is WeatherError){
                return Text("Some thing error please try again");
              }
              return CircularProgressIndicator();
            },
          ),*/
        ),
      );
    }
  }
