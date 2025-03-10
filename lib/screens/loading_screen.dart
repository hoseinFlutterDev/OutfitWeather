import 'dart:convert';

import 'package:clima/screens/location.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  Future<void> getData() async {
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=2c11b0cef595b33b2bce2bf9d3c9de01';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // تبدیل پاسخ به JSON
        final data = jsonDecode(response.body);
        print('Weather Data: $data');
      } else {
        print(
          'Failed to load weather data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(onPressed: () {}, child: Text('Get Location')),
      ),
    );
  }
}
