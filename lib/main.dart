import 'package:flutter/material.dart';
import 'package:flutter_background_location/flutter_background_location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String latitude = "waiting...";
  String longitude = "waiting...";
  String altitude = "waiting...";
  String accuracy = "waiting...";
  String bearing = "waiting...";
  String speed = "waiting...";

  int count = 0;

  @override
  void initState() {
    super.initState();

    FlutterBackgroundLocation.startLocationService();
    FlutterBackgroundLocation.getLocationUpdates((location) {
      setState(() {
        this.latitude = location.latitude.toString();
        this.longitude = location.longitude.toString();
        this.accuracy = location.accuracy.toString();
        this.altitude = location.altitude.toString();
        this.bearing = location.bearing.toString();
        this.speed = location.speed.toString();
        count++;
      });

      print("""
      Latitude:  $latitude
      Longitude: $longitude
      Altitude: $altitude
      Accuracy: $accuracy
      Bearing:  $bearing
      Speed: $speed
      """);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "$count\n\n\n$latitude\n$longitude",
              style: TextStyle(fontSize: 14, ),
            ),
          ],
        ),
      ),
    );
  }
}

