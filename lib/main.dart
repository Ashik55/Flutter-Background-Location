import 'package:flutter/material.dart';
import 'package:flutter_background_location/flutter_background_location.dart';
import 'package:location/location.dart';


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
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home:  MyHomePage(title: 'Flutter Location Demo'),

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

  final Location location = Location();
  bool _serviceEnabled;

  @override
  void initState() {
    super.initState();


    _checkService();

  }


  void myLocation(){
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



  Future<void> _checkService() async {
    final bool serviceEnabledResult = await location.serviceEnabled();
    setState(() {
      _serviceEnabled = serviceEnabledResult;
      print(_serviceEnabled);
    });

    if(_serviceEnabled){
      myLocation();
    }else{
      _requestService();
    }


  }

  Future<void> _requestService() async {
    if (_serviceEnabled == null || !_serviceEnabled) {
      final bool serviceRequestedResult = await location.requestService();
      setState(() {
        _serviceEnabled = serviceRequestedResult;
      });

      print(_serviceEnabled);


      if (!serviceRequestedResult) {
        return;
      }
      else{
        myLocation();
      }
    }
  }



  // void locationService() async{
  //
  // }
  // void start_Loc() async {
  //   if (await _checkLocationPermission()) {
  //     await locationService();
  //   } else {
  //     print('elseee');
  //     PermissionStatus permission =
  //         await LocationPermissions().requestPermissions();
  //     print(permission);
  //
  //     //PermissionStatus permission = await LocationPermissions().checkPermissionStatus();
  //
  //   }
  // }
  // void openLocationSetting() async {
  //   final AndroidIntent intent = new AndroidIntent(
  //     action: 'android.settings.LOCATION_SOURCE_SETTINGS',
  //   );
  //   await intent.launch();
  // }
  // Future<bool> _checkLocationPermission() async {
  //   final access = await LocationPermissions().checkPermissionStatus();
  //   switch (access) {
  //     case PermissionStatus.unknown:
  //     case PermissionStatus.denied:
  //       //do whn permission denied
  //
  //     case PermissionStatus.restricted:
  //       final permission = await LocationPermissions().requestPermissions(
  //         permissionLevel: LocationPermissionLevel.locationAlways,
  //       );
  //       if (permission == PermissionStatus.granted) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //       break;
  //     case PermissionStatus.granted:
  //       return true;
  //       break;
  //     default:
  //       return false;
  //       break;
  //   }
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
              "$count\n\n\n$latitude\n$longitude",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
