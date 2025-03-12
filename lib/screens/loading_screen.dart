import 'dart:convert';

import 'package:clima/screens/location.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const ipaKey = '18d9665ed98eabfd2e2efb24477af7eb';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;
  @override
  void initState() {
    super.initState();
    getLocation();
    getData();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    getData();
  }

  Future<void> getData() async {
    http.Response response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$ipaKey',
      ),
    );

    if (response.statusCode == 200) {
      String data = response.body;
      var lolongitude = jsonDecode(data)['weather'][0]['description'];
      var id = jsonDecode(data)['weather'][0]['id'];
      var temp = jsonDecode(data)['main']['temp'];
      var name = jsonDecode(data)['name'];
      print(longitude);
      print(latitude);
      print(id);
      print(temp);
      print(name);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () {
            getData();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
