import 'package:dio/dio.dart';

class DioHelper{

  static Dio? dio ;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.weatherapi.com',
        receiveDataWhenStatusError: true,
      )
    );
  }

  static Future<Response> getData({
  required String path ,
    Map<String , dynamic >?q ,
})async{
    return await dio!.get(
        path ,
       queryParameters: q ,
    ) ;
  }
}