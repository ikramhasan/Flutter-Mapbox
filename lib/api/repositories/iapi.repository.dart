abstract class IApiRepository {
  Future<dynamic> performReverseGeocoding(
    double latitude,
    double longitude,
  );
}
