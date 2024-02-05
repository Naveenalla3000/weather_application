// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';
import 'package:weather_app/additional_information_wedget.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    print('iubswdiuweidcuiuw');
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=Vijayawada&APPID=373f18dc29ddbd864e3712b6d95e015b'));
      print(response);
      final data = jsonDecode(response.body);
      if (data['cod'] != '200') {
        throw "status code is not-ok";
      }
      setState(() {
        temp = data['list'][0]['main']['temp'];
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                "Weather app",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.refresh,
                    size: 26,
                  ),
                )
              ],
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    //main card
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10,
                              sigmaY: 10,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '$temp k',
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Icon(
                                    Icons.cloud,
                                    size: 64,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Rain",
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //fourecase cards
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Weather forecast",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          HourlyForecastItem(
                            icon: Icons.cloud,
                            temprature: "301.22",
                            time: "03:00",
                          ),
                          HourlyForecastItem(
                            icon: Icons.sunny,
                            temprature: "301.22",
                            time: "03:00",
                          ),
                          HourlyForecastItem(
                            icon: Icons.cloud,
                            temprature: "301.22",
                            time: "03:00",
                          ),
                          HourlyForecastItem(
                            icon: Icons.sunny,
                            temprature: "301.22",
                            time: "03:00",
                          ),
                          HourlyForecastItem(
                            icon: Icons.cloud,
                            temprature: "301.22",
                            time: "03:00",
                          ),
                          HourlyForecastItem(
                            icon: Icons.cloud,
                            temprature: "301.22",
                            time: "03:00",
                          ),
                          HourlyForecastItem(
                            icon: Icons.cloud,
                            temprature: "301.22",
                            time: "03:00",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Additional information",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        AdditionalInformationWeget(
                          icon: Icons.water_drop,
                          label: "Humidity",
                          value: "2333",
                        ),
                        AdditionalInformationWeget(
                          icon: Icons.air,
                          label: "Wind Speed",
                          value: "2333",
                        ),
                        AdditionalInformationWeget(
                          icon: Icons.beach_access,
                          label: "Pressure",
                          value: "iewfiuuer",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
