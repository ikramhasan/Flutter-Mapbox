import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_test/keys/key.dart';
import 'package:mapbox_test/utils/config.helper.dart';
import 'package:mapbox_test/utils/location.helper.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: loadConfigFile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final token = snapshot.data['mapbox_api_token'] as String;
              return MapboxMap(
                minMaxZoomPreference: MinMaxZoomPreference(2, 20),
                accessToken: token,
                initialCameraPosition: CameraPosition(
                  target: LatLng(33,31),
                ),
                onMapCreated: (controller) async {
                  final location = await getCurrentLocation();
                  final animateCameraResult = await controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 14.0,
                        target: location,
                      ),
                    ),
                  );

                  if (animateCameraResult) {
                    controller.addCircle(
                      CircleOptions(
                        circleRadius: 10,
                        circleStrokeColor: '#420C09',
                        circleStrokeWidth: 2.0,
                        draggable: false,
                        circleColor: '#D21404',
                        geometry: location,
                      ),
                    );
                  }
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
