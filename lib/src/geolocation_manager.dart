import 'types.dart';
import 'utils.dart';

class GeolocationManager {
  final int distanceThreshold;
  final Future<TLocationHistory?> Function() loadHistory;
  final Future<void> Function(TLocationHistory) saveHistory;

  TLocationHistory history = TLocationHistory();

  GeolocationManager(GeolocationOptions options)
    : distanceThreshold = options.distanceThreshold,
      loadHistory = options.loadHistory,
      saveHistory = options.saveHistory;

  /// Charger l’historique
  Future<void> init() async {
    final existing = await loadHistory();
    if (existing != null) {
      history = existing;
    }
  }

  /// Ajouter une nouvelle position
  Future<void> addLocation(TLocation newLocation) async {
    final updatedHistory = TLocationHistory(
      locations: List.from(history.locations),
    );

    final lastLocation = updatedHistory.locations.isNotEmpty
        ? updatedHistory.locations.last
        : null;

    bool isSameCoords = false;

    if (lastLocation != null) {
      final distance = getDistanceInMeters(
        lastLocation.coords.latitude,
        lastLocation.coords.longitude,
        newLocation.coords.latitude,
        newLocation.coords.longitude,
      );

      isSameCoords = distance < distanceThreshold;
    }

    if (isSameCoords && lastLocation != null) {
      // juste mise à jour du timestamp
      lastLocation.timestamp = newLocation.timestamp;
    } else {
      updatedHistory.locations.add(newLocation);
    }

    history = updatedHistory;
    await saveHistory(updatedHistory);
  }
}
