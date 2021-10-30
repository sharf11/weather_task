import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_task/data/web_services/current_location_weather.dart';
import 'package:weather_task/Views/screens/current_location_weather_screen.dart';
import 'package:weather_task/Views/screens/weather_details.dart';

import 'business_logic/cubit/current_location_cubit.dart';
import 'business_logic/cubit/weathert_cubit.dart';
import 'data/repository/current_location_repository.dart';
import 'data/repository/weather_repository.dart';
import 'data/web_services/weather_web_services.dart';
import 'general.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     WeatherRepository weatherRepository;
     WeatherCubit weatherCubit;
     weatherRepository = WeatherRepository(WeatherWebServices());
     weatherCubit = WeatherCubit(weatherRepository);

     CurrentLocationRepository currentLocationRepository;
     CurrentLocationCubit currentLocationCubit;
     currentLocationRepository = CurrentLocationRepository(CurrentLocationWebServices());
     currentLocationCubit = CurrentLocationCubit(currentLocationRepository);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:  Home.id,
      theme: ThemeData(
        accentColor: Colors.teal
      ),
      routes: {
        Home.id: (context) => Home(),
        WeatherDetailsScreen.id: (context) => BlocProvider(
          create: (BuildContext context) =>
              WeatherCubit(weatherRepository),
          child: WeatherDetailsScreen(),),

        CurrentLocationScreen.id: (context) => BlocProvider(
          create: (BuildContext context) =>
              CurrentLocationCubit(currentLocationRepository), child: CurrentLocationScreen(),),

      },
      home: Home(),

    );
  }
}
class Home extends StatelessWidget {
  static String id = 'Home';
  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: General.kPendingColor,
        title: Text("Get weather App !"),),
      body: Column(children: [

        Container(
            height: height*.5,
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset('assets/images/temp_image.png',fit: BoxFit.fill,color: Colors.yellow,),
            )),


        Spacer(),
        // SizedBox(height: 30,),
        Container(
          width: width*.8,
          height: height*.05,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            onPressed: ()   {
              Navigator.pushNamed(context, WeatherDetailsScreen.id);
            },
            color: General.kClosedColor,
            child: Text(
              'Find Weather For More Cities',
              style: TextStyle(color: Colors.white,
                  fontFamily: 'Almarai',
                  fontSize: 16
                //fontFamily: 'Pacifico',
              ),
            ),
          ),
        ),

        SizedBox(height: 20,),
        Container(
          width: width*.8,
          height: height*.05,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            onPressed: ()   {
              print("getCurrentLocation is pressed");
              // getCurrentLocation();
              Navigator.pushNamed(context, CurrentLocationScreen.id);
              // General.showMakeSureDialogue(txt: "asd", context: context);
            },
            color:General.kClosedColor,
            child: Text(
              // 'Add To Order'.tr,
              'Find Weather For My location',
              style: TextStyle(color: Colors.white,
                  fontFamily: 'Almarai',
                  fontSize: 16
                //fontFamily: 'Pacifico',
              ),
            ),
          ),
        ),
        Spacer(),
      ],),
    );
  }

}

/*class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home page Screen"),),
      body: Center(
        child: BlocBuilder<WeatherBloc,WeatherState>(
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
        ),
      ),
    );
  }
}*/


