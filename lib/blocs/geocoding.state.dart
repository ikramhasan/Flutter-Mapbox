import 'package:mapbox_test/api/models/geocoding.model.dart';

abstract class GeocodingState {
  const GeocodingState();
}

class InitialGeocodingState extends GeocodingState {}

class LoadingGeocodingState extends GeocodingState {}

class SuccessfulGeocodingState extends GeocodingState {
  final GeocodingModel data;

  const SuccessfulGeocodingState(this.data);
}

class FailedGeocodingState extends GeocodingState {
  final String error;

  const FailedGeocodingState({this.error = 'Failed to get data'});
}
