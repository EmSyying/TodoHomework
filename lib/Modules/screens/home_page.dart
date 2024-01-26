import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/Modules/Todo/Screens/todo_screen.dart';
import 'package:weather_app/Modules/controllers/weather_controller.dart';
import 'package:weather_app/Modules/services/user_permission.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/constants/format_date.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final weatherCon = Get.put(WeatherController());
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  String _locationMessage = '';
  Position? position;
  String dateTime = '';
  void _getCurrentLocation() async {
    try {
      Position positions = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _locationMessage =
            'Latitude: ${positions.latitude}, Longitude: ${positions.longitude}';
        position = positions;
      });

      debugPrint('lat:${positions.latitude} long:${positions.longitude}');
    } catch (e) {
      setState(() {
        _locationMessage = 'Failed to get location: $e';
      });
    }
  }

  @override
  void initState() {
    // DateTime date = DateTime(
    //     '${weatherCon.weatherModel.value.dt}+${weatherCon.weatherModel.value.timezone}');
    _getCurrentLocation();
    weatherCon.fetchWeather();
    handleLocationPermission(context);
    debugPrint('he;:$_locationMessage');
    // getGps();
    // getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 30,
      ),
      body: Obx(
        () => weatherCon.isLoadingWeather.value == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      key: const Key('goto_todo'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TodoScreen()));
                      },
                      child: Padding(
                        key: const Key('name'),
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                            '${weatherCon.weatherModel.value.location!.name}',
                            style: theme.displayMedium!.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      key: const Key('date'),
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        formatDate(
                            weatherCon.weatherModel.value.location!.localtime,
                            'EEE, MMM yyyy HH:mm'),
                        style: theme.displayMedium!.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      key: const Key('tem'),
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                              width: 85,
                              height: 85,
                              child: Image.network(
                                  'https:${weatherCon.weatherModel.value.current!.condition!.icon}',
                                  fit: BoxFit.cover,
                                  color: Colors.white)),
                        ),
                        Center(
                          child: Text(
                            '${weatherCon.weatherModel.value.current!.tempC}°'
                                .replaceAll('.0', ''),
                            style: theme.displayMedium!.copyWith(
                                fontSize: 44, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: Image.asset(
                                'assets/Images/windspeed.png',
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${weatherCon.weatherModel.value.current!.windKph}Km/h'
                                  .replaceAll('.0', ''),
                              style: theme.displayMedium!.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                'assets/Images/humidity.png',
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${weatherCon.weatherModel.value.current!.humidity}%'
                                  .replaceAll('.0', ''),
                              style: theme.displayMedium!.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: Image.network(
                                'https:${weatherCon.weatherModel.value.current!.condition!.icon}',
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${weatherCon.weatherModel.value.current!.cloud}%'
                                  .replaceAll('.0', ''),
                              style: theme.displayMedium!.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Divider(
                        thickness: 1.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 0,
                        left: 15,
                        right: 15,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: weatherCon
                              .weatherModel.value.forecast!.forecastday!.length,
                          itemBuilder: (context, index) {
                            var list = weatherCon.weatherModel.value.forecast!
                                .forecastday![index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                top: 20,
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...list.hour!.asMap().entries.map((e) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              formatDate(e.value.time, 'HH:mm'),
                                              style: theme.displaySmall,
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(top: 0),
                                              width: 60,
                                              height: 60,
                                              child: Image.network(
                                                  'https:${e.value.condition!.icon}'),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 15),
                                              width: 30,
                                              height: 30,
                                              child: Image.asset(
                                                  'assets/Images/humidity.png'),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${e.value.humidity}%',
                                              style: theme.displaySmall,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20),
                                              width: 35,
                                              height: 35,
                                              child: Image.asset(
                                                'assets/Images/windspeed.png',
                                                color: const Color(0xff167FFC),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${e.value.windKph} km/h',
                                              style: theme.displaySmall!
                                                  .copyWith(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 15, right: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...weatherCon
                              .weatherModel.value.forecast!.forecastday!
                              .asMap()
                              .entries
                              .map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 15, bottom: 20, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formatDay(e.value.date, 'EEE'),
                                    style: theme.displaySmall,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/Images/humidity.png',
                                        width: 15,
                                        height: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        e.value.day!.avghumidity.toString(),
                                        style: theme.displaySmall,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/Images/windspeed.png',
                                          width: 20,
                                          height: 20,
                                          color: const Color(0xff167FFC)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${e.value.day!.maxwindKph.toString()}Km/h',
                                        style: theme.displaySmall,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                          'https:${e.value.day!.condition!.icon!}',
                                          width: 25,
                                          height: 25,
                                          color: const Color(0xff167FFC)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${e.value.day!.maxtempC.toString()}°',
                                        style: theme.displaySmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
