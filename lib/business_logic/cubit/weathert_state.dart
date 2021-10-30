part of 'weathert_cubit.dart';

@immutable
abstract class WeathertState {}

class WeathertInitial extends WeathertState {}



class WeatherLoading extends WeathertState{}

class WeatherLoaded extends WeathertState {
  final List<WeatherModel> weather;

  WeatherLoaded(this.weather);
}

class WeatherError extends WeathertState{
  final String message;
  WeatherError(this.message);

}


