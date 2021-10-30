

import 'dart:convert';
import 'package:weather_task/data/models/weather_forecast5_model.dart';
import 'package:weather_task/data/web_services/current_location_weather.dart';
import 'package:weather_task/data/web_services/weather_web_services.dart';

class CurrentLocationRepository {
  final CurrentLocationWebServices currentLocationWebServices;

  CurrentLocationRepository(this.currentLocationWebServices);





  Future<Weatherforecast5Model> getMyLocationWeatherBy( latitude, longitude) async {
    final response = await currentLocationWebServices.getMyLocationWeatherBy( latitude, longitude);

    return response;
  }


}