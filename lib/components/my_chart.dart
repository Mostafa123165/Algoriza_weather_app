import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weatherapp/home/Block/weather_Block.dart';

import '../model/weather-date.dart';

class MyChart extends StatelessWidget {
   MyChart({Key? key , this.modelDateWeather}) : super(key: key);
  ModelDateWeather? modelDateWeather ;
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // Initialize category axis
        primaryXAxis:CategoryAxis(),
       series:<ChartSeries<SalesData , String >>[
         LineSeries(
             dataSource: <SalesData>[
               SalesData("12",modelDateWeather!.forecast!.foreCastDays![0].hour![0].temp_c),
               SalesData("1",modelDateWeather!.forecast!.foreCastDays![0].hour![1].temp_c),
               SalesData("2",modelDateWeather!.forecast!.foreCastDays![0].hour![2].temp_c),
             ],
             xValueMapper: (SalesData data, _)=>data.month ,
             yValueMapper:  (SalesData data, _)=>data.temp ,
         ),
       ] ,
    );
  }

}
class SalesData {
  SalesData(this.month, this.temp);
  final String month;
  final double temp;
}

