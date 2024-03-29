
class WeatherModel{
  final temp;
  final pressure;
  final humidity;
  final temp_max;
  final temp_min;

  WeatherModel({this.temp, this.pressure, this.humidity, this.temp_max, this.temp_min});

  double get getTemp => temp - 272.5;
  double get getTempMax => temp_max - 272.5;
  double get getTempMin => temp_min - 272.5;

  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(
      temp: json['temp'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      temp_max: json['temp_max'],
      temp_min: json['temp_min']
    );
  }
}