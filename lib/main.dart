import 'package:blocweatherapp/Bloc/weather_bloc.dart';
import 'package:blocweatherapp/model/weather_model.dart';
import 'package:blocweatherapp/repo/Weather_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc(WeatherRepo()),
        child: MyHomePage(),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder<WeatherBloc, WeatherState>(
      bloc: weatherBloc,
      builder: (context, state){
        if(state is WeatherNotSearchedState) return searchScreen(context);
        else if(state is WeatherLoadedState) return weatherResult(weather: state.getWeather, context: context);
        else if(state is WeatherLoadingState) return weatherError();
        else if(state is WeatherNotLoadedState) return weatherError();
        else return tryAgain(context);
      },
    );
  }

  Widget searchScreen(BuildContext context){

    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  Column(
        children: [
          SizedBox(
            height: 150.0,
          ),
          Center(
            child: Text(
              'Weather app',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Weather in touch!',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.all(3.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Enter city to search',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  focusColor: Colors.orangeAccent,
                  fillColor: Colors.white,
                  filled: true

              ),
              controller: _controller,
            ),
          ),
          Spacer(),
          Padding(
              padding: EdgeInsets.all(15.0),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  padding: EdgeInsets.all(15.0),
                  child: Center(
                    child: Text(
                      "Search for weather in your city",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                onTap: (){
                   weatherBloc.add(FetchEvent(_controller.text));
                },
              )
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }

  Widget weatherResult(
      {String city = "Anonymous",required WeatherModel weather,required BuildContext context}){

    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              city,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
                fontSize: 50.0
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  weather.temp_min.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                      fontSize: 20.0
                  ),
                ),
                Text(
                  weather.temp_max.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                      fontSize: 20.0
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => weatherBloc.add(ResetEvent()),
              child: Text("Try again"))
          ],
        ),
      ),
    );
  }

  Widget weatherError(){
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget tryAgain(BuildContext context){

    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'Try Again',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45.0
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: (){
                weatherBloc.add(ResetEvent());
              },
              child: Text("Try again"),
            )
          ],
        )
      ),
    );
  }
}
