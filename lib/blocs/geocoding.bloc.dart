import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_test/api/repositories/api.repository.dart';
import 'package:mapbox_test/blocs/geocoding.event.dart';
import 'package:mapbox_test/blocs/geocoding.state.dart';

class GeocodingBloc extends Bloc<GeocodingEvent, GeocodingState> {
  final _repository = ApiRepository.instance;
  GeocodingBloc() : super(InitialGeocodingState());

  @override
  Stream<GeocodingState> mapEventToState(GeocodingEvent event) async* {
    if (event is RequestGeocodingEvent) {
      yield LoadingGeocodingState();

      final result = await _repository.performReverseGeocoding(
          event.latitude, event.longitude);

      if (result.placeName.isNotEmpty) {
        yield SuccessfulGeocodingState(result);
      } else {
        yield FailedGeocodingState(error: 'Failed to get data after api call');
      }
    } else {
      yield FailedGeocodingState();
    }
  }
}
