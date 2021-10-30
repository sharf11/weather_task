import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_task/data/models/weather.dart';
import 'package:weather_task/data/models/weather_forecast5_model.dart';
import 'package:weather_task/data/repository/weather_repository.dart';

part 'weathert_state.dart';

class WeatherCubit extends Cubit<WeathertState> {

  final WeatherRepository weatherRepository;
  WeatherModel weatherModel ;

  WeatherCubit(this.weatherRepository) : super(WeathertInitial());

   getWeatherByCityName(List<String> charName) {
    weatherRepository.getWeatherByCityName(charName).then((weather) {
      emit(WeatherLoaded(weather));
    });
  }

  }


