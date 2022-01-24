
import 'dart:convert';

import 'package:blocweatherapp/model/weather_model.dart';
import 'package:http/http.dart' as http;

class ApiService{
  
  Future<http.Response> getWeather(String cityName) async{
    final response =
        await http.Client().get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=43ea6baaad7663dc17637e22ee6f78f2"));

    if(response.statusCode == 200){

      return response;
    }else{
      throw Exception();
    }
  }
}