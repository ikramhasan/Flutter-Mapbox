class GeocodingModel {
  double latitude;
  double longitude;
  String placeName;

  GeocodingModel({
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.placeName = '',
  });

  GeocodingModel.fromJson(Map<String, dynamic> json) {
    List<double> coordinates = json['query'] as List<double>;
    this.latitude = coordinates.first;
    this.longitude = coordinates.last;
    this.placeName = json['features'][0]['place_name'] as String;
  }
}
