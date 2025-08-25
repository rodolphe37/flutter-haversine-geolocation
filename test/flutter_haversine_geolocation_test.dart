import 'package:flutter_haversine_geolocation/flutter_haversine_geolocation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Ajout d’une localisation', () async {
    final manager = GeolocationManager(
      GeolocationOptions(
        distanceThreshold: 50,
        loadHistory: () async => null,
        saveHistory: (history) async {},
      ),
    );

    await manager.init();

    await manager.addLocation(
      TLocation(
        coords: TCoords(
          accuracy: 5,
          altitude: 30,
          altitudeAccuracy: 1,
          heading: 0,
          latitude: 48.8566,
          longitude: 2.3522,
          speed: 0,
        ),
        mocked: false,
        timestamp: DateTime.now(),
      ),
    );

    expect(manager.history.locations.length, 1);
  });
}
