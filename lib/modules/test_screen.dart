import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/components/constant/colors.dart';
import 'package:weatherapp/home/Block/states.dart';
import 'package:weatherapp/home/Block/weather_Block.dart';
import 'dart:math' as math;
import '../components/components/components.dart';

class TesScreen extends StatefulWidget {
  TesScreen({Key? key}) : super(key: key);

  @override
  State<TesScreen> createState() => _TesScreenState();
}

class _TesScreenState extends State<TesScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = ScrollController();
  bool isTop = false;
  bool isPinned = false ;
  double maxHeight = 180.0 ;
  double minHeight = 180.0 ;
  Color secondaryColor1 = const Color(0xff91C0F2);
  Color primaryColor1 = const Color(0xff91C0F2);
  @override
  void initState() {
    controller.addListener(() {
      var x = controller.position.pixels;

      if (x > 5)
      {
        setState(() {
          isTop = true;
          isPinned = true ;
          maxHeight = 100.0 ;
          minHeight = 100.0 ;
          secondaryColor1 = Colors.black ;
          primaryColor1 = Color(0xff171717);
        });
      }
      else
      {
        setState(() {
          isTop = false;
          isPinned = false ;
          maxHeight = 180.0 ;
          minHeight = 180.0 ;
          secondaryColor1 =  const Color(0xff91C0F2) ;
          primaryColor1 = Color(0xff91C0F2);
        });
      }


    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, MainState>(
      listener: (context, state) {
        if (state is GetDateWeatherSuccessState) {
          WeatherBloc.get(context).lastLocation =
              WeatherBloc.get(context).modelDateWeather!.location!.region;
        }
      },
      builder: (context, state) {
        var cubit = WeatherBloc.get(context).modelDateWeather;
        var controllerSearch = TextEditingController();

        return Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor:secondaryColor1,
            drawer: Drawer(
              backgroundColor: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal:20,
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          alignLabelWithHint: true,
                          hintText: "Search",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        controller: controllerSearch,
                        onFieldSubmitted: (value) {
                          //  WeatherBloc.get(context).sendRegionFromUser(region: value);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return "Location must not empty";
                          }
                          return null;
                        },
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: HexColor('#7f7f7f').withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        color: HexColor('#7f7f7f').withOpacity(0.1),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            WeatherBloc.get(context).sendRegionFromUser(
                                region: controllerSearch.text);
                          }
                        },
                        child: const Text(
                          'Go search',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    myDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on_sharp),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              'Other locations',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 60,
                        top: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${WeatherBloc.get(context).lastLocation}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          //Spacer(),
                          const Image(
                              height: 20,
                              width: 20,
                              image: AssetImage(
                                'assets/image/sun.png',
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '29\u00B0',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 25,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            'Manage Locations',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    myDivider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info_outline),
                              SizedBox(
                                width: 14,
                              ),
                              Text(
                                'Report Wrong Locations',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: const [
                              Icon(Icons.phone_forwarded_rounded),
                              SizedBox(
                                width: 14,
                              ),
                              Text(
                                'Contact us ',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: secondaryColor1,
              elevation: 0,
              centerTitle: false,
              title: BlocBuilder<WeatherBloc, MainState>(
                builder: (context, state) {
                  if (state is GetDateWeatherSuccessState) {
                    if (isTop) {
                      return Row(
                        children:  [
                           Text(
                            '${cubit!.location!.name}',
                          ),
                           const SizedBox(width: 5,),
                           const Icon(
                                Icons.location_on_sharp ,
                                size: 15,
                           )
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
            body: ConditionalBuilder(
              condition: state is GetDateWeatherSuccessState,
              builder: (context) => CustomScrollView(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                      pinned: isPinned,
                      floating: true,
                      delegate: SliverAppBarDelegate(
                        maxHeight: maxHeight,
                        minHeight: maxHeight,
                        child: Container(
                          height: maxHeight,
                          color: secondaryColor1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${cubit!.current!.temp_c.toInt()}',
                                                    style: const TextStyle(
                                                      fontSize: 50,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.panorama_fish_eye,
                                                    size: 11,
                                                  ),
                                                ],
                                              ),
                                              if(isTop)
                                                Column(
                                                  children: [
                                                    Text(
                                                      '${cubit.forecast!.foreCastDays![0].day!.maxtemp_c.toInt()}\u00B0 / ${cubit.forecast!.foreCastDays![0].day!.mintemp_c.toInt()}\u00B0 Feels like ${cubit.current!.feelslike_c.toInt()}\u00B0 ',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      '${DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(WeatherBloc.get(context).modelDateWeather!.forecast!.foreCastDays![0].date_epoch * 1000))},${DateFormat(' k:mm').format(DateTime.now())}',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                              const Spacer(),
                                              const Image(
                                                image: AssetImage(
                                                  'assets/image/suntop.png',
                                                ),
                                                fit: BoxFit.cover,
                                                height: 75,
                                              )
                                            ],
                                          ),
                                           if (!isTop)
                                            Row(
                                              children: [
                                                Text(
                                                  '${cubit.location!.name}',
                                                  style: const TextStyle(
                                                    fontSize: 30,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const Icon(
                                                  Icons.location_on_sharp,
                                                  size: 18,
                                                ),
                                              ],
                                            ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          if(!isTop)
                                          Text(
                                            '${cubit.forecast!.foreCastDays![0].day!.maxtemp_c.toInt()}\u00B0 / ${cubit.forecast!.foreCastDays![0].day!.mintemp_c.toInt()}\u00B0 Feels like ${cubit.current!.feelslike_c.toInt()}\u00B0 ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                          if(!isTop)
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          if(!isTop)
                                          Text(
                                            '${DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(WeatherBloc.get(context).modelDateWeather!.forecast!.foreCastDays![0].date_epoch * 1000))},${DateFormat(' k:mm').format(DateTime.now())}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  margin: EdgeInsetsDirectional.zero,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  color: primaryColor1,
                                  child: Container(
                                      height: 80,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'Today\'s Temperature',
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Expect the same as yesterday',
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Card(
                                  elevation: 5,
                                  margin: EdgeInsetsDirectional.zero,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                    ),
                                  ),
                                  color: primaryColor1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      height: 30,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: itemBuilderYesterday(),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsetsDirectional.zero,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: primaryColor1,
                                  elevation: 5,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      height: 230,

                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) =>
                                                itemBuilderDays(
                                                    WeatherBloc.get(context)
                                                        .modelDateWeather!
                                                        .forecast!
                                                        .foreCastDays![index]),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                                      height: 7,
                                                    ),
                                            itemCount: WeatherBloc.get(context)
                                                .modelDateWeather!
                                                .forecast!
                                                .foreCastDays!
                                                .length),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Card(
                                  elevation: 5,
                                  margin: EdgeInsetsDirectional.zero,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  color: primaryColor1,
                                  child: Container(
                                      height: 120,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Sunrise',
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  '${cubit.forecast!.foreCastDays![0].astro!.sunrise}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                                const Image(
                                                    height: 40,
                                                    width: 40,
                                                    image: AssetImage(
                                                        'assets/image/icons8-climate-64.png'))
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Sunset',
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  '${cubit.forecast!.foreCastDays![0].astro!.sunset}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                                const Image(
                                                    height: 40,
                                                    width: 40,
                                                    image: AssetImage(
                                                        'assets/image/icons8-climate-64.png'))
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Card(
                                  elevation: 5,
                                  margin: EdgeInsetsDirectional.zero,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  color: primaryColor1,
                                  child: Container(
                                      height: 120,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Image(
                                                    height: 30,
                                                    width: 30,
                                                    image: AssetImage(
                                                        'assets/image/sun.png')),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'UV index',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2.5,
                                                ),
                                                Text(
                                                  'HIGH',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Image(
                                                    height: 30,
                                                    width: 30,
                                                    image: AssetImage(
                                                        'assets/image/tornado.png')),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Text(
                                                  'Wind',
                                                ),
                                                const SizedBox(
                                                  height: 2.5,
                                                ),
                                                Text(
                                                  '${cubit.current!.wind_kph.toInt()} km/h',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Image(
                                                    height: 30,
                                                    width: 30,
                                                    image: AssetImage(
                                                        'assets/image/rain-drops.png')),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Text(
                                                  'Humidity',
                                                ),
                                                const SizedBox(
                                                  height: 2.5,
                                                ),
                                                Text(
                                                  '${cubit.current!.humidity}%',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemCount: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              fallback: (context) =>
                  Center(child: const CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  Widget itemBuilderDays(model) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              // '${model.date_epoch * 1000}'
              '${DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(model.date_epoch * 1000))}',
            ),
          ),
          Text(
            "${model.day.uv.toInt()} %",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
          const SizedBox(
            width: 19,
          ),
          const Image(
              height: 20, width: 20, image: AssetImage('assets/image/sun.png')),
          const SizedBox(
            width: 19,
          ),
          const Image(
              height: 20,
              width: 20,
              image: AssetImage('assets/image/crescent-moon.png')),
          const SizedBox(
            width: 19,
          ),
          Text(
              "${model.day.maxtemp_c.toInt()}\u00B0 ${model.day.mintemp_c.toInt()}\u00B0"),
        ],
      );

  Widget itemBuilderYesterday() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Expanded(
              child: Text(
            "Yesterday",
            style: TextStyle(
              fontWeight: FontWeight.w300,
            ),
          )),
          Text("35\u00B0 45\u00B0",
              style: TextStyle(
                fontWeight: FontWeight.w300,
              )),
        ],
      );
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;
    // debugPrint('progress => $progress');
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      // height: progress,
      child: child,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
