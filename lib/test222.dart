/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

final controller = ScrollController();

void weatherScrollController() {}

class _TestScreenState extends State<TestScreen> {
  bool isTop = false;
  bool silverTop = false;

  @override
  void initState() {
    controller.addListener(() {
      var x = controller.position.pixels;
      if (x >= 12) {
        setState(() {
          silverTop = true;
        });
      } else {
        setState(() {
          silverTop = false;
        });
      }
      if (x > 40) {
        setState(() {
          AppColors.primaryColor = Colors.black;
          AppColors.secondaryColor = const Color(0xff171717);
          isTop = true;
        });
      } else {
        setState(() {
          AppColors.primaryColor = const Color(0xff85A9E7);
          AppColors.secondaryColor = const Color(0xff91C0F2);
          isTop = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: false,
        elevation: 0,
        title: BlocBuilder<WeatherCubit, WeatherStates>(
          builder: (context, state) {
            if (state is WeatherSuccessState) {
              var weather = state.weatherModel;
              if (isTop) {
                return Row(
                  children: [
                    Text(
                      '${weather.locationModel!.name}',
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.location_on,
                      size: 15,
                      color: Colors.white,
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: BlocConsumer<WeatherCubit, WeatherStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            if (state is WeatherSuccessState) {
              var weather = state.weatherModel;
              return CustomScrollView(
                controller: controller,
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0,
                    expandedHeight: 170,
                    toolbarHeight: 140,
                    pinned: true,
                    floating: true,
                    centerTitle: false,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: (silverTop) ? 30.0 : 54.0,
                          ),
                          if (isTop)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${weather.currentWeather!.tempC}\u00B0',
                                  style: const TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${weather.forecastWeather!.forecast[0].day!.minTempC!.toInt()}\u00B0 / ${weather.forecastWeather!.forecast[0].day!.maxTempC!.toInt()}\u00B0',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      DateFormat('EE, hh:mm a').
                                      format(DateTime.fromMillisecondsSinceEpoch(weather.locationModel!.localtimeEpoch! * 1000)),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Image(
                                  image: NetworkImage(
                                      'https:${weather.currentWeather!.icon}',
                                      scale: .7),
                                ),
                              ],
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${weather.currentWeather!.tempC}\u00B0',
                                      style: const TextStyle(
                                        fontSize: 36.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    if (isTop == false)
                                      Row(
                                        children: [
                                          Text(
                                            '${weather.locationModel!.name}',
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          const Icon(
                                            Icons.location_on,
                                            size: 10,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    Text(
                                      '${weather.forecastWeather!.forecast[0].day!.minTempC!.toInt()}\u00B0 / ${weather.forecastWeather!.forecast[0].day!.maxTempC!.toInt()}\u00B0 Feels like ${weather.currentWeather!.feelsLike!.toInt()}\u00B0',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    //MM, hh:ss a
                                    Text(
                                      DateFormat('EE, hh:mm a').
                                      format(DateTime.fromMillisecondsSinceEpoch(weather.locationModel!.localtimeEpoch! * 1000)),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Image(
                                  image: NetworkImage(
                                      'https:${weather.currentWeather!.icon}',
                                      scale: 1),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    leading: const SizedBox(),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 6.0,
                          ),
                          MyChart(
                            forecastHour:
                            weather.forecastWeather!.forecast[0].hours!,
                          ),
                          Card(
                            elevation: 5,
                            color: AppColors.secondaryColor,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                top: 16.0,
                                bottom: 16.0,
                              ),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemCount: weather
                                        .forecastWeather!.forecast.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var item = weather
                                          .forecastWeather!.forecast[index];
                                      return SizedBox(
                                        height: 30,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                DateFormat('EEEE').format(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                    item.dateEpoch! *
                                                        1000)),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Image(
                                                  image: NetworkImage(
                                                      'https:${item.day!.icon}'),
                                                  fit: BoxFit.contain,
                                                  width: 25,
                                                  height: 25,
                                                )),
                                            Expanded(
                                              child: Text(
                                                '${item.day!.minTempC!.toInt()}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${item.day!.maxTempC!.toInt()}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: AppColors.secondaryColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Sunrise',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${weather.forecastWeather!.forecast[0].astro!.sunrise}',
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 5.0),
                                          child: Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/sunrisesss.gif'),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Sunset',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${weather.forecastWeather!.forecast[0].astro!.sunrise}',
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 5.0),
                                          child: Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/anime-sunset.gif'),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: AppColors.secondaryColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Wind',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${weather.currentWeather!.windKph}',
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 5.0),
                                          child: Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/wind.gif'),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                      color: Colors.grey,
                                      width: 1.5,
                                      height: 80,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Humidly',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${weather.currentWeather!.humidity}',
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 5.0),
                                          child: Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/humidly.gif'),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is WeatherLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('There is An Error'),
              );
            }
          },
        ),
      ),
    );
  }
}
*/
