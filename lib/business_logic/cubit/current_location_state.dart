part of 'current_location_cubit.dart';

@immutable
abstract class CurrentLocationState {}

class CurrentLocationInitial extends CurrentLocationState {}



class CurrentLoactionWeatherLoading extends CurrentLocationState{}


class CurrentLoactionWeatherLoaded extends CurrentLocationState {
  final Weatherforecast5Model weather;

  CurrentLoactionWeatherLoaded(this.weather);
}