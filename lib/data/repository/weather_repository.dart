

import 'dart:convert';

import 'package:weather_task/data/models/weather.dart';
import 'package:weather_task/data/models/weather_forecast5_model.dart';
import 'package:weather_task/data/web_services/weather_web_services.dart';

class WeatherRepository {
  final WeatherWebServices weatherWebServices;

  WeatherRepository(this.weatherWebServices);



  Future<List<WeatherModel>> getWeatherByCityName(List<String> cityName) async {
    final response = await weatherWebServices.getWeatherByCityName(cityName);

    if(response.length>=3)
    return response;
    // return quotes.map((charQuotes) => Quote.fromJson(charQuotes)).toList();
  }





}