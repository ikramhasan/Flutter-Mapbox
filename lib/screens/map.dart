import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_test/blocs/geocoding.bloc.dart';
import 'package:mapbox_test/blocs/geocoding.event.dart';
import 'package:mapbox_test/blocs/geocoding.state.dart';
import 'package:mapbox_test/utils/config.helper.dart';
import 'package:mapbox_test/utils/location.helper.dart';

class MapScreen extends StatelessWidget {
  final String mapStyle;

  const MapScreen({this.mapStyle});

  @override
  Widget build(BuildContext context) {
    void _onCircleTapped(Circle circle) async {
      final latlng = await getCurrentLocation();
      BlocProvider.of<GeocodingBloc>(context)
        ..add(
          RequestGeocodingEvent(
            latlng.latitude,
            latlng.longitude,
          ),
        );
      _showBottomModalSheet(context);
    }

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: loadConfigFile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final token = snapshot.data['mapbox_api_token'] as String;
              return MapboxMap(
                styleString: mapStyle,
                minMaxZoomPreference: MinMaxZoomPreference(2, 20),
                accessToken: token,
                initialCameraPosition: CameraPosition(
                  target: LatLng(33, 31),
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
                    controller.onCircleTapped
                        .add(_onCircleTapped);
                  }
                },
                // onMapClick: (Point<double> point, LatLng latlng) {
                //  BlocProvider.of<GeocodingBloc>(context)
                //    ..add(
                //      RequestGeocodingEvent(
                //        latlng.latitude,
                //        latlng.longitude,
                //      ),
                //    );
                //  _showBottomModalSheet(context);
                // },
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

void _showBottomModalSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return BlocBuilder<GeocodingBloc, GeocodingState>(
        builder: (ctx, state) {
          if (state is LoadingGeocodingState) {
            return Container(
              height: 150,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SuccessfulGeocodingState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  ListTile(
                    title: Text('Coordinates'),
                    subtitle: Text(
                        '${state.data.latitude.toStringAsFixed(3)}/${state.data.longitude.toStringAsFixed(3)}'),
                  ),
                  ListTile(
                    title: Text('Name'),
                    subtitle: Text(state.data.placeName),
                  ),
                ],
              ),
            );
          } else if (state is FailedGeocodingState) {
            return ListTile(
              title: Text('Error'),
              subtitle: Text(state.error),
            );
          } else {
            return ListTile(
              title: Text('Error'),
              subtitle: Text('Unknown Error Occurred'),
            );
          }
        },
      );
    },
  );
}
