import 'package:blocweatherapp/model/weather_model.dart';
import 'package:blocweatherapp/repo/Weather_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WeatherEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchEvent extends WeatherEvents{
  String _cityName;

  FetchEvent(this._cityName);

  @override
  List<Object> get props => [_cityName];
}

class ResetEvent extends WeatherEvents{

}

class WeatherState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherNotSearchedState extends WeatherState{

}

class WeatherLoadingState extends WeatherState{

}

class WeatherLoadedState extends WeatherState{
  final weather;

  WeatherLoadedState({this.weather});

  WeatherModel get getWeather => weather;
}

class WeatherNotLoadedState extends WeatherState{

}

class WeatherBloc extends Bloc<WeatherEvents, WeatherState>{

  WeatherRepo _repo;

  WeatherBloc(this._repo) : super(WeatherNotSearchedState());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvents event) async*{
    // TODO: implement mapEventToState

    if(event is FetchEvent){
      yield WeatherLoadingState();

      try{
        final data = await _repo.getWeatherInfo(event._cityName);

        yield WeatherLoadedState(weather: data);
      }catch(e){
        print(e.toString());
        yield WeatherNotLoadedState();
      }
    }else if(event is ResetEvent){
      yield WeatherNotSearchedState();
    }
  }
}



