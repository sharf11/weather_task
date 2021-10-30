
import 'dart:convert';
import 'package:weather_task/data/models/weather.dart';
import 'package:http/http.dart' as http;
class WeatherWebServices {


  Future<List<WeatherModel>> getWeatherByCityName(List<String> allcityName) async {
    List<WeatherModel> allWeatherModel=[];
    try {
      for(int i=0;i<allcityName.length;i++){
        final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${allcityName[i]}&appid=6bcb24935e1347781776a47ff9f8ea2b'));
        if(response.statusCode==200){
          print("response.body is =${response.body}");
          allWeatherModel.add(WeatherModel.fromJson(json.decode(response.body)));
          // return WeatherModel.fromJson(json.decode(response.body));
        }else{
          throw Exception("Can not find $allcityName Weather");
        }
      }
      if(allWeatherModel.length>=3)
        return allWeatherModel;
    } catch (e) {
      print(e.toString());
      if(allWeatherModel.length>=3)
        return allWeatherModel;
    }
  }




}