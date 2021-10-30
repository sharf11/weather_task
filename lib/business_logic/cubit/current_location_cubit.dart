import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_task/data/models/weather_forecast5_model.dart';
import 'package:weather_task/data/repository/current_location_repository.dart';

part 'current_location_state.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  final CurrentLocationRepository currentLocationRepository;

  CurrentLocationCubit(this.currentLocationRepository) : super(CurrentLocationInitial());



  getMyLocationWeatherBy( latitude, longitude)  {
    currentLocationRepository.getMyLocationWeatherBy( latitude, longitude).then((currentLocationWeather) {
      emit(CurrentLoactionWeatherLoaded(currentLocationWeather));
    });
  }
}
