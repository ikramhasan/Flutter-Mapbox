import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mapbox_test/api/repositories/api.repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() => HttpOverrides.global = null);

  group(
    'mapbox api',
    () {
      test(
        'geocoding response',
        () async {
          final repository = ApiRepository.instance;
          final result = await repository.performReverseGeocoding(45.45, 45.45);
          print(result.toString());
          expect(result.placeName.isNotEmpty, true);
        },
      );
    },
  );
}
