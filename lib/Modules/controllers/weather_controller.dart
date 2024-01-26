import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/Modules/models/weather_model.dart';

class WeatherController extends GetxController {
  final weatherModel = WeatherModel().obs;
  final cityName = '';
  final isLoadingWeather = false.obs;
  String place = '';
  Future<WeatherModel> fetchWeather() async {
    isLoadingWeather.value = true;
    Position positions = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(
      positions.latitude,
      positions.longitude,
    );
    place = placemarks[0].locality.toString();
    //  Location
    var url =
        'https://api.weatherapi.com/v1/forecast.json?key=40a419bdd8064f7096655611242401&days=&q=$place';
    // 'https://open-weather13.p.rapidapi.com/city/latlon/${positions.latitude}/${positions.longitude}';
    final header = {
      'X-RapidAPI-Key': '578c677fecmsh190e0a59663ce5cp1d4129jsn535cc7d8e243',
      'X-RapidAPI-Host': 'open-weather13.p.rapidapi.com',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var res = await http.get(Uri.parse(url), headers: header);

    if (res.statusCode == 200) {
      var resJson = json.decode(res.body);
      weatherModel.value = WeatherModel.fromJson(resJson);

      debugPrint('city:${placemarks[0].locality}');
      debugPrint('hell res==9999:$resJson');
      update();
    } else {
      debugPrint('error res==9999:${res.body}');
    }
    isLoadingWeather.value = false;
    update();
    return weatherModel.value;
  }

//   var list = [].obs;
//   void fetchWeaather() async {
//     try {
//       isLoadingWeather.value = true;
//       Position positions = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         positions.latitude,
//         positions.longitude,
//       );
//       place = placemarks[0].locality.toString();
//       var data = (await Repo.fetchData(place));
// // Rx(list.value=data);
//     } finally {}
//   }

  @override
  void onInit() {
    fetchWeather();
    super.onInit();
  }
}
