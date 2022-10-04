import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/home/Block/weather_Block.dart';
import 'package:weatherapp/home/home_Screen.dart';
import 'package:weatherapp/share/style/themes.dart';
import 'package:weatherapp/test222.dart';

import 'BlockOpserver/BlockOpserver.dart';
import 'modules/test_screen.dart';
import 'network/remote/local/dio_helper.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init() ;
  Bloc.observer = MyBlocObserver();
  runApp(MyApp()) ;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider
          (
          create: (_)=>WeatherBloc()..getDateWeather(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false ,
        home : HomeScreen() ,
        themeMode: ThemeMode.light,
        theme: lightTheme(),
      ),
    );
  }
}

