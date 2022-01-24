
import 'dart:convert';

import 'package:blocweatherapp/Api_service/api_service.dart';
import 'package:blocweatherapp/model/weather_model.dart';
import 'package:http/http.dart';

class WeatherRepo{

  Future<WeatherModel> getWeatherInfo(String cityName) async{

    final response = await ApiService().getWeather(cityName);

    if(response.body != null){
      final decodedJson = jsonDecode(response.body);

      final data = decodedJson['main'];

      return WeatherModel.fromJson(data);
    }else{
      throw Exception();
    }
  }
}