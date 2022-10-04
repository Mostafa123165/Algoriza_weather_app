import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/weather-date.dart';
import '../../network/remote/local/dio_helper.dart';
import 'states.dart';

class WeatherBloc extends Cubit<MainState> {
  WeatherBloc() : super(InitialState());

  static WeatherBloc get(context) => BlocProvider.of(context);
  ModelDateWeather? modelDateWeather ;
  List<double?>hourTemp = [] ;
  String? lastLocation = "" ;
  void getDateWeather({String region = "Cairo"}) {
    emit(GetDateWeatherLoadingState()) ;
    DioHelper.getData(
        path: '/v1/forecast.json', q:
    {
      "key": "3abc4ac71f114deb86380405201809",
      "q": region,
      "days": "7",
      "aqi": "no",
      "alerts": "no",
    }).then((value) {
      modelDateWeather = ModelDateWeather.fromJson(value.data) ;
      emit(GetDateWeatherSuccessState()) ;
      //lastLocation = modelDateWeather!.location!.region ;
    }).catchError((error){
      print(error.toString()) ;
      emit(GetDateWeatherErrorState());
    });
  }

  void sendRegionFromUser({
  required String region ,
}){
    getDateWeather(region: region  ,) ;
  }
}
