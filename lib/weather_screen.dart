// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ui';
import 'package:weather_app/additional_information_wedget.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:weather_app/loading.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // double temp = 0;
  // bool isLoading = false;
  // @override
  // void initState() {
  //   super.initState();
  //   print('iubswdiuweidcuiuw');
  //   getCurrentWeather();
  // }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      // setState(() {
      //   isLoading = true;
      // });
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=Vijayawada&APPID=373f18dc29ddbd864e3712b6d95e015b'));
      print(response);
      final data = jsonDecode(response.body);
      if (data['cod'] != '200') {
        throw "status code is not-ok";
      }

      return data;
      // setState(() {
      //   temp = data['list'][0]['main']['temp'];
      //   isLoading = false;
      // });
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather app",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <IconButton>[
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
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          print(snapshot);
          print(context);
          print(snapshot.runtimeType);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentWindSpeed = data['list'][0]['wind']['speed'];
          final currentHumidity = data['list'][0]['main']['humidity'];

          return Center(
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
                                  '$currentTemp k',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Icon(
                                  currentSky == "Clouds" || currentSky == "Rain"
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 64,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  currentSky.toString(),
                                  style: const TextStyle(
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
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: <HourlyForecastItem>[
                  //       for (int i = 0; i < 5; i++)
                  //         HourlyForecastItem(
                  //           icon: Icons.cloud,
                  //           temprature:
                  //               data['list'][i + 1]['main']['temp'].toString(),
                  //           time: data['list'][i + 1]['dt'].toString(),
                  //         ),
                  //     ],
                  //   ),
                  // ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      AdditionalInformationWeget(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: currentHumidity.toString(),
                      ),
                      AdditionalInformationWeget(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: currentWindSpeed.toString(),
                      ),
                      AdditionalInformationWeget(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: currentPressure.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
