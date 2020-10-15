

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';
import 'package:background_location/notification.dart' as notif;
import 'package:flutter_background_location/flutter_background_location.dart';

const fetchBackground = "fetchBackground";

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        //Geolocator geoLocator = Geolocator()..forceAndroidLocationManager = true;
        Position userLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        notif.Notification notification = new notif.Notification();
        notification.showNotificationWithoutSound(userLocation);
        break;
    }
    return Future.value(true);
  });
}


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



  //
  // Timer timer;
  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }

  // checkForNewSharedLists() async{
  //
  //   Position userLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   notif.Notification notification = new notif.Notification();
  //   notification.showNotificationWithoutSound(userLocation);
  //
  //
  //
  // }



  // @override
  // void initState() {
  //   super.initState();
  //
  //   //timer = Timer.periodic(Duration(seconds: 20), (Timer t) => checkForNewSharedLists());
  //
  //   // We don't need it anymore since it will be executed in background
  //   //this._getUserPosition();
  //
  //   Workmanager.initialize(
  //     callbackDispatcher,
  //     isInDebugMode: true,
  //   );
  //
  //   Workmanager.registerPeriodicTask(
  //       "1",
  //       fetchBackground,
  //       frequency: Duration(minutes: 15),
  //   );
  // }

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
              "",
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}
