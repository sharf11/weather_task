
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_task/data/models/weather_forecast5_model.dart';
class CurrentLocationWebServices {


  Future<Weatherforecast5Model> getMyLocationWeatherBy( latitude, longitude) async {
    try {
      var url = 'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=6bcb24935e1347781776a47ff9f8ea2b';
      print("Url is =${url}");
      final response = await http.get(Uri.parse(url));

      if(response.statusCode==200){
        print("response.body is =${response.body}");
        return Weatherforecast5Model.fromJson(json.decode(response.body));
      }else{
        throw Exception("Can not find $this location Weather");
      }
    } catch (e) {print(e.toString());}
  }




}