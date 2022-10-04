import 'package:weatherapp/model/weather-date.dart';

abstract class MainState {}

 class InitialState extends MainState{}

 class GetDateWeatherSuccessState extends MainState{}

 class GetDateWeatherLoadingState extends MainState{}

 class GetDateWeatherErrorState extends MainState{}

class GetDateWeatherSuccess2State extends MainState{
 late ModelDateWeather modelDateWeather ;
 GetDateWeatherSuccess2State(this.modelDateWeather) ;
}