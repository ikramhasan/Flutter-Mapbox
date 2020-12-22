abstract class GeocodingEvent {
  const GeocodingEvent();
}

class RequestGeocodingEvent extends GeocodingEvent {
  final double latitude;
  final double longitude;

  const RequestGeocodingEvent(this.latitude, this.longitude);
}
